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

public class PetDAO{

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
}
