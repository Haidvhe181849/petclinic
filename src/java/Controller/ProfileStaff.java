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

    private Map<String, List<String>> buildHourSlotMap(List<Date> displayDates, ClinicWorkingDAO workingDAO) {
        Map<String, List<String>> map = new HashMap<>();
        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        for (Date d : displayDates) {
            LocalDate localDate = d.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            String key = df.format(localDate);
            try {
                List<String> slots = workingDAO.getValidTimeSlotsByDate(localDate); // Gọi DAO
                map.put(key, slots);
            } catch (SQLException e) {
                e.printStackTrace();
                map.put(key, new ArrayList<>()); // Nếu lỗi hoặc không có ca làm việc, trả về rỗng
            }
        }

        return map;
    }

    private void handleGetAvailableDoctors(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String timeStr = request.getParameter("datetime");
        System.out.println("🧪 Tham số datetime nhận được: " + timeStr);

        List<Employee> availableDoctors = new ArrayList<>();
        try {
            // ✅ Sửa tại đây:
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime dateTime = LocalDateTime.parse(timeStr, formatter);
            Timestamp ts = Timestamp.valueOf(dateTime);
            System.out.println("✅ Parsed timestamp: " + ts);

            EmployeeDAO employeeDAO = getEmployeeDAO();
            availableDoctors = employeeDAO.getAvailableDoctorsAtTime(ts);

            Gson gson = new Gson();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(availableDoctors));

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}"); // tạm in lỗi cụ thể
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDAO employeeDAO = getEmployeeDAO();
        BookingDAO bookingDAO = getBookingDAO();
        ClinicWorkingDAO workingDAO = getClinicWorkingDAO();

        HttpSession session = request.getSession();
        Employee currentStaff = (Employee) session.getAttribute("staff");
        if (currentStaff == null) {
            response.sendRedirect("login-employee");
            return;
        }
        request.setAttribute("currentStaff", currentStaff);

        String action = request.getParameter("action");
        if ("availableDoctors".equals(action)) {
            handleGetAvailableDoctors(request, response);
            return;
        }

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

        // ===== BUILD HOUR SLOT MAP THEO DATABASE =====
        Map<String, List<String>> hourSlotMap = new HashMap<>();
        Set<String> allHourSlotSet = new TreeSet<>(); // Dùng TreeSet để sort theo thứ tự

        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        for (Date d : displayDates) {
            LocalDate localDate = d.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            String key = df.format(localDate);
            try {
                List<String> slots = workingDAO.getValidTimeSlotsByDate(localDate);
                hourSlotMap.put(key, slots);
                allHourSlotSet.addAll(slots);
            } catch (SQLException e) {
                e.printStackTrace();
                hourSlotMap.put(key, new ArrayList<>()); // Nếu lỗi thì vẫn gán rỗng
            }
        }
        request.setAttribute("hourSlotMap", hourSlotMap);
        request.setAttribute("allHourSlots", new ArrayList<>(allHourSlotSet)); // Gửi xuống JSP

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
            String time = b.getBookingTime().toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"));
            String key = date + "_" + time;

            if (b.getEmployeeId() != null) {
                doctorBusyMap.computeIfAbsent(key, k -> new ArrayList<>()).add(b.getEmployeeId());
            }
        }
        request.setAttribute("doctorBusyMap", doctorBusyMap);

// Dùng cho client-side JavaScript nếu bạn muốn xử lý động
        Gson gson = new Gson();
        request.setAttribute("doctorBusyMapJson", gson.toJson(doctorBusyMap));
        request.setAttribute("doctorListJson", gson.toJson(doctorList));

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
