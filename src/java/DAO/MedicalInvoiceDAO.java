package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;


import Entity.MedicalInvoice;
import Utility.DBContext;

public class MedicalInvoiceDAO extends DBContext {

    public boolean insertMedicalInvoice(MedicalInvoice invoice) {
        String sql = "INSERT INTO MedicalInvoice (medicalrecord_id, total_amount, payment_date, payment_status, note) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, invoice.getMedicalRecordId());
            ps.setBigDecimal(2, invoice.getTotalAmount());
            ps.setTimestamp(3, Timestamp.valueOf(invoice.getPaymentDate()));  // LocalDateTime -> Timestamp
            ps.setBoolean(4, invoice.isPaymentStatus());
            ps.setString(5, invoice.getNote());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
