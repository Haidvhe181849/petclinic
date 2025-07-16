package Controller;

import DAO.BookingDAO;
import DAO.EmployeeDAO;
import Entity.Booking;
import Entity.BookingDetail;
import Entity.BookingEx;
import Entity.Employee;
import Utility.DBContext;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.UUID;

@WebServlet(name = "ProfileDoctor", urlPatterns = {"/ProfileDoctor"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class ProfileDoctor extends HttpServlet {

    private EmployeeDAO getEmployeeDAO() {
        return new EmployeeDAO(new DBContext().connection);
    }

    private BookingDAO getBookingDAO() {
        return new BookingDAO(new DBContext().connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            EmployeeDAO employeeDAO = getEmployeeDAO();
            BookingDAO bookingDAO = getBookingDAO();

            HttpSession session = request.getSession();
            Employee currentDoctor = (Employee) session.getAttribute("doctor");
            if (currentDoctor == null) {
                response.sendRedirect("login-employee");
                return;
            }
            request.setAttribute("currentDoctor", currentDoctor);

            int pendingBookingCount = bookingDAO.countBookingsByStatus("Pending");
            request.setAttribute("pendingBookingCount", pendingBookingCount);

            
            
            // Lấy lịch Confirm của bác sĩ đang đăng nhập
            List<Booking> confirmedBookings = bookingDAO.getConfirmedBookingsByDoctorId(currentDoctor.getEmployeeId());
            request.setAttribute("confirmedBookings", confirmedBookings);
            

            request.getRequestDispatcher("/Presentation/ProfileDoctor.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();  // IN LỖI RA CONSOLE
            response.getWriter().write("Lỗi Servlet: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Doctor profile & doctor schedule management with file upload";
    }
}
