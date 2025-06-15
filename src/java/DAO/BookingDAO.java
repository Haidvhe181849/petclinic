package DAO;

import Entity.Booking;
import Utility.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;

public class BookingDAO extends DBContext {

    private Connection connection;

    public BookingDAO(Connection connection) {
        this.connection = connection;
    }

    /**
     * Thêm booking vào cơ sở dữ liệu
     *
     * @param booking đối tượng Booking chứa thông tin cần lưu
     * @return true nếu lưu thành công, false nếu lỗi
     */
    public boolean insertBooking(Booking booking) {
        if (booking == null || connection == null) {
            System.err.println("Booking hoặc connection là null");
            return false;
        }

        String sql = "INSERT INTO Booking (booking_id, user_id, employee_id, service_id, pet_id, note, booking_time, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Thiết lập các tham số, kiểm tra null trước khi set

            ps.setString(1, booking.getBookingId());
            ps.setInt(2, booking.getUserId());
            ps.setString(3, booking.getEmployeeId() != null ? booking.getEmployeeId() : "");
            ps.setString(4, booking.getServiceId() != null ? booking.getServiceId() : "");
            ps.setString(5, booking.getPetId() != null ? booking.getPetId() : "");
            ps.setString(6, booking.getNote() != null ? booking.getNote() : "");
            if (booking.getBookingTime() != null) {
                ps.setTimestamp(7, java.sql.Timestamp.valueOf(booking.getBookingTime()));
            } else {
                ps.setTimestamp(7, null);
            }
            ps.setString(8, booking.getStatus() != null ? booking.getStatus() : "");

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi insertBooking:");
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Tạo ID mới cho booking, dạng BK001, BK002...
     *
     * @return bookingId mới
     */
    public String generateNewBookingId() {
        if (connection == null) {
            System.err.println("Connection is null. Cannot generate new booking ID.");
            return "BK001"; // Trả về ID mặc định nếu không có kết nối
        }

        String sql = "SELECT TOP 1 booking_id FROM Booking ORDER BY booking_id DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("booking_id");
                // Kiểm tra định dạng ID
                if (lastId != null && lastId.startsWith("BK")) {
                    int number = Integer.parseInt(lastId.substring(2)) + 1;
                    return String.format("BK%03d", number);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error generating new booking ID:");
            e.printStackTrace();
        }

        return "BK001"; // Trả về ID mặc định nếu không tìm thấy ID nào
    }

    public List<String> getBookedTimesForDateAndDoctor(String date, String doctorId) throws SQLException {
        List<String> times = new ArrayList<>();
        String sql = "SELECT FORMAT(booking_time, 'HH:mm') AS time FROM Booking "
                + "WHERE employee_id = ? AND CAST(booking_time AS DATE) = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ps.setString(2, date); // date in format yyyy-MM-dd

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    times.add(rs.getString("time"));
                }
            }
        }

        return times;
    }

}
