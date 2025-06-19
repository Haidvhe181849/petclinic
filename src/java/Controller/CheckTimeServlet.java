package Controller;

import DAO.BookingDAO;
import Utility.DBContext;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;
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

        List<String> availableTimes = new ArrayList<>(ALL_TIMES);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Parse ngày từ client gửi lên
            LocalDate selectedDate = LocalDate.parse(dateStr);
            LocalDate today = LocalDate.now();

            // Nếu là ngày đã qua → không cho đặt
            if (selectedDate.isBefore(today)) {
                response.getWriter().write("[]"); // trả về danh sách trống
                return;
            }

            // Nếu có chọn bác sĩ thì mới lọc giờ đã đặt
            if (doctorId != null && !doctorId.trim().isEmpty()) {
                try (Connection conn = new DBContext().connection) {
                    BookingDAO bookingDAO = new BookingDAO(conn);
                    List<String> bookedTimes = bookingDAO.getBookedTimesForDateAndDoctor(dateStr, doctorId);
                    availableTimes.removeAll(bookedTimes);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(availableTimes));

        } catch (Exception e) {
            // Nếu lỗi khi parse ngày → xử lý fallback
            e.printStackTrace();
            response.getWriter().write("[]");
        }
    }
}
