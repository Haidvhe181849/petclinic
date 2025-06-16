package DAO;

import Entity.Booking;
import Entity.BookingEx;
import Entity.BookingDetail;
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

    public List<BookingEx> getAllBooking(String sql) {
        List<BookingEx> listBooking = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String bookingId = rs.getString("booking_id");
                String customerName = rs.getString("customer_name");
                String petName = rs.getString("pet_name");
                String petType = rs.getString("pet_type");
                String serviceName = rs.getString("service_name");
                String employeeName = rs.getString("employee_name");
                Timestamp bookingTime = rs.getTimestamp("booking_time");
                String status = rs.getString("status");

                BookingEx bookingEx = new BookingEx(
                        bookingId,
                        customerName,
                        petName,
                        petType,
                        serviceName,
                        employeeName,
                        bookingTime,
                        status
                );
                listBooking.add(bookingEx);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listBooking;
    }

    public List<BookingEx> searchBookingById(String bookingId) {
        List<BookingEx> listBooking = new ArrayList<>();
        String sql = "SELECT b.booking_id, ua.name AS customer_name, p.name AS pet_name, "
                + "at.type_name AS pet_type, s.service_name, e.name AS employee_name, "
                + "b.booking_time, b.status "
                + "FROM Booking b "
                + "JOIN UserAccount ua ON b.user_id = ua.user_id "
                + "JOIN Pet p ON b.pet_id = p.pet_id "
                + "JOIN AnimalType at ON p.pet_type_id = at.animal_type_id "
                + "JOIN Service s ON b.service_id = s.service_id "
                + "JOIN Employee e ON b.employee_id = e.employee_id "
                + "WHERE b.booking_id LIKE ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + bookingId + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingEx bookingEx = new BookingEx(
                            rs.getString("booking_id"),
                            rs.getString("customer_name"),
                            rs.getString("pet_name"),
                            rs.getString("pet_type"),
                            rs.getString("service_name"),
                            rs.getString("employee_name"),
                            rs.getTimestamp("booking_time"),
                            rs.getString("status")
                    );
                    listBooking.add(bookingEx);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listBooking;
    }

//    public void updateBookingStatus(String bookingId, String status) {
//        String sql = "UPDATE Booking SET status = ? WHERE booking_id = ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, status);
//            ps.setString(2, bookingId);
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
    public void updateBookingStatus(String bookingId, String status, String cancelReason) {
        String sql = "UPDATE Booking SET status = ? WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, bookingId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if ("Failed".equals(status)) {
            String detailSql = "UPDATE BookingDetail SET cancel_reason = ?, is_cancelled = 1 WHERE booking_id = ?";
            try (PreparedStatement ps2 = connection.prepareStatement(detailSql)) {
                ps2.setString(1, cancelReason);
                ps2.setString(2, bookingId);
                ps2.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if ("Confirmed".equals(status)) {
            String detailSql = "UPDATE BookingDetail SET cancel_reason = NULL, is_cancelled = 0 WHERE booking_id = ?";
            try (PreparedStatement ps3 = connection.prepareStatement(detailSql)) {
                ps3.setString(1, bookingId);
                ps3.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public BookingDetail getBookingDetailById(String bookingId) {
        BookingDetail detail = null;

        String sql = "SELECT b.booking_id, "
                + "ua.name AS customer_name, ua.phone AS customer_phone, ua.email AS customer_email, "
                + "p.name AS pet_name, at.type_name AS pet_type, p.breed AS breed, "
                + "s.service_name, e.name AS employee_name, "
                + "b.booking_time, b.status, b.note, "
                + "bd.actual_checkin_time, bd.cancel_reason "
                + "FROM Booking b "
                + "JOIN UserAccount ua ON b.user_id = ua.user_id "
                + "JOIN Pet p ON b.pet_id = p.pet_id "
                + "JOIN AnimalType at ON p.pet_type_id = at.animal_type_id "
                + "JOIN Service s ON b.service_id = s.service_id "
                + "JOIN Employee e ON b.employee_id = e.employee_id "
                + "LEFT JOIN BookingDetail bd ON b.booking_id = bd.booking_id "
                + "WHERE b.booking_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    detail = new BookingDetail();
                    detail.setBookingId(rs.getString("booking_id"));
                    detail.setCustomerName(rs.getString("customer_name"));
                    detail.setCustomerPhone(rs.getString("customer_phone"));
                    detail.setCustomerEmail(rs.getString("customer_email"));
                    detail.setPetName(rs.getString("pet_name"));
                    detail.setPetType(rs.getString("pet_type"));
                    detail.setBreed(rs.getString("breed"));
                    detail.setServiceName(rs.getString("service_name"));
                    detail.setEmployeeName(rs.getString("employee_name"));
                    detail.setBookingTime(rs.getTimestamp("booking_time"));
                    detail.setStatus(rs.getString("status"));
                    detail.setNote(rs.getString("note"));
                    detail.setActualCheckinTime(rs.getTimestamp("actual_checkin_time"));
                    detail.setCancelReason(rs.getString("cancel_reason"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return detail;
    }

}
