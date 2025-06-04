package DAO;

import Entity.PasswordResetToken;
import Utility.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class PasswordResetTokenDAO extends DBContext {
    public boolean createToken(PasswordResetToken token) {
        String sql = "INSERT INTO PasswordResetToken (user_id, token, expiry) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, token.getUserId());
            stmt.setString(2, token.getToken());
            stmt.setTimestamp(3, new java.sql.Timestamp(token.getExpiry().getTime()));
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi tạo token: " + e.getMessage());
            return false;
        }
    }

    public PasswordResetToken findByToken(String token) {
        String sql = "SELECT * FROM PasswordResetToken WHERE token = ? AND expiry > GETDATE()";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new PasswordResetToken(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("token"),
                    rs.getTimestamp("expiry")
                );
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy token: " + e.getMessage());
        }
        return null;
    }

    public boolean deleteToken(String token) {
        String sql = "DELETE FROM PasswordResetToken WHERE token = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, token);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi xóa token: " + e.getMessage());
            return false;
        }
    }

    public void deleteExpiredTokens() {
        String sql = "DELETE FROM PasswordResetToken WHERE expiry <= GETDATE()";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi xóa token hết hạn: " + e.getMessage());
        }
    }
} 