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

@WebServlet(name = "ProfileStaff", urlPatterns = {"/ProfileStaff"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class ProfileStaff extends HttpServlet {

    private EmployeeDAO getEmployeeDAO() {
        return new EmployeeDAO(new DBContext().connection);
    }

    private BookingDAO getBookingDAO() {
        return new BookingDAO(new DBContext().connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDAO employeeDAO = getEmployeeDAO();
        BookingDAO bookingDAO = getBookingDAO();

        HttpSession session = request.getSession();
        Employee currentStaff = (Employee) session.getAttribute("staff");
        if (currentStaff == null) {
            response.sendRedirect("login-employee");
            return;
        }
        request.setAttribute("currentStaff", currentStaff);
        
        int pendingBookingCount = getBookingDAO().countBookingsByStatus("Pending");
        request.setAttribute("pendingBookingCount", pendingBookingCount);

        List<Employee> doctorList = employeeDAO.getAllDoctor();
        request.setAttribute("doctorList", doctorList);

        final String doctorIdParam = request.getParameter("doctorId");
        final String doctorId = (doctorIdParam == null && !doctorList.isEmpty())
                ? doctorList.get(0).getEmployeeId()
                : doctorIdParam;
        request.setAttribute("selectedDoctorId", doctorId);

        Employee selectedDoctor = doctorList.stream()
                .filter(doc -> doc.getEmployeeId().equals(doctorId))
                .findFirst()
                .orElse(null);
        request.setAttribute("selectedDoctor", selectedDoctor);

        List<String> dateKeys = new ArrayList<>();
        List<Date> displayDates = new ArrayList<>();
        SimpleDateFormat keyFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        for (int i = 0; i < 365; i++) {
            Date date = cal.getTime();
            dateKeys.add(keyFormat.format(date));
            displayDates.add(date);
            cal.add(Calendar.DATE, 1);
        }
        request.setAttribute("dateList", displayDates);

        List<String> hourSlots = Arrays.asList("08:00", "09:00", "10:00", "11:00", "12:00",
                "13:00", "14:00", "15:00", "16:00");
        request.setAttribute("hourSlots", hourSlots);

        List<java.sql.Date> sqlDates = new ArrayList<>();
        for (String d : dateKeys) {
            sqlDates.add(java.sql.Date.valueOf(d));
        }
        List<Booking> bookingList = bookingDAO.getBookingsForDoctorSchedule(doctorId, sqlDates);
        request.setAttribute("bookingList", bookingList);

        Map<String, List<Booking>> bookingMap = new HashMap<>();
        for (Booking b : bookingList) {
            String date = b.getBookingTime().toLocalDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            String hour = b.getBookingTime().toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
            b.setFormattedDate(date);
            b.setFormattedTime(hour);
            String key = date + "_" + hour;
            bookingMap.computeIfAbsent(key, k -> new ArrayList<>()).add(b);
        }
        request.setAttribute("bookingMap", bookingMap);

        Map<String, List<String>> doctorBusyMap = new HashMap<>();
        for (Booking b : bookingList) {
            String date = b.getBookingTime().toLocalDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            String hour = b.getBookingTime().toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
            String key = date + "_" + hour;
            if (b.getEmployeeId() != null) {
                doctorBusyMap.computeIfAbsent(key, k -> new ArrayList<>()).add(b.getEmployeeId());
            }
        }
        request.setAttribute("doctorBusyMap", doctorBusyMap);

        Gson gson = new Gson();
        request.setAttribute("doctorListJson", gson.toJson(doctorList));
        request.setAttribute("doctorBusyMapJson", gson.toJson(doctorBusyMap));

        request.getRequestDispatcher("/Presentation/ProfileStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String doctorId = request.getParameter("doctorId");
        String bookingId = request.getParameter("bookingId");

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
                String uploadPath = getServletContext().getRealPath("/Presentation/img/images/avtEmp");
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

        if (doctorId != null && bookingId != null) {
            getBookingDAO().assignDoctorToBooking(doctorId, bookingId);
        }
        response.sendRedirect("ProfileStaff?doctorId=" + doctorId);
    }

    @Override
    public String getServletInfo() {
        return "Staff profile & doctor schedule management with file upload";
    }
}
