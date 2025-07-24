package Controller;

import DAO.BookingDAO;
import DAO.RateDoctorDAO;
import Entity.Booking;
import Entity.RateDoctor;
import Entity.UserAccount;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Date;
import Utility.DBContext;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "RateDoctorServlet", urlPatterns = {"/RateDoctorServlet"})
public class RateDoctorServlet extends HttpServlet {

    private RateDoctorDAO rateDoctorDAO;
    private BookingDAO bookingDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        try {
            // Initialize DAOs with connection from DBContext
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.connection;
            rateDoctorDAO = new RateDoctorDAO(conn);
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
                session.setAttribute("message", "Bạn không có quyền đánh giá bác sĩ này.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if booking status is Confirmed
            if (!"Confirmed".equals(booking.getStatus())) {
                session.setAttribute("message", "Chỉ có thể đánh giá bác sĩ sau khi hoàn thành khám.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if employee is assigned
            if (booking.getEmployeeId() == null || booking.getEmployeeId().isEmpty()) {
                session.setAttribute("message", "Lịch khám này chưa được phân công bác sĩ.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if user has already rated this doctor for this booking
            if (rateDoctorDAO.hasUserRatedDoctor(user.getUserId(), booking.getEmployeeId(), bookingId)) {
                // Get existing rating and show in view-only mode
                RateDoctor existingRating = rateDoctorDAO.getRatingByUserAndBooking(user.getUserId(), booking.getEmployeeId(), bookingId);
                request.setAttribute("booking", booking);
                request.setAttribute("existingRating", existingRating);
                request.setAttribute("isViewOnly", true);
                request.getRequestDispatcher("/Presentation/RateDoctorForm.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/Presentation/RateDoctorForm.jsp").forward(request, response);
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
            String employeeId = request.getParameter("employeeId");
            String commentText = request.getParameter("commentText");
            int starRating = Integer.parseInt(request.getParameter("starRating"));
            
            // Validate input
            if (bookingId == null || bookingId.isEmpty() || employeeId == null || employeeId.isEmpty() || 
                starRating < 1 || starRating > 5) {
                session.setAttribute("message", "Vui lòng điền đầy đủ thông tin đánh giá.");
                response.sendRedirect(request.getContextPath() + "/RateDoctorServlet?action=create&bookingId=" + bookingId);
                return;
            }
            
            // Check if booking exists and belongs to the user
            Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking == null || booking.getUserId() != user.getUserId()) {
                session.setAttribute("message", "Bạn không có quyền đánh giá bác sĩ này.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if booking status is Confirmed
            if (!"Confirmed".equals(booking.getStatus())) {
                session.setAttribute("message", "Chỉ có thể đánh giá bác sĩ sau khi hoàn thành khám.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Check if user has already rated this doctor for this booking
            if (rateDoctorDAO.hasUserRatedDoctor(user.getUserId(), employeeId, bookingId)) {
                session.setAttribute("message", "Bạn đã đánh giá bác sĩ này rồi.");
                response.sendRedirect(request.getContextPath() + "/ViewBooking");
                return;
            }
            
            // Create new rating
            RateDoctor rating = new RateDoctor();
            rating.setUserId(user.getUserId());
            rating.setEmployeeId(employeeId);
            rating.setRating(starRating);
            rating.setComment(commentText);
            rating.setRateTime(new Timestamp(new Date().getTime()));
            
            boolean success = rateDoctorDAO.addRating(rating);
            
            if (success) {
                session.setAttribute("message", "Cảm ơn bạn đã đánh giá bác sĩ!");
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
        return "Servlet to handle doctor ratings";
    }
} 