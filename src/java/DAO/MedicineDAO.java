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

    public boolean isMedicineNameExists(String name) throws Exception {

        String sql = "SELECT COUNT(*) FROM Medicine WHERE medicine_name = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
        return false;
    }

 
    public List<Medicine> getAllMediciness() {
        List<Medicine> medicineList = new ArrayList<>();
        String sql = "SELECT medicine_id, medicine_name, image, supplier, type FROM Medicine";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Medicine medicine = new Medicine();
                medicine.setMedicineId(rs.getString("medicine_id"));
                medicine.setMedicineName(rs.getString("medicine_name"));
                medicine.setImage(rs.getString("image"));
                medicine.setSupplier(rs.getString("supplier"));
                medicine.setType(rs.getString("type"));
               

                medicineList.add(medicine);
            }

        } catch (SQLException e) {
            e.printStackTrace(); // hoặc log nếu cần
        }

        return medicineList;
    }


    
    public List<Medicine> getFilteredMedicines(String keyword, String type, String sortBy) {
        List<Medicine> list = new ArrayList<>();

        String sql = "SELECT * FROM Medicine WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (medicine_name LIKE ? OR supplier LIKE ?)";
        }

        if (type != null && !type.trim().isEmpty()) {
            sql += " AND type = ?";
        }

        if ("name".equals(sortBy)) {
            sql += " ORDER BY medicine_name";
        } else if ("supplier".equals(sortBy)) {
            sql += " ORDER BY supplier";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
                ps.setString(index++, "%" + keyword + "%");
            }
            if (type != null && !type.trim().isEmpty()) {
                ps.setString(index++, type);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicine m = new Medicine(
                            rs.getString("medicine_id"),
                            rs.getString("medicine_name"),
                            rs.getString("image"),
                            rs.getString("supplier"),
                            rs.getString("type")
                           
                    );
                    list.add(m);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countFilteredMedicines(String keyword, String type) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Medicine WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (medicine_name LIKE ? OR supplier LIKE ?)";
        }

        if (type != null && !type.trim().isEmpty()) {
            sql += " AND type = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
                ps.setString(index++, "%" + keyword + "%");
            }
            if (type != null && !type.trim().isEmpty()) {
                ps.setString(index++, type);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    public List<Medicine> getFilteredMedicinesPaged(String keyword, String type, String sortBy, int offset, int limit) {
    List<Medicine> list = new ArrayList<>();
    String sql = "SELECT * FROM Medicine WHERE 1=1";

    if (keyword != null && !keyword.trim().isEmpty()) {
        sql += " AND (medicine_name LIKE ? OR supplier LIKE ?)";
    }

    if (type != null && !type.trim().isEmpty()) {
        sql += " AND type = ?";
    }

    if ("name".equals(sortBy)) {
        sql += " ORDER BY medicine_name";
    } else if ("supplier".equals(sortBy)) {
        sql += " ORDER BY supplier";
    } else {
        sql += " ORDER BY medicine_id";
    }

    sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        int index = 1;
        if (keyword != null && !keyword.trim().isEmpty()) {
            ps.setString(index++, "%" + keyword + "%");
            ps.setString(index++, "%" + keyword + "%");
        }
        if (type != null && !type.trim().isEmpty()) {
            ps.setString(index++, type);
        }

        ps.setInt(index++, offset);
        ps.setInt(index, limit);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Medicine m = new Medicine(
                        rs.getString("medicine_id"),
                        rs.getString("medicine_name"),
                        rs.getString("image"),
                        rs.getString("supplier"),
                        rs.getString("type")
                        
                );
                list.add(m);
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

    public int countAllMedicines() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Medicine";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Medicine> getMedicinesByPage(int page, int pageSize) throws SQLException {
        List<Medicine> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = "SELECT * FROM Medicine ORDER BY medicine_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql);) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Medicine(
                        rs.getString("medicine_id"),
                        rs.getString("medicine_name"),
                        rs.getString("image"),
                        rs.getString("supplier"),
                        rs.getString("type")
                ));
            }
        }

        return list;
    }

    public void addMedicine(Medicine medicine) throws SQLException {
        String sql = "INSERT INTO Medicine (medicine_id, medicine_name, image, supplier, type ) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, medicine.getMedicineId());
        ps.setString(2, medicine.getMedicineName());
        ps.setString(3, medicine.getImage());
        ps.setString(4, medicine.getSupplier());
        ps.setString(5, medicine.getType());
        
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
                    rs.getString("type")
                   
            );
            list.add(m);
        }

        rs.close();
        st.close();
        return list;
    }

    public void updateMedicine(Medicine medicine) throws SQLException {
        String sql = "UPDATE Medicine SET medicine_name = ?, image = ?, supplier = ?, type = ? WHERE medicine_id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, medicine.getMedicineName());
        ps.setString(2, medicine.getImage());
        ps.setString(3, medicine.getSupplier());
        ps.setString(4, medicine.getType());
        ps.setString(5, medicine.getMedicineId());
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
