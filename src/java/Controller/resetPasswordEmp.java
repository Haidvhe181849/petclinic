/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.EmployeeDAO;
import Entity.Employee;
import Utility.DBContext;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "resetPasswordEmp", urlPatterns = {"/change-password-employee"})
public class resetPasswordEmp extends HttpServlet {

    private EmployeeDAO getEmployeeDAO() {
        Connection conn = new DBContext().connection;
        return new EmployeeDAO(conn);
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
        request.getRequestDispatcher("/Presentation/ResetPasswordEmployee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Employee currentStaff = (Employee) session.getAttribute("staff");

        if (currentStaff == null) {
            response.sendRedirect("login-employee");
            return;
        }

        String currentPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!currentStaff.getPassword().equals(currentPassword)) {
            request.setAttribute("changeStatus", "error");
            request.setAttribute("changeMessage", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/Presentation/ResetPasswordEmployee.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("changeStatus", "error");
            request.setAttribute("changeMessage", "Mật khẩu mới không khớp.");
            request.getRequestDispatcher("/Presentation/ResetPasswordEmployee.jsp").forward(request, response);
            return;
        }

// Đổi mật khẩu
        EmployeeDAO dao = getEmployeeDAO();
        dao.updatePassword(currentStaff.getEmployeeId(), newPassword);
        currentStaff.setPassword(newPassword);
        session.setAttribute("staff", currentStaff);

        request.setAttribute("changeStatus", "success");
        request.setAttribute("changeMessage", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher("/Presentation/ResetPasswordEmployee.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
