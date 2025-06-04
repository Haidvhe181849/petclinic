/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Medicine;
import Utility.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author quang
 */
public class MedicineDAO extends DBContext {

    public void addMedicine(Medicine medicine) throws SQLException {
        String sql = "INSERT INTO Medicine (medicine_id, medicine_name, image, supplier, type, dosage) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, medicine.getMedicineId());
        ps.setString(2, medicine.getMedicineName());
        ps.setString(3, medicine.getImage());
        ps.setString(4, medicine.getSupplier());
        ps.setString(5, medicine.getType());
        ps.setString(6, medicine.getDosage());
        ps.executeUpdate();
        ps.close();
    }

    public List<Medicine> getAllMedicines() throws SQLException {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT * FROM Medicine";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
            Medicine m = new Medicine(
                    rs.getString("medicine_id"),
                    rs.getString("medicine_name"),
                    rs.getString("image"),
                    rs.getString("supplier"),
                    rs.getString("type"),
                    rs.getString("dosage")
            );
            list.add(m);
        }

        rs.close();
        st.close();
        return list;
    }

    public void updateMedicine(Medicine medicine) throws SQLException {
        String sql = "UPDATE Medicine SET medicine_name = ?, image = ?, supplier = ?, type = ?, dosage = ? WHERE medicine_id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, medicine.getMedicineName());
        ps.setString(2, medicine.getImage());
        ps.setString(3, medicine.getSupplier());
        ps.setString(4, medicine.getType());
        ps.setString(5, medicine.getDosage());
        ps.setString(6, medicine.getMedicineId());
        ps.executeUpdate();
        ps.close();
    }

    public void deleteMedicine(String id) throws SQLException {
        String sql = "DELETE FROM Medicine WHERE medicine_id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, id);
        ps.executeUpdate();
        ps.close();
    }

    public List<Medicine> searchMedicineByNameOrSupplier(String keyword) throws SQLException {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT * FROM Medicine WHERE medicine_name LIKE ? OR supplier LIKE ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        String searchPattern = "%" + keyword + "%";
        ps.setString(1, searchPattern);
        ps.setString(2, searchPattern);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Medicine medicine = new Medicine(
                    rs.getString("medicine_id"),
                    rs.getString("medicine_name"),
                    rs.getString("image"),
                    rs.getString("supplier"),
                    rs.getString("type"),
                    rs.getString("dosage")
            );
            list.add(medicine);
        }

        rs.close();
        ps.close();
        return list;
    }

    public List<Medicine> getAllMedicinesSortedByName() throws SQLException {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT * FROM Medicine ORDER BY medicine_name ASC";
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Medicine medicine = new Medicine(
                    rs.getString("medicine_id"),
                    rs.getString("medicine_name"),
                    rs.getString("image"),
                    rs.getString("supplier"),
                    rs.getString("type"),
                    rs.getString("dosage")
            );
            list.add(medicine);
        }

        rs.close();
        ps.close();
        return list;
    }

    public List<Medicine> getMedicinesByExactSupplierSorted() throws SQLException {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT * FROM Medicine ORDER BY supplier ASC";
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Medicine medicine = new Medicine(
                    rs.getString("medicine_id"),
                    rs.getString("medicine_name"),
                    rs.getString("image"),
                    rs.getString("supplier"),
                    rs.getString("type"),
                    rs.getString("dosage")
            );
            list.add(medicine);
        }

        rs.close();
        ps.close();
        return list;
    }

    public List<Medicine> getMedicinesByType(String type) throws SQLException {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT * FROM Medicine WHERE type = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, type);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Medicine m = new Medicine(
                    rs.getString("medicine_id"),
                    rs.getString("medicine_name"),
                    rs.getString("image"),
                    rs.getString("supplier"),
                    rs.getString("type"),
                    rs.getString("dosage")
            );
            list.add(m);
        }

        rs.close();
        ps.close();
        return list;
    }

    public String generateNextMedicineId() {
        String sql = "SELECT TOP 1 medicine_id FROM Medicine ORDER BY medicine_id DESC";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("medicine_id"); // ví dụ "MED012"
                int num = Integer.parseInt(lastId.substring(3)); // bỏ 3 ký tự đầu "MED"
                num++; // tăng lên
                return String.format("MED%03d", num); // ví dụ "MED013"
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "MED001"; // Nếu chưa có gì trong DB
    }

}
