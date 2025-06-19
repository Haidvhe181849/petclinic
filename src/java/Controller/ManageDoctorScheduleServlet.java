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
import DAO.DoctorScheduleDAO;
import Entity.Booking;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author trung123
 */
@WebServlet("/doctor/manage-schedule")
public class ManageDoctorScheduleServlet extends HttpServlet {
DoctorScheduleDAO dao = new DoctorScheduleDAO();
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
            out.println("<title>Servlet ManageDoctorScheduleServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageDoctorScheduleServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String doctorId = (String) session.getAttribute("doctorId");
        if (doctorId == null) {
            response.sendRedirect("/login.jsp"); // nếu chưa đăng nhập
            return;
        }

        if (action == null || action.equals("view")) {
            List<Booking> schedule = dao.getDoctorSchedule(doctorId);
            request.setAttribute("schedule", schedule);
            request.getRequestDispatcher("/doctor/doctor_schedule.jsp").forward(request, response);
        } else if (action.equals("history")) {
            List<Booking> history = dao.getHistorySchedules(doctorId);
            request.setAttribute("history", history);
            request.getRequestDispatcher("/doctor/doctor_schedule.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "❗ Action không hợp lệ.");
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
         String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        String message = "";

        if ("accept".equals(action)) {
            dao.updateStatus(bookingId, "Đang khám");
            message = "✅ Lịch khám đã được chấp nhận.";
        } else if ("decline".equals(action)) {
            dao.updateStatus(bookingId, "Không nhận");
            message = "❌ Lịch khám đã bị từ chối.";
        }

        request.getSession().setAttribute("message", message);
        response.sendRedirect(request.getContextPath() + "/doctor/manage-schedule?action=view");
    }
    
}  

