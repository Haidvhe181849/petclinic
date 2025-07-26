/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Breed;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class BreedDAO {

    private Connection conn;

    public BreedDAO(Connection conn) {
        this.conn = conn;
    }

    // Generate a new unique Breed ID (example: B016, B017...)
    public String getNextBreedId() {
        String query = "SELECT TOP 1 breed_id FROM Breed ORDER BY breed_id DESC";
        try (PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("breed_id"); // e.g., B015
                int num = Integer.parseInt(lastId.substring(1)); // "015" -> 15
                return String.format("B%03d", num + 1); // B016
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "B001"; // Nếu chưa có gì
    }

    // Get all breeds
    public List<Breed> getAllBreeds() throws SQLException {
        List<Breed> list = new ArrayList<>();
        String sql = "SELECT * FROM Breed";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRowToBreed(rs));
            }
        }
        return list;
    }

    // Filtered list by name, status, and order
    public List<Breed> getFilteredBreed(String name, String status, String order, String typeId) throws SQLException {
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

        if (typeId != null && !typeId.trim().isEmpty()) {
            sql.append(" AND animal_type_id = ?");
            params.add(typeId);
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
    
    public Breed getByNameBreed(String name, String typeId) {
        String sql = "SELECT * FROM Breed WHERE breed_name = ? and animal_type_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, typeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Breed(rs.getString("breed_id"),
                            rs.getString("image"),
                            rs.getString("breed_name"),
                            rs.getString("animal_type_id"),
                            rs.getBoolean("is_active"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Add a new breed
    public boolean addBreed(Breed breed) {
        if (breed.getBreedId() == null || breed.getBreedId().isEmpty()) {
            breed.setBreedId(getNextBreedId());
        }
        String sql = "INSERT INTO Breed (breed_id, image, breed_name, animal_type_id, is_active) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, breed.getBreedId());
            ps.setString(2, breed.getImage());
            ps.setString(3, breed.getBreedName());
            ps.setString(4, breed.getAnimalTypeId());
            ps.setBoolean(5, breed.isActive());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update an existing breed
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

    // Delete a breed
    public boolean deleteBreed(String breedId) throws SQLException {
        String sql = "DELETE FROM Breed WHERE breed_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, breedId);
            return ps.executeUpdate() > 0;
        }
    }

    private Breed mapRowToBreed(ResultSet rs) throws SQLException {
        return new Breed(
                rs.getString("breed_id"),
                rs.getString("image"),
                rs.getString("breed_name"),
                rs.getString("animal_type_id"),
                rs.getBoolean("is_active")
        );
    }

    // AnimalDAO.java
    public boolean isBreedNameExistsInType(String breedName, String animalTypeId, String excludeBreedId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Breed WHERE LOWER(breed_name) = LOWER(?) AND animal_type_id = ?";
        if (excludeBreedId != null && !excludeBreedId.trim().isEmpty()) {
            sql += " AND breed_id <> ?";
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, breedName.trim());
            ps.setString(2, animalTypeId);

            if (excludeBreedId != null && !excludeBreedId.trim().isEmpty()) {
                ps.setString(3, excludeBreedId);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }

        return false;
    }

}
