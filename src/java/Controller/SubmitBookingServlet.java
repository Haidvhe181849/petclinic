package Controller;

import DAO.BookingDAO;
import Entity.Booking;
import Entity.UserAccount;
import Utility.DBContext;
import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SubmitBooking")
public class SubmitBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🔥 [DEBUG] Đã vào SubmitBookingServlet");

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            System.out.println("🔴 Người dùng chưa đăng nhập");
            response.sendRedirect("Presentation/Login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String doctorIdRaw = request.getParameter("doctorId");
        String doctorId = (doctorIdRaw == null || doctorIdRaw.trim().isEmpty()) ? null : doctorIdRaw;

        String petId = request.getParameter("petId");
        String serviceId = request.getParameter("serviceId");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String note = request.getParameter("note");

        System.out.println("📥 doctorId raw = '" + doctorIdRaw + "' → xử lý thành: " + doctorId);
        System.out.println("🔎 Input: doctor=" + doctorId + ", pet=" + petId + ", date=" + date + ", time=" + time);

        try (Connection conn = new DBContext().connection) {
            BookingDAO dao = new BookingDAO(conn);

            // Kiểm tra trùng giờ nếu có chọn bác sĩ
            if (doctorId != null) {
                List<String> bookedTimes = dao.getBookedTimesForDateAndDoctor(date, doctorId);
                if (bookedTimes.contains(time)) {
                    System.out.println("⚠️ Giờ đã bị đặt");
                    response.sendRedirect("BookingForm?error=Giờ đã bị đặt");
                    return;
                }
            }

            String bookingId = dao.generateNewBookingId();

            // Parse thời gian
            LocalDateTime bookingTime;
            try {
                bookingTime = LocalDateTime.parse(date + " " + time,
                        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            } catch (Exception ex) {
                System.out.println("❌ Lỗi định dạng thời gian: " + ex.getMessage());
                response.sendRedirect("BookingForm?error=Định dạng ngày giờ không hợp lệ");
                return;
            }

            // Tạo booking phù hợp với tình huống
            Booking booking;
            if (doctorId != null) {
                booking = new Booking(bookingId, user.getUserId(), doctorId,
                        serviceId, petId, note, bookingTime, "Pending");
            } else {
                booking = new Booking(bookingId, user.getUserId(),
                        serviceId, petId, note, bookingTime, "Pending");
            }

            boolean success = dao.insertBooking(booking);
            System.out.println("✅ Kết quả insert: " + success);

//            if (success) {
//                // THÊM DÒNG NÀY:
//                boolean detailInserted = dao.insertBookingDetail(bookingId, user);
//                System.out.println("📥 Detail inserted: " + detailInserted);
//
//                response.sendRedirect("BookingForm?success=true");
//            } else {
//                System.out.println("❌ insertBooking trả về false");
//                response.sendRedirect("BookingForm?error=Đặt lịch thất bại.");
//            }
            if (success) {
                // Lưu bookingId vào session để sử dụng trong quá trình thanh toán
                session.setAttribute("pendingBookingId", bookingId);

                // Chuyển hướng đến trang thanh toán
                response.sendRedirect("payment");
            } else {
                System.out.println("❌ insertBooking trả về false");
                response.sendRedirect("BookingForm?error=Đặt lịch thất bại.");
            }

        } catch (Exception e) {
            System.out.println("❌ Lỗi trong SubmitBookingServlet:");
            e.printStackTrace();

            // Redirect lỗi thay vì in ra text thô
            response.sendRedirect("BookingForm?error=Lỗi hệ thống khi đặt lịch");
        }
    }
}
