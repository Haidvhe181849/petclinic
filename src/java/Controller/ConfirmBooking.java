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
import java.sql.Connection;
import java.util.List;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ConfirmBooking", urlPatterns = {"/ConfirmBooking"})
public class ConfirmBooking extends HttpServlet {

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
        DBContext dbContext = new DBContext();
        Connection conn = null;
        conn = dbContext.connection;
        BookingDAO bDAO = new BookingDAO(conn);

        String service = request.getParameter("service");
        if (service == null || service.equals("listBooking") || service.equals("blist")) {
            String submit = request.getParameter("submit");
            String order = request.getParameter("order");
            List<BookingEx> blist;
            if (submit != null) {
                String id = request.getParameter("bookingId");
                id = id.trim().replaceAll("\\s+", "%");
                blist = bDAO.searchBookingById(id);
                request.setAttribute("bookingId", id);

            } else if (order != null && (order.equalsIgnoreCase("asc") || order.equalsIgnoreCase("desc"))) {
                blist = bDAO.getAllBookingSorted(order);
                request.setAttribute("order", order);

            } else {
                blist = bDAO.getAllBooking();
            }

            request.setAttribute("blist", blist);
            request.getRequestDispatcher("Presentation/BookingManagerment.jsp").forward(request, response);
        }
        if ("updateStatus".equals(service)) {
            String bookingId = request.getParameter("bookingId");
            String newStatus = request.getParameter("status");
            String cancelReason = null;

            if ("Failed".equals(newStatus)) {
                cancelReason = request.getParameter("cancelReason");
            }

            bDAO.updateBookingStatus(bookingId, newStatus, cancelReason);
            request.getSession().setAttribute("message", "Updated successfully!");
            response.sendRedirect("ConfirmBooking?service=listBooking");
        }

        if ("bookingDetail".equals(service)) {
            String bookingId = request.getParameter("bookingId");
            BookingDetail detail = bDAO.getBookingDetailById(bookingId);

            List<BookingEx> blist = bDAO.getAllBooking();

            request.setAttribute("blist", blist);
            request.setAttribute("bookingDetail", detail);
            request.getRequestDispatcher("Presentation/BookingManagerment.jsp").forward(request, response);
        }

        if ("deleteBooking".equals(service)) {
            String bookingId = request.getParameter("bookingId");
            int result = bDAO.deleteBooking(bookingId);
            if (result > 0) {
                request.getSession().setAttribute("message", "Xóa booking thành công!");
            } else {
                request.getSession().setAttribute("message", "Xóa booking thất bại! Vui lòng thử lại.");
            }
            request.getSession().setAttribute("message", "Deleted successful!");
            request.getRequestDispatcher("ConfirmBooking?service=listBooking").forward(request, response);
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
