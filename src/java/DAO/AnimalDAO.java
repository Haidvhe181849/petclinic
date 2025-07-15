/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.AnimalType;
import Entity.Breed;
import Utility.DBContext;
import java.sql.*;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class AnimalDAO {

    private Connection conn;

    public AnimalDAO(Connection conn) {
        this.conn = conn;
    }

    public List<AnimalType> getFilteredAnimalTypes(String name, String status, String order) throws SQLException {
        List<AnimalType> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM AnimalType WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Search by name
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND type_name LIKE ?");
            params.add("%" + name.trim() + "%");
        }

        // Filter by status
        if (status != null && (status.equalsIgnoreCase("true") || status.equalsIgnoreCase("false"))) {
            sql.append(" AND status = ?");
            params.add(Boolean.parseBoolean(status));
        }

        // Order by type name
        if ("asc".equalsIgnoreCase(order)) {
            sql.append(" ORDER BY type_name ASC");
        } else if ("desc".equalsIgnoreCase(order)) {
            sql.append(" ORDER BY type_name DESC");
        }

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AnimalType type = new AnimalType(
                            rs.getString("animal_type_id"),
                            rs.getString("image"),
                            rs.getString("type_name"),
                            rs.getBoolean("status")
                    );
                    list.add(type);
                }
            }
        }

        return list;
    }

    // ✅ Tự động tạo mã ID: A001, A002...
    private String generateNextId() throws SQLException {
        String sql = "SELECT TOP 1 animal_type_id FROM AnimalType ORDER BY animal_type_id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString(1); // VD: A007
                int num = Integer.parseInt(lastId.substring(1)); // -> 7
                return String.format("A%03d", num + 1);          // -> A008
            } else {
                return "A001"; // Trường hợp chưa có bản ghi nào
            }
        }
    }

    // ✅ Thêm AnimalType
    public boolean addAnimalType(AnimalType type) throws SQLException {
        String newId = generateNextId();
        String sql = "INSERT INTO AnimalType (animal_type_id, image, type_name, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newId);
            ps.setString(2, type.getImage());
            ps.setString(3, type.getTypeName());
            ps.setBoolean(4, type.isStatus());
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Sửa
    public boolean updateAnimalType(AnimalType type) throws SQLException {
        String sql = "UPDATE AnimalType SET image = ?, type_name = ?, status = ? WHERE animal_type_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, type.getImage());
            ps.setString(2, type.getTypeName());
            ps.setBoolean(3, type.isStatus());
            ps.setString(4, type.getAnimalTypeId());
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Xoá
    public boolean deleteAnimalType(String id) throws SQLException {
        String sql = "DELETE FROM AnimalType WHERE animal_type_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Danh sách tất cả
    public List<AnimalType> getAllAnimalTypes() throws SQLException {
        List<AnimalType> list = new ArrayList<>();
        String sql = "SELECT * FROM AnimalType";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AnimalType type = new AnimalType(
                        rs.getString("animal_type_id"),
                        rs.getString("image"),
                        rs.getString("type_name"),
                        rs.getBoolean("status")
                );
                list.add(type);
            }
        }
        return list;
    }

    // ✅ Tìm kiếm theo tên (partial match)
    public List<AnimalType> searchAnimalTypeByName(String keyword) throws SQLException {
        List<AnimalType> list = new ArrayList<>();
        String sql = "SELECT * FROM AnimalType WHERE type_name LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AnimalType type = new AnimalType(
                            rs.getString("animal_type_id"),
                            rs.getString("image"),
                            rs.getString("type_name"),
                            rs.getBoolean("status")
                    );
                    list.add(type);
                }
            }
        }
        return list;
    }

    // ✅ Tự động tạo mã ID: B001, B002...
    private String generateNextIdBreed() throws SQLException {
        String sql = "SELECT TOP 1 breed_id FROM Breed ORDER BY breed_id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString(1); // VD: B004
                int num = Integer.parseInt(lastId.substring(1)); // -> 4
                return String.format("B%03d", num + 1);          // -> B005
            } else {
                return "B001"; // Nếu chưa có giống nào
            }
        }
    }

    // Trong AnimalDAO
    public List<Breed> getFilteredBreed(String name, String status, String order) throws SQLException {
        List<Breed> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Breed WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND breed_name LIKE ?");
            params.add("%" + name.trim() + "%");
        }

        if (status != null && (status.equalsIgnoreCase("true") || status.equalsIgnoreCase("false"))) {
            sql.append(" AND is_active = ?");
            params.add(Boolean.parseBoolean(status));
        }

        if ("asc".equalsIgnoreCase(order)) {
            sql.append(" ORDER BY breed_name ASC");
        } else if ("desc".equalsIgnoreCase(order)) {
            sql.append(" ORDER BY breed_name DESC");
        }

        PreparedStatement ps = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Breed(
                    rs.getString("breed_id"),
                    rs.getString("image"),
                    rs.getString("breed_name"),
                    rs.getString("animal_type_id"),
                    rs.getBoolean("is_active")
            ));
        }

        return list;
    }

    // ✅ Thêm giống
    public boolean addBreed(Breed breed) throws SQLException {
        String newId = generateNextId();
        String sql = "INSERT INTO Breed (breed_id, image, breed_name, animal_type_id, is_active) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newId);
            ps.setString(2, breed.getImage());
            ps.setString(3, breed.getBreedName());
            ps.setString(4, breed.getAnimalTypeId());
            ps.setBoolean(5, breed.isActive());
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Sửa giống
    public boolean updateBreed(Breed breed) throws SQLException {
        String sql = "UPDATE Breed SET image = ?, breed_name = ?, animal_type_id = ?, is_active = ? WHERE breed_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, breed.getImage());
            ps.setString(2, breed.getBreedName());
            ps.setString(3, breed.getAnimalTypeId());
            ps.setBoolean(4, breed.isActive());
            ps.setString(5, breed.getBreedId());
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Xoá giống
    public boolean deleteBreed(String breedId) throws SQLException {
        String sql = "DELETE FROM Breed WHERE breed_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, breedId);
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Danh sách tất cả giống
    public List<Breed> getAllBreeds() throws SQLException {
        List<Breed> list = new ArrayList<>();
        String sql = "SELECT * FROM Breed";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        }
        return list;
    }

    // ✅ Danh sách giống theo ID loài
    public List<Breed> getBreedsByAnimalType(String animalTypeId) throws SQLException {
        List<Breed> list = new ArrayList<>();
        String sql = "SELECT * FROM Breed WHERE animal_type_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, animalTypeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSet(rs));
                }
            }
        }
        return list;
    }

    // ✅ Tìm kiếm theo tên giống
    public List<Breed> searchBreedsByName(String keyword) throws SQLException {
        List<Breed> list = new ArrayList<>();
        String sql = "SELECT * FROM Breed WHERE breed_name LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSet(rs));
                }
            }
        }
        return list;
    }

    // ✅ Hàm dựng đối tượng từ ResultSet
    private Breed mapResultSet(ResultSet rs) throws SQLException {
        return new Breed(
                rs.getString("breed_id"),
                rs.getString("image"),
                rs.getString("breed_name"),
                rs.getString("animal_type_id"),
                rs.getBoolean("is_active")
        );
    }

    public static void main(String[] args) {
        try {
            // Kết nối DB
            Connection conn = new DBContext().connection;
            AnimalDAO dao = new AnimalDAO(conn);

            String name = "p";          // Tìm giống tên chứa "poo" (ví dụ: Poodle)
            String status = "true";       // Chỉ lấy giống đang active
            String order = "asc";         // Sắp xếp từ A → Z

            List<Breed> filteredList = dao.getFilteredBreed(name, status, order);

            // In ra kết quả
            if (filteredList.isEmpty()) {
                System.out.println("⚠️ Không tìm thấy giống nào phù hợp với tiêu chí.");
            } else {
                System.out.println("✅ Danh sách giống đã lọc:");
                for (Breed b : filteredList) {
                    System.out.println(b);
                }
            }

        } catch (Exception e) {
            System.err.println("❌ Lỗi khi test getFilteredBreed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public String addAndReturnNewAnimalType(String typeName) throws SQLException {
        String newId = generateNewAnimalTypeId();
        String sql = "INSERT INTO AnimalType (animal_type_id, type_name, status) VALUES (?, ?, 1)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newId);
            ps.setString(2, typeName);
            ps.executeUpdate();
        }
        return newId;
    }

    public String generateNewAnimalTypeId() throws SQLException {
        String sql = "SELECT TOP 1 animal_type_id FROM AnimalType ORDER BY animal_type_id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString(1); // e.g., A005
                int num = Integer.parseInt(lastId.substring(1));
                return String.format("A%03d", num + 1);
            }
        }
        return "A001";
    }

}
