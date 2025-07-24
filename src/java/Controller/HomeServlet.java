/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.DoctorDAO;
import DAO.NewsDAO;
import static DAO.NewsDAO.stripHtml;
import DAO.ServiceDAO;
import Entity.Employee;
import Entity.News;
import Entity.Service;
import Utility.DBContext;
import java.sql.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/Home"})
public class HomeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = new DBContext().connection) {
            ServiceDAO sDAO = new ServiceDAO(conn);
            DoctorDAO dDAO = new DoctorDAO(conn);
            NewsDAO nDAO = new NewsDAO();
            Vector<Service> slist = sDAO.getAllService("SELECT * FROM Service WHERE status = 1");
            List<Employee> dlist = dDAO.getAllDoctors1();
            Vector<News> top3News = nDAO.getTop3News();
            for (News r : top3News) {
                r.setDescription(stripHtml(r.getDescription())); // Lưu bản cleaned
            }
            // Gửi dữ liệu sang JSP
            request.setAttribute("slist", slist);
            request.setAttribute("dlist", dlist);
            request.setAttribute("top3News", top3News);
            request.getRequestDispatcher("Presentation/Home.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách dịch vụ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Home page loader - loads service list and forwards to Home.jsp";
    }

}
