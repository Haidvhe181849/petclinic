/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BookingDAO;
import DAO.DoctorDAO;
import DAO.PetDAO;
import DAO.UserDAO;
import Entity.Booking;
import Entity.UserAccount;
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
import java.util.List;

/**
 *
 * @author quang
 */
@WebServlet(name = "ManagerBooking", urlPatterns = {"/ManagerBooking"})
public class ManagerBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("Presentation/Login.jsp");
            return;
        }

        try (Connection conn = new DBContext().connection) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            UserDAO userDAO = new UserDAO();
            DoctorDAO doctorDAO = new DoctorDAO(conn);
            PetDAO petDAO = new PetDAO(conn);

            // Lấy lại thông tin người dùng
            UserAccount userInfo = userDAO.getUserById(user.getUserId());
            request.setAttribute("userInfo", userInfo);

            // Lấy tham số lọc
            String keyword = request.getParameter("keyword");
            if (keyword != null) {
                keyword = keyword.trim();
            }
            String status = request.getParameter("status");
            String pageRaw = request.getParameter("page");

            int page = 1;
            int pageSize = 5;

            try {
                page = (pageRaw != null && !pageRaw.isEmpty()) ? Integer.parseInt(pageRaw) : 1;
            } catch (NumberFormatException e) {
                page = 1; // fallback nếu page không hợp lệ
            }

            int offset = (page - 1) * pageSize;

            List<Booking> bookings;
            int totalBookings;

           



            // Dữ liệu phụ trợ cho form modal
            request.setAttribute("employeeList", doctorDAO.getAllDoctors());
            request.setAttribute("petList", petDAO.getPetsByOwnerId(user.getUserId()));

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải lịch hẹn: " + e.getMessage());
        }

        request.getRequestDispatcher("Presentation/BookingManagerment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
