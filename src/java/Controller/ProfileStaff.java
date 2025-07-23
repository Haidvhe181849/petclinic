package Controller;
// Thời gian & định dạng ngày giờ

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

// Danh sách & map
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

// Ngoại lệ SQL
import java.sql.SQLException;

import DAO.BookingDAO;
import DAO.ClinicWorkingDAO;
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
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.UUID;

@WebServlet(name = "ProfileStaff", urlPatterns = {"/ProfileStaff"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class ProfileStaff extends HttpServlet {

    private EmployeeDAO getEmployeeDAO() {
        return new EmployeeDAO(new DBContext().connection);
    }

    private BookingDAO getBookingDAO() {
        return new BookingDAO(new DBContext().connection);
    }

    private ClinicWorkingDAO getClinicWorkingDAO() {
        return new ClinicWorkingDAO(new DBContext().connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Employee currentStaff = (Employee) session.getAttribute("staff");
        if (currentStaff == null) {
            response.sendRedirect("login-employee");
            return;
        }
        request.setAttribute("currentStaff", currentStaff);
        
        int pendingBookingCount = getBookingDAO().countBookingsByStatus("Pending");
        request.setAttribute("pendingBookingCount", pendingBookingCount);
        
        request.getRequestDispatcher("/Presentation/ProfileStaff.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       

        if (request.getParameter("action") != null && request.getParameter("action").equals("updateProfile")) {
            HttpSession session = request.getSession();
            Employee currentStaff = (Employee) session.getAttribute("staff");
            if (currentStaff == null) {
                response.sendRedirect("login-employee");
                return;
            }

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String experience = request.getParameter("experience");
            String workingHours = request.getParameter("workingHours");

            Part filePart = request.getPart("avatarFile");
            String fileName = currentStaff.getImage();

            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("/Presentation/img/avtEmp");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                String extension = filePart.getSubmittedFileName().substring(filePart.getSubmittedFileName().lastIndexOf("."));
                fileName = UUID.randomUUID().toString() + extension;
                filePart.write(uploadPath + File.separator + fileName);
            }

            Employee updated = new Employee(
                    currentStaff.getEmployeeId(), name, fileName, phone, email,
                    currentStaff.getPassword(), address, currentStaff.getRoleId(),
                    experience, workingHours, currentStaff.isStatus()
            );

            getEmployeeDAO().updateEmployee(updated);
            session.setAttribute("staff", updated);
            response.sendRedirect("ProfileStaff");
            return;
        }

      
    }

    @Override
    public String getServletInfo() {
        return "Staff profile & doctor schedule management with file upload";
    }
}
