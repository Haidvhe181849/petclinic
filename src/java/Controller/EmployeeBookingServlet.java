package Controller;

import DAO.BookingDAO;
import DAO.DoctorDAO;
import Entity.BookingEx;
import Entity.BookingDetail;
import Entity.Employee;
import Entity.UserAccount;
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
 * Servlet for employee booking management (role = 3)
 */
@WebServlet(name = "EmployeeBookingServlet", urlPatterns = {"/employee-booking"})
public class EmployeeBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Employee employee = (Employee) session.getAttribute("staff");
//        System.out.println(employee.getNameEmployee());
//        
        // Check if employee is logged in
        System.out.println(employee.getNameEmployee());
        if (employee == null) {
            response.sendRedirect(request.getContextPath() + "/Presentation/LoginEmployee.jsp");
            return;
        }
        System.out.println(employee.getRoleId());

        // Check if employee has role = 3 (staff)
        if (employee.getRoleId() != 3) {
            session.setAttribute("message", "Bạn không có quyền truy cập trang này.");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try (Connection conn = new DBContext().connection) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            DoctorDAO doctorDAO = new DoctorDAO(conn);

            // Set employee info for display
            request.setAttribute("employee", employee);
            String keyword = request.getParameter("keyword");
            if (keyword != null) {
                keyword = keyword.trim();
            }
            String status = request.getParameter("status");
            String order = request.getParameter("order");
            if (order == null || order.isEmpty()) {
                order = "desc"; // default order
            }

            // Get bookings for this employee using getFilteredBookings with employeeId
            List<BookingEx> bookings = bookingDAO.getFilteredBookings(keyword, status, order, null, null, employee.getEmployeeId());

            // Set attributes for JSP (use blist to match BookingManagerment.jsp)
            request.setAttribute("blist", bookings);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            request.setAttribute("order", order);
            // Check for detail action
            String action = request.getParameter("action");
            if ("detail".equals(action)) {
                String bookingId = request.getParameter("bookingId");
                if (bookingId != null && !bookingId.trim().isEmpty()) {
                    BookingDetail detail = bookingDAO.getBookingDetailById(bookingId);
                    request.setAttribute("bookingDetail", detail);
                    request.setAttribute("blist", bookings);
                    request.setAttribute("keyword", keyword);
                    request.setAttribute("status", status);
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("Presentation/EmployeeBooking.jsp").forward(request, response);
                    return;
                }
            }

            // Set user session for header compatibility (employee as user)
//            if (session.getAttribute("user") == null) {
//                // Create a user object from employee for header compatibility
//                UserAccount user = new UserAccount();
//                user.setUserId(Integer.parseInt(employee.getEmployeeId()));
//                user.setUsername(employee.getName());
//                user.setEmail(employee.getEmail());
//                user.setRoleId(employee.getRoleId());
//                session.setAttribute("user", user);
//            }
            // Get filtering parameters
//            String keyword = request.getParameter("keyword");
//            if (keyword != null) {
//                keyword = keyword.trim();
//            }
//            String status = request.getParameter("status");
//            String order = request.getParameter("order");
//            if (order == null || order.isEmpty()) {
//                order = "desc"; // default order
//            }
//
//            // Get bookings for this employee using getFilteredBookings with employeeId
//            List<BookingEx> bookings = bookingDAO.getFilteredBookings(keyword, status, order, null, null, employee.getEmployeeId());
            // Set attributes for JSP (use blist to match BookingManagerment.jsp)
            request.setAttribute("blist", bookings);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            request.setAttribute("order", order);

            // Data for modals
            request.setAttribute("employeeList", doctorDAO.getAllDoctors());
            request.getRequestDispatcher("Presentation/EmployeeBooking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải lịch hẹn: " + e.getMessage());
        }

//        request.getRequestDispatcher("Presentation/EmployeeBooking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Employee Booking Management Servlet";
    }
}
