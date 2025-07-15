/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BookingDAO;
import Entity.BookingDetail;
import Utility.DBContext;
import Entity.BookingEx;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp; // Dùng class này để xử lý thời gian trong SQL
import java.sql.Connection;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ConfirmBooking", urlPatterns = {"/ConfirmBooking"})
public class ConfirmBooking extends HttpServlet {

    private BookingDAO getBookingDAO() {
        return new BookingDAO(new DBContext().connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String service = request.getParameter("service");
        BookingDAO bDAO = getBookingDAO();

        try {
            if (service == null || service.equals("listBooking") || service.equals("blist")) {
                String bookingId = Optional.ofNullable(request.getParameter("bookingId")).orElse("").trim();
                String status = request.getParameter("status");
                String order = Optional.ofNullable(request.getParameter("order")).orElse("desc");

                String fromDateStr = request.getParameter("fromDate");
                String toDateStr = request.getParameter("toDate");
                Timestamp from = null, to = null;
                try {
                    if (fromDateStr != null && !fromDateStr.isEmpty()) {
                        from = Timestamp.valueOf(LocalDate.parse(fromDateStr).atStartOfDay());
                    }
                    if (toDateStr != null && !toDateStr.isEmpty()) {
                        to = Timestamp.valueOf(LocalDate.parse(toDateStr).atTime(23, 59, 59));
                    }
                } catch (Exception ignored) {
                }

                List<BookingEx> blist = bDAO.getFilteredBookings(bookingId, status, order, from, to);
                request.setAttribute("blist", blist);
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("status", status);
                request.setAttribute("order", order);
                request.setAttribute("fromDate", fromDateStr);
                request.setAttribute("toDate", toDateStr);
                request.setAttribute("currentPage", "booking");
                request.getRequestDispatcher("Presentation/BookingManagerment.jsp").forward(request, response);

            } else if ("bookingDetail".equals(service)) {
                String bookingId = request.getParameter("bookingId");
                BookingDetail detail = bDAO.getBookingDetailById(bookingId);
                List<BookingEx> blist = bDAO.getAllBooking();

                request.setAttribute("blist", blist);
                request.setAttribute("bookingDetail", detail);
                request.setAttribute("currentPage", "booking");
                request.getRequestDispatcher("Presentation/BookingManagerment.jsp").forward(request, response);

            } else if ("deleteBooking".equals(service)) {
                String bookingId = request.getParameter("bookingId");
                int result = bDAO.deleteBooking(bookingId);
                String msg = (result > 0) ? "Xóa booking thành công!" : "Xóa booking thất bại!";
                request.getSession().setAttribute("message", msg);
                response.sendRedirect("ConfirmBooking?service=listBooking");
            }

        } catch (Exception e) {
            throw new ServletException("Lỗi GET ConfirmBooking: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String service = request.getParameter("service");
        BookingDAO bDAO = getBookingDAO();

        try {
            if ("updateStatus".equals(service)) {
                String bookingId = request.getParameter("bookingId");
                String newStatus = request.getParameter("status");
                String cancelReason = "Failed".equals(newStatus) ? request.getParameter("cancelReason") : null;

                bDAO.updateBookingStatus(bookingId, newStatus, cancelReason);
                request.getSession().setAttribute("message", "Cập nhật trạng thái thành công!");
                response.sendRedirect("ConfirmBooking?service=listBooking");
            }
        } catch (Exception e) {
            throw new ServletException("Lỗi POST ConfirmBooking: " + e.getMessage(), e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet quản lý xác nhận booking";
    }
}
