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
import Entity.Employee;
import Entity.UserAccount;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.List;

/**
 *
 * @author trung123
 */
@WebServlet(name = "AboutUsServlet", urlPatterns = {"/manage-about-us"})
public class AboutUsServlet extends HttpServlet {

    private AboutUsDAO dao = new AboutUsDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
//        HttpSession session = request.getSession();
//        Employee currentStaff = (Employee) session.getAttribute("staff");
//        if (currentStaff == null) {
//            response.sendRedirect("login-employee");
//            return;
//        }
        String action = request.getParameter("action");

        if (action != null && action.equals("delete")) {
            String about_id = request.getParameter("id");
            if (about_id != null && !about_id.isEmpty()) {
                dao.delete(about_id);
                request.setAttribute("message", "About Us entry deleted successfully");
                response.sendRedirect("manage-about-us");
                return;
            }
        } else if (action != null && action.equals("edit")) {
            String about_id = request.getParameter("id");
            if (about_id != null && !about_id.isEmpty()) {
                AboutUs aboutUs = dao.getById(about_id);
                if (aboutUs != null) {
                    request.setAttribute("aboutUs", aboutUs);
                }
            }
        }

        // Get all AboutUs entries for display
        request.setAttribute("list", dao.getAll());
        request.getRequestDispatcher("/Presentation/ManageAboutUsAdmin.jsp").forward(request, response);
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
        String action = request.getParameter("action");

        // Get form data
        String about_id = request.getParameter("about_id");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String description = request.getParameter("description");

        AboutUs about = new AboutUs(about_id, address, email, phone, description);

        String message = "";

        if (action != null) {
            switch (action) {
                case "add" -> {
                    dao.insert(about);
                    message = "About Us information added successfully";
                }
                case "edit" -> {
                    dao.update(about);
                    message = "About Us information updated successfully";
                }
                case "delete" -> {
                    dao.delete(about_id);
                    message = "About Us information deleted successfully";
                }
            }
        }

        request.setAttribute("message", message);
        response.sendRedirect("manage-about-us");
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
