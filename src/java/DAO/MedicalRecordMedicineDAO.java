package DAO;

import Entity.MedicalRecordMedicine;
import Utility.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class MedicalRecordMedicineDAO {

    private final Connection conn;

    public MedicalRecordMedicineDAO() {
        this.conn = new DBContext().connection;
    }

    public MedicalRecordMedicineDAO(Connection conn) {
        this.conn = conn;
    }

    // ✅ Thêm 1 bản ghi vào bảng MedicalRecord_Medicine
    public boolean insert(MedicalRecordMedicine mrm) {
        String sql = "INSERT INTO MedicalRecord_Medicine (medicalrecord_id, medicine_id) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mrm.getMedicalRecordId());
            ps.setString(2, mrm.getMedicineId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Insert MedicalRecordMedicine failed: " + e.getMessage());
            return false;
        }
    }

    // ✅ Thêm nhiều thuốc cùng lúc cho 1 phiếu khám
    public boolean insertMany(int medicalRecordId, List<String> medicineIds) {
        String sql = "INSERT INTO MedicalRecord_Medicine (medicalrecord_id, medicine_id) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (String medicineId : medicineIds) {
                System.out.println("Insert thuốc: " + medicineId + " vào record: " + medicalRecordId);
                ps.setInt(1, medicalRecordId);
                ps.setString(2, medicineId);
                ps.addBatch();
            }
            ps.executeBatch();
            return true;
        } catch (SQLException e) {
            e.printStackTrace(); // Không được nuốt lỗi
            return false;
        }
    }

}
