package DAO;

/**
 *
 * @author quang
 */
import Entity.Pet;
import Utility.DBContext;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

public class PetDAO {

    private Connection connection;

    public PetDAO(Connection connection) {
        this.connection = connection;
    }

    public List<Pet> getPetsByOwnerId(int ownerId) {
        List<Pet> pets = new ArrayList<>();
        String sql = "SELECT * FROM Pet WHERE owner_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetId(rs.getString("pet_id"));
                pet.setOwnerId(rs.getInt("owner_id"));
                pet.setPetTypeId(rs.getString("pet_type_id"));
                pet.setName(rs.getString("name"));
                pet.setWeight(rs.getDouble("weight"));
                pet.setBreed(rs.getString("breed"));
                pet.setBirthdate(rs.getDate("birthdate").toLocalDate());
                pet.setImage(rs.getString("image"));

                pets.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }

    public String generateNewPetId() {
        if (connection == null) {
            System.err.println("Connection is null. Cannot generate new pet ID.");
            return "P001"; // fallback
        }

        String sql = "SELECT TOP 1 pet_id FROM Pet WHERE pet_id LIKE 'P%' ORDER BY pet_id DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("pet_id");
                if (lastId != null && lastId.startsWith("P")) {
                    int number = Integer.parseInt(lastId.substring(1)) + 1;
                    return String.format("P%03d", number);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error generating new pet ID:");
            e.printStackTrace();
        }

        return "P001"; // Trả về ID mặc định nếu bảng trống
    }

    public void addPet(Pet pet) {
        String sql = "INSERT INTO Pet (pet_id, owner_id, pet_type_id, name, weight, breed, birthdate, image) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, pet.getPetId());
            ps.setInt(2, pet.getOwnerId());
            ps.setString(3, pet.getPetTypeId());
            ps.setString(4, pet.getName());
            ps.setDouble(5, pet.getWeight());
            ps.setString(6, pet.getBreed());
            ps.setDate(7, Date.valueOf(pet.getBirthdate()));
            ps.setString(8, pet.getImage()); // có thể là null nếu không dùng ảnh

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePet(Pet pet) {
        String sql = "UPDATE Pet SET pet_type_id = ?, name = ?, weight = ?, breed = ?, birthdate = ?, image = ? "
                + "WHERE pet_id = ? AND owner_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, pet.getPetTypeId());
            ps.setString(2, pet.getName());
            ps.setDouble(3, pet.getWeight());
            ps.setString(4, pet.getBreed());
            ps.setDate(5, Date.valueOf(pet.getBirthdate()));
            ps.setString(6, pet.getImage());
            ps.setString(7, pet.getPetId());
            ps.setInt(8, pet.getOwnerId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deletePet(String petId) {
        String sql = "DELETE FROM Pet WHERE pet_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, petId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int countPetsByOwner(int ownerId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Pet WHERE owner_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

}
