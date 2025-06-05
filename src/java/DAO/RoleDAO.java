package DAO;

import Entity.Role;
import Utility.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author USA
 */
public class RoleDAO extends DBContext {

    public Role getRoleById(String roleId) {
        String sql = "SELECT role_id, role_name FROM Role WHERE role_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, roleId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Role(
                    rs.getInt("role_id"),
                    rs.getString("role_name")
                );
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy Role theo ID: " + e.getMessage());
        }
        return null;
    }
}