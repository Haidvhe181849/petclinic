/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BookingDAO;
import DAO.FeedbackDAO;
import Entity.Booking;
import Entity.Feedback;
import Entity.UserAccount;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import Utility.DBContext;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "FeedbackServlet", urlPatterns = {"/FeedbackServlet"})
public class FeedbackServlet extends HttpServlet {

    private FeedbackDAO feedbackDAO;
    private BookingDAO bookingDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        try {
            // Initialize DAOs with connection from DBContext
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.connection;
            feedbackDAO = new FeedbackDAO(conn);
            bookingDAO = new BookingDAO(conn);
        } catch (Exception e) {
            throw new ServletException("Error initializing DAOs", e);
        }
    }

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
        UserAccount user = (UserAccount) session.getAttribute("user");
        
        if (user == null) {
            session.setAttribute("message", "Bạn cần đăng nhập để sử dụng chức năng này.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("create".equals(action)) {
            String bookingId = request.getParameter("bookingId");
            
            if (bookingId == null || bookingId.isEmpty()) {
                session.setAttribute("message", "Không tìm thấy thông tin đặt lịch.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if booking exists and belongs to the user
            Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking == null || booking.getUserId() != user.getUserId()) {
                session.setAttribute("message", "Bạn không có quyền đánh giá lịch khám này.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if booking status is Complete
            if (!"Confirmed".equals(booking.getStatus())) {
                session.setAttribute("message", "Chỉ có thể đánh giá các lịch khám đã hoàn thành.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if feedback already exists
            if (feedbackDAO.hasBookingFeedback(bookingId)) {
                Feedback existingFeedback = feedbackDAO.getFeedbackByBookingId(bookingId);
                request.setAttribute("feedback", existingFeedback);
                request.setAttribute("booking", booking);
                request.setAttribute("mode", "view");
                request.getRequestDispatcher("/Presentation/FeedbackForm.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("booking", booking);
            request.setAttribute("mode", "create");
            request.getRequestDispatcher("/Presentation/FeedbackForm.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/ViewBooking");
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
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");
        
        if (user == null) {
            session.setAttribute("message", "Bạn cần đăng nhập để sử dụng chức năng này.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if ("submit".equals(action)) {
            String bookingId = request.getParameter("bookingId");
            String feedbackText = request.getParameter("feedbackText");
            int starRating = Integer.parseInt(request.getParameter("starRating"));
            
            // Validate input
            if (bookingId == null || bookingId.isEmpty() || feedbackText == null || feedbackText.isEmpty() || starRating < 1 || starRating > 5) {
                session.setAttribute("message", "Vui lòng điền đầy đủ thông tin đánh giá.");
                response.sendRedirect(request.getContextPath() + "/FeedbackServlet?action=create&bookingId=" + bookingId);
                return;
            }
            
            // Check if booking exists and belongs to the user
            Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking == null || booking.getUserId() != user.getUserId()) {
                session.setAttribute("message", "Bạn không có quyền đánh giá lịch khám này.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if booking status is Complete
            if (!"Confirmed".equals(booking.getStatus())) {
                session.setAttribute("message", "Chỉ có thể đánh giá các lịch khám đã hoàn thành.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if feedback already exists
            if (feedbackDAO.hasBookingFeedback(bookingId)) {
                session.setAttribute("message", "Bạn đã đánh giá lịch khám này rồi.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Create new feedback
            Feedback feedback = new Feedback();
            feedback.setUserId(user.getUserId());
            feedback.setBookingId(bookingId);
            feedback.setFeedbackText(feedbackText);
            feedback.setPostTime(new Timestamp(new Date().getTime()));
            feedback.setStarRating(starRating);
            feedback.setVisible(true);
            
            boolean success = feedbackDAO.addFeedback(feedback);
            
            if (success) {
                session.setAttribute("message", "Cảm ơn bạn đã đánh giá dịch vụ của chúng tôi!");
            } else {
                session.setAttribute("message", "Có lỗi xảy ra khi gửi đánh giá. Vui lòng thử lại sau.");
            }
            
            response.sendRedirect(request.getContextPath() + "/ViewBooking");
        } else {
            response.sendRedirect(request.getContextPath() + "/ViewBooking");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to handle customer feedback";
    }
} 