package Controller;

import DAO.BookingDAO;
import DAO.ClinicWorkingDAO;
import Entity.ClinicWorking;
import Utility.DBContext;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/CheckTime")
public class CheckTimeServlet extends HttpServlet {

    private static final List<String> ALL_TIMES = Arrays.asList(
        "08:00", "08:30", "09:00", "09:30", "10:00",
        "10:30", "11:00", "13:00", "13:30", "14:00",
        "14:30", "15:00", "15:30", "16:00", "16:30"
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String doctorId = request.getParameter("doctorId");
        String dateStr = request.getParameter("date");

        List<String> availableTimes = new ArrayList<>();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            LocalDate selectedDate = LocalDate.parse(dateStr);
            LocalDate today = LocalDate.now();
            LocalDateTime now = LocalDateTime.now();

            // Ngày đã qua thì không xử lý
            if (selectedDate.isBefore(today)) {
                response.getWriter().write("[]");
                return;
            }

            // Xác định thứ trong tuần (0 = Sunday)
            int dow = selectedDate.getDayOfWeek().getValue(); // Java: 1 = Monday ... 7 = Sunday
            if (dow == 7) {
                dow = 0;
            }

            try (Connection conn = new DBContext().connection) {
                ClinicWorkingDAO clinicDAO = new ClinicWorkingDAO(conn);
                ClinicWorking working = clinicDAO.getByDayOfWeek(dow);

                if (working == null || !working.isActive()) {
                    response.getWriter().write("[]"); // Không hoạt động ngày này
                    return;
                }

                LocalTime start = working.getStartTime();
                LocalTime end = working.getEndTime();

                // Chỉ thêm giờ hợp lệ vào availableTimes
                for (String timeStr : ALL_TIMES) {
                    LocalTime t = LocalTime.parse(timeStr);
                    if (!t.isBefore(start) && t.isBefore(end)) {
                        availableTimes.add(timeStr);
                    }
                }

                // Nếu chọn bác sĩ → lọc theo giờ đã đặt
                if (doctorId != null && !doctorId.trim().isEmpty()) {
                    BookingDAO bookingDAO = new BookingDAO(conn);
                    List<String> bookedTimes = bookingDAO.getBookedTimesForDateAndDoctor(dateStr, doctorId);
                    availableTimes.removeAll(bookedTimes);
                }

                // Nếu là hôm nay → loại bỏ giờ < 30 phút nữa
                if (selectedDate.equals(today)) {
                    LocalTime nowTime = now.toLocalTime();
                    availableTimes.removeIf(timeStr -> {
                        LocalTime slotTime = LocalTime.parse(timeStr);
                        Duration diff = Duration.between(nowTime, slotTime);
                        return diff.isNegative() || diff.toMinutes() < 30;
                    });
                }

                // Trả về kết quả JSON
                Gson gson = new Gson();
                response.getWriter().write(gson.toJson(availableTimes));
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("[]");
        }
    }
}

