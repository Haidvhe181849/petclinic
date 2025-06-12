/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.ServiceDAO;
import Entity.Service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.Vector;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "Service", urlPatterns = {"/Service"})
public class ServiceServlet extends HttpServlet {

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
        ServiceDAO sDAO = new ServiceDAO();

        String service = request.getParameter("service");
        if (service == null || service.equals("listService") || service.equals("slist")) {
            String submit = request.getParameter("submit");
            String order = request.getParameter("order");
            if (order == null || (!order.equalsIgnoreCase("asc") && !order.equalsIgnoreCase("desc"))) {
                order = "desc";
            }
            Vector<Service> slist;
            if (submit != null) {
                String name = request.getParameter("name");
                name = name.trim().replaceAll("\\s+", "%");
                slist = sDAO.searchService("Select*from Service\n"
                        + "Where service_name like N'%" + name + "%'");
                request.setAttribute("service_name", name);
            } else {
                String sql = "SELECT * FROM Service ORDER BY price " + order;
                slist = sDAO.getAllService(sql);
            }

            request.setAttribute("slist", slist);
            request.setAttribute("order", order);
            request.getRequestDispatcher("Presentation/NewsManagerment.jsp").forward(request, response);
        }

        if ("addService".equals(service)) {
            String submit = request.getParameter("submit");
            if (submit == null) {
                response.sendRedirect("News.jsp");
            } else {
                String service_id = sDAO.generateNextServiceId(); // tự sinh ID
                String service_name = request.getParameter("service_name");
                Double price = Double.valueOf(request.getParameter("price"));
                String description = request.getParameter("description");

                Service s = new Service(service_name, price, description);
                sDAO.insertService(s);

                request.getSession().setAttribute("message", "Added successful!");
                response.sendRedirect("Service?service=listService");
            }
        }

        if (service.equals("deleteService")) {
            String service_id = request.getParameter("sID");
            int s = sDAO.deleteService(service_id);
            request.getSession().setAttribute("message", "Deleted successful!");
            response.sendRedirect("Service?service=listService");

        }

        if ("updateService".equals(service)) {
            String submit = request.getParameter("submit");
            if (submit == null) {
                response.sendRedirect("Service.jsp");
            } else {
                String service_id = request.getParameter("service_id");
                String service_name = request.getParameter("service_name");
                Double price = Double.valueOf(request.getParameter("price"));
                String description = request.getParameter("description");
                
                Service s = new Service(service_id, service_name, price, description);
                sDAO.updateService(s);
                request.getSession().setAttribute("message", "Update successful!");
                response.sendRedirect("Service?service=listService");
            }
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
