package DAO;

import Entity.Booking;
import Entity.BookingEx;
import Entity.BookingDetail;
import Entity.UserAccount;
import Utility.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;

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
            ps.setString(1, booking.getBookingId());
            ps.setInt(2, booking.getUserId());
            if (booking.getEmployeeId() != null && !booking.getEmployeeId().isEmpty()) {
                ps.setString(3, booking.getEmployeeId());
            } else {
                ps.setNull(3, java.sql.Types.VARCHAR);
            }
            ps.setString(4, booking.getServiceId());
            ps.setString(5, booking.getPetId());
            ps.setString(6, booking.getNote());
            ps.setTimestamp(7, Timestamp.valueOf(booking.getBookingTime()));
            ps.setString(8, booking.getStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi insertBooking:");
            e.printStackTrace();
            return false;
        }
    }

    public boolean insertBookingDetail(String bookingId, UserAccount user) {
        String sql = "INSERT INTO BookingDetail (booking_id, name, phone, email, actual_checkin_time, is_cancelled, cancel_reason) "
                + "VALUES (?, ?, ?, ?, NULL, 0, NULL)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            ps.setString(2, user.getName());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getEmail());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
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

    public Booking getBookingById(String bookingId) {
        String sql = "SELECT b.booking_id, b.user_id, b.employee_id, b.service_id, b.pet_id, b.note, "
                + "b.booking_time, b.status, "
                + "e.name AS employee_name, p.name AS pet_name, s.service_name, s.price "
                + "FROM Booking b "
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id "
                + "LEFT JOIN Pet p ON b.pet_id = p.pet_id "
                + "LEFT JOIN Service s ON b.service_id = s.service_id "
                + "WHERE b.booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getString("booking_id"));
                    booking.setUserId(rs.getInt("user_id"));
                    booking.setEmployeeId(rs.getString("employee_id"));
                    booking.setServiceId(rs.getString("service_id"));
                    booking.setPetId(rs.getString("pet_id"));
                    booking.setNote(rs.getString("note"));

                    Timestamp timestamp = rs.getTimestamp("booking_time");
                    if (timestamp != null) {
                        LocalDateTime dateTime = timestamp.toLocalDateTime();
                        booking.setBookingTime(dateTime);
                        booking.setFormattedDate(dateTime.toLocalDate().toString());
                        booking.setFormattedTime(dateTime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")));
                    }

                    booking.setStatus(rs.getString("status"));
                    booking.setEmployeeName(rs.getString("employee_name"));
                    booking.setPetName(rs.getString("pet_name"));
                    booking.setServiceName(rs.getString("service_name"));
                    booking.setServicePrice(rs.getDouble("price"));

                    return booking;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

    public List<BookingEx> getAllBooking() {
        List<BookingEx> listBooking = new ArrayList<>();

        String sql = "SELECT b.booking_id, ua.name AS customer_name, p.name AS pet_name, "
                + "at.type_name AS pet_type, s.service_name, e.name AS employee_name, "
                + "b.booking_time, b.status "
                + "FROM Booking b "
                + "JOIN UserAccount ua ON b.user_id = ua.user_id "
                + "JOIN Pet p ON b.pet_id = p.pet_id "
                + "JOIN AnimalType at ON p.pet_type_id = at.animal_type_id "
                + "JOIN Service s ON b.service_id = s.service_id "
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String bookingId = rs.getString("booking_id");
                String customerName = rs.getString("customer_name");
                String petName = rs.getString("pet_name");
                String petType = rs.getString("pet_type");
                String serviceName = rs.getString("service_name");
                String employeeName = rs.getString("employee_name"); // có thể null
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
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id "
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

    public List<BookingEx> getAllBookingSorted(String order) {
        List<BookingEx> listBooking = new ArrayList<>();

        // Chỉ cho phép 'ASC' hoặc 'DESC' để tránh SQL Injection
        if (!"asc".equalsIgnoreCase(order) && !"desc".equalsIgnoreCase(order)) {
            order = "asc";
        }

        String sql = "SELECT b.booking_id, ua.name AS customer_name, p.name AS pet_name, "
                + "at.type_name AS pet_type, s.service_name, e.name AS employee_name, "
                + "b.booking_time, b.status "
                + "FROM Booking b "
                + "JOIN UserAccount ua ON b.user_id = ua.user_id "
                + "JOIN Pet p ON b.pet_id = p.pet_id "
                + "JOIN AnimalType at ON p.pet_type_id = at.animal_type_id "
                + "JOIN Service s ON b.service_id = s.service_id "
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id "
                + "ORDER BY b.booking_time " + order;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

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

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listBooking;
    }

    public void updateBookingStatus(String bookingId, String status, String cancelReason) {
        String sql = "UPDATE Booking SET status = ? WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, bookingId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Ghi lý do và trạng thái cancel_detail
        if ("Cancelled".equals(status) || "Cancelled_Pending".equals(status)) {
            String detailSql = "UPDATE BookingDetail SET cancel_reason = ?, is_cancelled = ? WHERE booking_id = ?";
            try (PreparedStatement ps2 = connection.prepareStatement(detailSql)) {
                ps2.setString(1, cancelReason);
                ps2.setInt(2, "Cancelled".equals(status) ? 1 : 0); // 1 = staff chấp nhận hủy, 0 = đang chờ
                ps2.setString(3, bookingId);
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

    public void updateBookingStatus1(String bookingId, String status, String cancelReason) throws SQLException {
        String sql = "UPDATE Booking SET status = ?, updated_at = GETDATE() WHERE booking_id = ?";
        String sqlDetail = "UPDATE BookingDetail SET cancel_reason = ? WHERE booking_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql); PreparedStatement ps2 = connection.prepareStatement(sqlDetail)) {
            ps.setString(1, status);
            ps.setString(2, bookingId);
            ps.executeUpdate();

            ps2.setString(1, cancelReason);
            ps2.setString(2, bookingId);
            ps2.executeUpdate();
        }
    }

    public String getBookingStatus(String bookingId) {
        String sql = "SELECT status FROM Booking WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateBookingDone(String bookingId, String status) {
        String sql = "UPDATE Booking SET status = ? WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id "
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
                    detail.setEmployeeName(rs.getString("employee_name") != null ? rs.getString("employee_name") : "Chưa phân công");
                    detail.setBookingTime(rs.getTimestamp("booking_time"));
                    detail.setStatus(rs.getString("status"));
                    detail.setNote(rs.getString("note") != null ? rs.getString("note") : "(Không có)");
                    detail.setActualCheckinTime(rs.getTimestamp("actual_checkin_time"));
                    detail.setCancelReason(rs.getString("cancel_reason"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return detail;
    }

    public List<Booking> getBookingsByUser(int userId, String status, String keyword, int offset, int pageSize) {
        List<Booking> list = new ArrayList<>();

        String sql = "SELECT b.booking_id, b.booking_time, b.status, b.note, "
                + "s.service_name, s.price AS service_price, "
                + "p.name AS pet_name, "
                + "e.name AS employee_name "
                + "FROM Booking b "
                + "JOIN Service s ON b.service_id = s.service_id "
                + "JOIN Pet p ON b.pet_id = p.pet_id "
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id "
                + "WHERE b.user_id = ? ";

        if (status != null && !status.isEmpty()) {
            sql += " AND b.status = ? ";
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql += " AND p.name LIKE ? ";
        }

        sql += " ORDER BY b.booking_time DESC "
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            ps.setInt(index++, userId);
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
            }
            ps.setInt(index++, offset);
            ps.setInt(index, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking b = new Booking();
                    b.setBookingId(rs.getString("booking_id"));
                    b.setBookingTime(rs.getTimestamp("booking_time").toLocalDateTime());
                    b.setStatus(rs.getString("status"));
                    b.setNote(rs.getString("note"));
                    b.setServiceName(rs.getString("service_name"));
                    b.setServicePrice(rs.getDouble("service_price"));
                    b.setPetName(rs.getString("pet_name"));
                    b.setEmployeeName(rs.getString("employee_name"));
                    list.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countBookingsByUser(int userId, String status, String keyword) {
        String sql = "SELECT COUNT(*) FROM Booking b "
                + "JOIN Pet p ON b.pet_id = p.pet_id "
                + "WHERE b.user_id = ? ";

        if (status != null && !status.isEmpty()) {
            sql += " AND b.status = ? ";
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql += " AND p.name LIKE ? ";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            ps.setInt(index++, userId);
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int deleteBooking(String bookingId) {
        String deleteDetailSQL = "DELETE FROM BookingDetail WHERE booking_id = ?";
        String deleteBookingSQL = "DELETE FROM Booking WHERE booking_id = ?";

        try (PreparedStatement psDetail = connection.prepareStatement(deleteDetailSQL); PreparedStatement psBooking = connection.prepareStatement(deleteBookingSQL)) {

            psDetail.setString(1, bookingId);
            psDetail.executeUpdate();

            psBooking.setString(1, bookingId);
            return psBooking.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<BookingEx> getFilteredBookings(String keyword, String status, String order, Timestamp from, Timestamp to) {
        List<BookingEx> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT b.booking_id, "
                + "ua.name AS customer_name, "
                + "p.name AS pet_name, "
                + "at.type_name AS pet_type, "
                + "s.service_name, "
                + "e.name AS employee_name, "
                + "b.booking_time, "
                + "b.status "
                + "FROM Booking b "
                + "JOIN UserAccount ua ON b.user_id = ua.user_id "
                + "JOIN Pet p ON b.pet_id = p.pet_id "
                + "JOIN AnimalType at ON p.pet_type_id = at.animal_type_id "
                + "JOIN Service s ON b.service_id = s.service_id "
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id "
                + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (b.booking_id LIKE ? OR e.name LIKE ?) ");
            String likeKeyword = "%" + keyword.trim().replaceAll("\\s+", "%") + "%";
            params.add(likeKeyword);
            params.add(likeKeyword);
        }

        if (status != null && !status.isEmpty()) {
            sql.append("AND b.status = ? ");
            params.add(status);
        }

        if (from != null) {
            sql.append("AND b.booking_time >= ? ");
            params.add(from);
        }

        if (to != null) {
            sql.append("AND b.booking_time <= ? ");
            params.add(to);
        }

        if ("asc".equalsIgnoreCase(order)) {
            sql.append("ORDER BY b.booking_time ASC ");
        } else {
            sql.append("ORDER BY b.booking_time DESC ");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingEx b = new BookingEx(
                        rs.getString("booking_id"),
                        rs.getString("customer_name"),
                        rs.getString("pet_name"),
                        rs.getString("pet_type"),
                        rs.getString("service_name"),
                        rs.getString("employee_name"),
                        rs.getTimestamp("booking_time"),
                        rs.getString("status")
                );
                list.add(b);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Booking> getUpcomingByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = """
        SELECT b.booking_id, b.booking_time, b.status, 
               b.pet_id, p.name AS pet_name, 
               b.service_id, s.service_name
        FROM Booking b
        JOIN Pet p ON b.pet_id = p.pet_id
        JOIN Service s ON b.service_id = s.service_id
        WHERE b.user_id = ? 
          AND b.status IN ('Pending')
        ORDER BY b.booking_time ASC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getString("booking_id"));
                b.setBookingTime(rs.getTimestamp("booking_time").toLocalDateTime());
                b.setStatus(rs.getString("status"));
                b.setPetId(rs.getString("pet_id"));
                b.setPetName(rs.getString("pet_name"));
                b.setServiceId(rs.getString("service_id"));
                b.setServiceName(rs.getString("service_name"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Booking> getCompletedByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = """
        SELECT b.booking_id, b.booking_time, b.status, 
               b.pet_id, p.name AS pet_name, 
               b.service_id, s.service_name
        FROM Booking b
        JOIN Pet p ON b.pet_id = p.pet_id
        JOIN Service s ON b.service_id = s.service_id
        WHERE b.user_id = ? 
          AND b.status IN ('Cancelled', 'Confirmed')
        ORDER BY b.booking_time DESC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getString("booking_id"));
                b.setBookingTime(rs.getTimestamp("booking_time").toLocalDateTime());
                b.setStatus(rs.getString("status"));
                b.setPetId(rs.getString("pet_id"));
                b.setPetName(rs.getString("pet_name"));
                b.setServiceId(rs.getString("service_id"));
                b.setServiceName(rs.getString("service_name"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Booking> getAllByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = """
        SELECT b.booking_id, b.booking_time, b.status, 
               b.pet_id, p.name AS pet_name, 
               b.service_id, s.service_name
        FROM Booking b
        JOIN Pet p ON b.pet_id = p.pet_id
        JOIN Service s ON b.service_id = s.service_id
        WHERE b.user_id = ?
        ORDER BY b.booking_time DESC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getString("booking_id"));
                b.setBookingTime(rs.getTimestamp("booking_time").toLocalDateTime());
                b.setStatus(rs.getString("status"));
                b.setPetId(rs.getString("pet_id"));
                b.setPetName(rs.getString("pet_name"));
                b.setServiceId(rs.getString("service_id"));
                b.setServiceName(rs.getString("service_name"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countAppointmentsByUserId(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Booking WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Booking> getBookingsForDoctorSchedule(String doctorId, List<Date> dateList) {
        List<Booking> bookings = new ArrayList<>();
        if (dateList == null || dateList.isEmpty()) {
            return bookings;
        }

        // Tạo placeholders cho IN clause
        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < dateList.size(); i++) {
            placeholders.append("?");
            if (i < dateList.size() - 1) {
                placeholders.append(",");
            }
        }

        // Câu query đã kết hợp JOIN với AnimalType
        String sql = "SELECT b.*, "
                + "e.name AS employee_name, "
                + "p.name AS pet_name, "
                + "a.type_name AS pet_type, "
                + "s.service_name "
                + "FROM Booking b "
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id "
                + "LEFT JOIN Pet p ON b.pet_id = p.pet_id "
                + "LEFT JOIN AnimalType a ON p.pet_type_id = a.animal_type_id "
                + "LEFT JOIN Service s ON b.service_id = s.service_id "
                + "WHERE CAST(b.booking_time AS DATE) IN (" + placeholders + ") "
                + "AND (b.employee_id IS NULL OR b.employee_id = ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Set giá trị cho các ngày
            int index = 1;
            for (Date date : dateList) {
                ps.setDate(index++, new java.sql.Date(date.getTime()));
            }

            // Set employee_id ở cuối
            ps.setString(index, doctorId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getString("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setEmployeeId(rs.getString("employee_id"));
                booking.setServiceId(rs.getString("service_id"));
                booking.setPetId(rs.getString("pet_id"));
                booking.setNote(rs.getString("note"));
                booking.setBookingTime(rs.getTimestamp("booking_time").toLocalDateTime());
                booking.setStatus(rs.getString("status"));
                booking.setServiceName(rs.getString("service_name"));
                booking.setPetName(rs.getString("pet_name"));
                booking.setPetType(rs.getString("pet_type"));
                booking.setEmployeeName(rs.getString("employee_name"));

                bookings.add(booking);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    public void assignDoctorToBooking(String doctorId, String bookingId) {
        String sql = "UPDATE Booking SET employee_id = ? WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ps.setString(2, bookingId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public BookingDetail getBookingDetailByID(String bookingId) {
        BookingDetail detail = null;

        String sql = "SELECT b.booking_id, "
                + "ua.name AS ua_name, ua.phone AS ua_phone, ua.email AS ua_email, "
                + "p.name AS pet_name, at.type_name AS pet_type, p.breed AS breed, "
                + "s.service_name, e.name AS employee_name, "
                + "b.booking_time, b.note "
                + "FROM Booking b "
                + "JOIN UserAccount ua ON b.user_id = ua.user_id "
                + "JOIN Pet p ON b.pet_id = p.pet_id "
                + "JOIN AnimalType at ON p.pet_type_id = at.animal_type_id "
                + "JOIN Service s ON b.service_id = s.service_id "
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id "
                + "WHERE b.booking_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    detail = new BookingDetail();
                    detail.setBookingId(rs.getString("booking_id"));
                    detail.setCustomerName(rs.getString("ua_name"));
                    detail.setCustomerPhone(rs.getString("ua_phone"));
                    detail.setCustomerEmail(rs.getString("ua_email"));
                    detail.setPetName(rs.getString("pet_name"));
                    detail.setPetType(rs.getString("pet_type"));
                    detail.setBreed(rs.getString("breed"));
                    detail.setServiceName(rs.getString("service_name"));
                    detail.setEmployeeName(rs.getString("employee_name")); // null nếu chưa phân công
                    detail.setBookingTime(rs.getTimestamp("booking_time"));
                    detail.setNote(rs.getString("note") != null ? rs.getString("note") : "(Không có)");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return detail;
    }

    public int countBookingsByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM Booking WHERE status = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Booking> getConfirmedBookingsByDoctorId(String doctorId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, b.booking_time, b.status, b.note, "
                + "p.name AS pet_name, s.service_name, s.price, e.name AS employee_name "
                + "FROM Booking b "
                + "JOIN Pet p ON b.pet_id = p.pet_id "
                + "JOIN Service s ON b.service_id = s.service_id "
                + "LEFT JOIN Employee e ON b.employee_id = e.employee_id "
                + "WHERE b.status = 'Confirmed' AND b.employee_id = ? "
                + "ORDER BY b.booking_time ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getString("booking_id"));
                b.setStatus(rs.getString("status"));
                b.setNote(rs.getString("note"));

                // DateTime conversion
                Timestamp ts = rs.getTimestamp("booking_time");
                if (ts != null) {
                    LocalDateTime dateTime = ts.toLocalDateTime();
                    b.setBookingTime(dateTime);
                    b.setFormattedDate(dateTime.toLocalDate().toString());
                    b.setFormattedTime(dateTime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")));
                }

                b.setPetName(rs.getString("pet_name"));
                b.setServiceName(rs.getString("service_name"));
                b.setServicePrice(rs.getDouble("price"));
                b.setEmployeeName(rs.getString("employee_name"));

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalBookings() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Booking";

        try (
                PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery();) {
            if (rs.next()) {
                total = rs.getInt(1);  // Lấy cột COUNT(*) = tổng số dòng
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

}
