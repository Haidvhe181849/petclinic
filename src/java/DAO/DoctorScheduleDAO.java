/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Booking;
import Entity.Medicine;
import Entity.UserAccount;
import Entity.Employee;
import Utility.DBContext;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.apache.catalina.User;

/**
 *
 * @author trung123
 */
public class DoctorScheduleDAO extends DBContext {

    // Lấy lịch khám hiện tại của bác sĩ (Pending) —> sắp xếp theo ngày giờ
    public List<Booking> getDoctorSchedule(String doctorId) {
        List<Booking> list = new ArrayList<>();
        String sql = """
        SELECT * FROM Booking
        WHERE employee_id = ?
        AND booking_time >= CAST(GETDATE() AS DATETIME)
        AND status IN ('Confirmed', 'Pending')
        ORDER BY booking_time ASC
    """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking(
                        rs.getString("booking_id"),
                        rs.getInt("user_id"),
                        rs.getString("employee_id"),
                        rs.getString("service_id"),
                        rs.getString("pet_id"),
                        rs.getString("note"),
                        rs.getObject("booking_time", LocalDateTime.class),
                        rs.getString("status")
                );
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lịch sử khám (Completed) —> sắp xếp theo ngày giờ
    public List<Booking> getHistorySchedules(String doctorId) {
        List<Booking> list = new ArrayList<>();
        String sql = """
        SELECT * FROM Booking 
        WHERE employee_id = ? 
        AND status = 'Completed' 
        ORDER BY booking_time ASC
    """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, doctorId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking(
                        rs.getString("booking_id"),
                        rs.getInt("user_id"),
                        rs.getString("employee_id"),
                        rs.getString("service_id"),
                        rs.getString("pet_id"),
                        rs.getString("note"),
                        rs.getObject("booking_time", LocalDateTime.class),
                        rs.getString("status")
                );
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Hoàn thành lịch khám
    public void completeSchedule(int bookingId) {
        String sql = "UPDATE Booking SET status = 'Completed' WHERE booking_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Danh sách bệnh nhân theo bác sĩ
    public List<UserAccount> getPatientsByDoctor(int userid) {
        List<UserAccount> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT u.* FROM Booking b
            JOIN [UserAccount] u ON b.user_id = u.user_id
            WHERE b.user_id = ?
        """;
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserAccount u = new UserAccount(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("status")
                );
                list.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy thuốc theo mã lịch khám
    public List<Medicine> getMedicineByBookingId(int bookingId) {
        List<Medicine> list = new ArrayList<>();
        String sql = """
        SELECT m.* FROM Booking_Medicine bm
        JOIN Medicine m ON bm.medicine_id = m.medicine_id
        WHERE bm.booking_id = ?
    """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Medicine m = new Medicine();
                m.setMedicineId(rs.getString("medicine_id"));
                m.setMedicineName(rs.getString("medicine_name"));
                m.setImage(rs.getString("image"));
                m.setSupplier(rs.getString("supplier"));
                m.setType(rs.getString("type"));
                m.setDosage(rs.getString("dosage"));
                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void updateStatus(int bookingId, String newStatus) {
        String sql = "UPDATE Booking SET status = ? WHERE booking_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Các method chưa dùng - có thể xóa nếu không cần
    public void markAsCompleted(String bookingId) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    

    

}
