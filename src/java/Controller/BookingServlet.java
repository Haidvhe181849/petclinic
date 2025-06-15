package Controller;

import DAO.BookingDAO;
import DAO.DoctorDAO;
import DAO.PetDAO;
import Utility.DBContext;
import Entity.Booking;
import Entity.Employee;
import Entity.Pet;
import Entity.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "BookingServlet", urlPatterns = {"/Booking"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Presentation/Login.jsp");
            return;
        }

        int userId = user.getUserId();
        Connection conn = null;

        try {
            conn = new DBContext().connection;

            PetDAO petDAO = new PetDAO(conn);
            DoctorDAO doctorDAO = new DoctorDAO(conn);

            List<Pet> pets = petDAO.getPetsByOwnerId(userId);
            List<Employee> doctors = doctorDAO.getAllDoctors();

            request.setAttribute("pets", pets);
            request.setAttribute("doctors", doctors);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải dữ liệu: " + e.getMessage());
        } finally {
            try {
                if (conn != null && !conn.isClosed()) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        request.getRequestDispatcher("Presentation/BookingSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        UserAccount user = (UserAccount) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Presentation/Login.jsp");
            return;
        }

        int userId = user.getUserId();
        String employeeId = request.getParameter("doctorSelect");
        String serviceId = "SV001"; // tạm cứng
        String petId = request.getParameter("petId");
        String note = request.getParameter("description");
        String date = request.getParameter("appointmentDate");
        String time = request.getParameter("appointmentTime");
        String status = "Pending";

        Connection conn = null;

        try {
            conn = new DBContext().connection;

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            LocalDateTime bookingTime = LocalDateTime.parse(date + " " + time, formatter);

            BookingDAO bookingDAO = new BookingDAO(conn);

            if (bookingTime.isBefore(LocalDateTime.now())) {
                request.setAttribute("error", "Không thể đặt lịch ở thời điểm quá khứ.");
                prepareFormData(request, conn, userId, employeeId, date, time, note, petId);
                doGet(request, response);
                return;
            }

            List<String> bookedTimes = bookingDAO.getBookedTimesForDateAndDoctor(date, employeeId);
            if (bookedTimes.contains(time)) {
                request.setAttribute("error", "Khung giờ đã được đặt. Vui lòng chọn giờ khác.");
                prepareFormData(request, conn, userId, employeeId, date, time, note, petId);
                doGet(request, response);
                return;
            }

            String bookingId = bookingDAO.generateNewBookingId();
            Booking booking = new Booking(bookingId, userId, employeeId, serviceId, petId, note, bookingTime, status);

            if (bookingDAO.insertBooking(booking)) {
                response.sendRedirect("Presentation/BookingSuccess.jsp");
            } else {
                request.setAttribute("error", "Đặt lịch thất bại. Vui lòng thử lại.");
                prepareFormData(request, conn, userId, employeeId, date, time, note, petId);
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            try {
                prepareFormData(request, conn, userId, employeeId, date, time, note, petId);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            doGet(request, response);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void prepareFormData(HttpServletRequest request, Connection conn, int userId,
                                 String doctorId, String date, String time, String note, String petId) throws Exception {

        PetDAO petDAO = new PetDAO(conn);
        DoctorDAO doctorDAO = new DoctorDAO(conn);
        BookingDAO bookingDAO = new BookingDAO(conn);

        List<Pet> pets = petDAO.getPetsByOwnerId(userId);
        List<Employee> doctors = doctorDAO.getAllDoctors();
        List<String> bookedTimes = bookingDAO.getBookedTimesForDateAndDoctor(date, doctorId);

        request.setAttribute("pets", pets);
        request.setAttribute("doctors", doctors);
        request.setAttribute("bookedTimes", bookedTimes);

        request.setAttribute("selectedDoctor", doctorId);
        request.setAttribute("selectedDate", date);
        request.setAttribute("appointmentTime", time);
        request.setAttribute("description", note);
        request.setAttribute("petId", petId);

        // giữ lại dữ liệu người dùng nhập
        request.setAttribute("customerName", request.getParameter("customerName"));
        request.setAttribute("phone", request.getParameter("phone"));
        request.setAttribute("email", request.getParameter("email"));
        request.setAttribute("address", request.getParameter("address"));
    }
}
