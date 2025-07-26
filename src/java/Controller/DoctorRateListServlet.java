package Controller;

import DAO.RateDoctorDAO;
import Entity.RateDoctor;
import Entity.Employee;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.util.List;
import Utility.DBContext;

/**
 * Servlet for doctor rate list management (role = 3)
 */
@WebServlet(name = "DoctorRateListServlet", urlPatterns = {"/doctor-rate-list"})
public class DoctorRateListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Employee employee = (Employee) session.getAttribute("employee");
        
        // Check if employee is logged in
        if (employee == null) {
            response.sendRedirect(request.getContextPath() + "/Presentation/LoginEmployee.jsp");
            return;
        }

        // Check if employee has role = 3 (doctor)
        if (employee.getRoleId() != 3) {
            session.setAttribute("message", "Bạn không có quyền truy cập trang này.");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try (Connection conn = new DBContext().connection) {
            RateDoctorDAO rateDoctorDAO = new RateDoctorDAO(conn);

            // Set employee info for display
            request.setAttribute("employee", employee);
            
            // Get filtering parameters
            String keyword = request.getParameter("keyword");
            if (keyword != null) {
                keyword = keyword.trim();
            }
            String order = request.getParameter("order");
            if (order == null || order.isEmpty()) {
                order = "desc"; // default order
            }

            // Get ratings for this doctor
            List<RateDoctor> ratings = rateDoctorDAO.getRatingsByDoctor(employee.getEmployeeId());
            
            // Filter by keyword if provided
            if (keyword != null && !keyword.isEmpty()) {
                List<RateDoctor> filteredRatings = new java.util.ArrayList<>();
                for (RateDoctor r : ratings) {
                    String userName = (r.getUserName() != null) ? r.getUserName().toLowerCase() : "";
                    String comment = (r.getComment() != null) ? r.getComment().toLowerCase() : "";
                    String bookingId = (r.getBookingId() != null) ? r.getBookingId().toLowerCase() : "";
                    String keywordLower = keyword.toLowerCase();
                    
                    if (userName.contains(keywordLower) || 
                        comment.contains(keywordLower) || 
                        bookingId.contains(keywordLower)) {
                        filteredRatings.add(r);
                    }
                }
                ratings = filteredRatings;
            }
            
            // Sort by order
            if ("asc".equals(order)) {
                ratings.sort((a, b) -> {
                    if (a.getRateTime() == null && b.getRateTime() == null) return 0;
                    if (a.getRateTime() == null) return 1;
                    if (b.getRateTime() == null) return -1;
                    return a.getRateTime().compareTo(b.getRateTime());
                });
            } else {
                ratings.sort((a, b) -> {
                    if (a.getRateTime() == null && b.getRateTime() == null) return 0;
                    if (a.getRateTime() == null) return 1;
                    if (b.getRateTime() == null) return -1;
                    return b.getRateTime().compareTo(a.getRateTime());
                });
            }

            // Calculate average rating
            double averageRating = rateDoctorDAO.getAverageRating(employee.getEmployeeId());

            // Set attributes for JSP
            request.setAttribute("rlist", ratings);
            request.setAttribute("keyword", keyword);
            request.setAttribute("order", order);
            request.setAttribute("averageRating", averageRating);
            request.setAttribute("totalRatings", ratings.size());

            request.getRequestDispatcher("Presentation/DoctorRateList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách đánh giá: " + e.getMessage());
            request.getRequestDispatcher("Presentation/DoctorRateList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Doctor Rate List Management Servlet";
    }
}
