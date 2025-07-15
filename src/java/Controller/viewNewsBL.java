/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.NewsDAO;
import DAO.ServiceDAO;
import Entity.News;
import Entity.Service;
import Utility.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.util.Vector;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "viewNewsBL", urlPatterns = {"/viewNews"})
public class viewNewsBL extends HttpServlet {

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
        DBContext db = new DBContext();
        Connection conn = db.connection;
        ServiceDAO sDAO = new ServiceDAO(conn);
        NewsDAO nDAO = new NewsDAO();

        String service = request.getParameter("service");
        if (service == null || service.equals("listNews") || service.equals("nlist")) {
            String submit = request.getParameter("submit");
            Vector<News> nlist;
            Vector<News> lastNews = nDAO.getLatestNews();
            Vector<Service> slist = sDAO.getAllService("Select*from Service");
            if (submit != null) {
                String name = request.getParameter("name");
                nlist = nDAO.searchNews("Select*from News\n"
                        + "Where nameNews like N'%" + name + "%'");
                request.setAttribute("nameNews", name);
            } else {
                nlist = nDAO.getAllNews();
            }
            request.setAttribute("slist", slist);
            request.setAttribute("nlist", nlist);
            request.setAttribute("top5News", lastNews);
            request.getRequestDispatcher("Presentation/viewNews.jsp").forward(request, response);
        }
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
        processRequest(request, response);
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
