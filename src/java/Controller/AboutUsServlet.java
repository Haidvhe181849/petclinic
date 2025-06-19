/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.AboutUsDAO;
import Entity.AboutUs;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.List;



/**
 *
 * @author trung123
 */
@WebServlet(name = "AboutUsServlet", urlPatterns = {"/AboutUsServlet"})
public class AboutUsServlet extends HttpServlet {
 AboutUsService service = new AboutUsService();
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AboutUsServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AboutUsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
       request.setAttribute("list", service.getAll());
        String role = request.getParameter("role"); // "admin" or "user"
        if ("admin".equals(role)) {
            request.getRequestDispatcher("/Presentation/ManageAboutUsAdmin.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/Presentation/ViewAboutUs.jsp").forward(request, response);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           String action = request.getParameter("action");

        int id = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                ? Integer.parseInt(request.getParameter("id"))
                : 0;

        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String hotline = request.getParameter("hotline");
        String description = request.getParameter("description");

        AboutUs about = new AboutUs(id, address, email, hotline, description);

        if (action != null) {
            switch (action) {
                case "add" -> service.insert(about);
                case "edit" -> service.update(about);
                case "delete" -> service.delete(id);
            }
        }

        response.sendRedirect("AboutUsServlet?role=admin");
    }
    }

    
    

