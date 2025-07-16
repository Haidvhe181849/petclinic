package DAO;

import Utility.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class MedicalRecordServiceDAO extends DBContext {

    public boolean insert(int medicalRecordId, String serviceId) {
        String sql = "INSERT INTO MedicalRecord_Service (medicalrecord_id, service_id) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, medicalRecordId);
            ps.setString(2, serviceId);

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean insertMultiple(int medicalRecordId, List<String> serviceIds) {
        String sql = "INSERT INTO MedicalRecord_Service (medicalrecord_id, service_id) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (String serviceId : serviceIds) {
                ps.setInt(1, medicalRecordId);
                ps.setString(2, serviceId);
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            return results.length == serviceIds.size();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
