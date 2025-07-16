package DAO;

import Utility.DBContext;
import Entity.MedicalRecord;
import java.sql.Timestamp;
import java.sql.*;
import java.time.LocalDateTime;

/**
 *
 * @author quang
 */
public class MedicalRecordDAO extends DBContext {

    public int insertMedicalRecord(MedicalRecord record) {
        String sql = "INSERT INTO MedicalRecord (booking_id, pet_id, employee_id, "
                + "symptoms, diagnosis, test_results, image, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, record.getBookingId());
            ps.setString(2, record.getPetId());
            ps.setString(3, record.getEmployeeId());
            ps.setString(4, record.getSymptoms());
            ps.setString(5, record.getDiagnosis());
            ps.setString(6, record.getTestResults());
            ps.setString(7, record.getImage());
            ps.setTimestamp(8, Timestamp.valueOf(record.getCreatedAt()));

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Trả về record_id
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // nếu thất bại
    }

}
