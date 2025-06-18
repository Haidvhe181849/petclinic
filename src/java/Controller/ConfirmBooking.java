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
                String sql = "SELECT \n"
                        + "    b.booking_id,\n"
                        + "    ua.name AS customer_name,\n"
                        + "    p.name AS pet_name,\n"
                        + "    at.type_name AS pet_type,\n"
                        + "    s.service_name,\n"
                        + "    e.name AS employee_name,\n"
                        + "    b.booking_time,\n"
                        + "    b.status\n"
                        + "FROM Booking b\n"
                        + "JOIN UserAccount ua ON b.user_id = ua.user_id\n"
                        + "JOIN Pet p ON b.pet_id = p.pet_id\n"
                        + "JOIN AnimalType at ON p.pet_type_id = at.animal_type_id\n"
                        + "JOIN Service s ON b.service_id = s.service_id\n"
                        + "JOIN Employee e ON b.employee_id = e.employee_id\n"
                        + "ORDER BY b.booking_time " + order;

                blist = bDAO.getAllBooking(sql);
                request.setAttribute("order", order); 
            } else {
                blist = bDAO.getAllBooking("SELECT \n"
                        + "    b.booking_id,\n"
                        + "    ua.name AS customer_name,\n"
                        + "    p.name AS pet_name,\n"
                        + "    at.type_name AS pet_type,\n"
                        + "    s.service_name,\n"
                        + "    e.name AS employee_name,\n"
                        + "    b.booking_time,\n"
                        + "    b.status\n"
                        + "FROM Booking b\n"
                        + "JOIN UserAccount ua ON b.user_id = ua.user_id\n"
                        + "JOIN Pet p ON b.pet_id = p.pet_id\n"
                        + "JOIN AnimalType at ON p.pet_type_id = at.animal_type_id\n"
                        + "JOIN Service s ON b.service_id = s.service_id\n"
                        + "JOIN Employee e ON b.employee_id = e.employee_id;");
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

            List<BookingEx> blist = bDAO.getAllBooking("SELECT \n"
                    + "    b.booking_id,\n"
                    + "    ua.name AS customer_name,\n"
                    + "    p.name AS pet_name,\n"
                    + "    at.type_name AS pet_type,\n"
                    + "    s.service_name,\n"
                    + "    e.name AS employee_name,\n"
                    + "    b.booking_time,\n"
                    + "    b.status\n"
                    + "FROM Booking b\n"
                    + "JOIN UserAccount ua ON b.user_id = ua.user_id\n"
                    + "JOIN Pet p ON b.pet_id = p.pet_id\n"
                    + "JOIN AnimalType at ON p.pet_type_id = at.animal_type_id\n"
                    + "JOIN Service s ON b.service_id = s.service_id\n"
                    + "JOIN Employee e ON b.employee_id = e.employee_id;");

            request.setAttribute("blist", blist);
            request.setAttribute("bookingDetail", detail);
            request.getRequestDispatcher("Presentation/BookingManagerment.jsp").forward(request, response);
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
