/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.UserAccount;
import Utility.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author USA
 */
public class UserDAO extends DBContext {

    public UserAccount login(String username, String password) {
        String sql = "SELECT * FROM UserAccount WHERE username = ? AND password = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new UserAccount(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("address"),
                    rs.getInt("role_id")
                );
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đăng nhập: " + e.getMessage());
        }
        return null;
    }

    public boolean register(UserAccount user) {
        String sql = "INSERT INTO UserAccount (name, phone, email, username, password, address, role_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPhone());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getUsername());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getAddress());
            stmt.setInt(7, user.getRoleId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi đăng ký: " + e.getMessage());
            return false;
        }
    }

    public UserAccount getUserById(int userId) {
        String sql = "SELECT * FROM UserAccount WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new UserAccount(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("address"),
                    rs.getInt("role_id")
                );
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy thông tin người dùng: " + e.getMessage());
        }
        return null;
    }

    public UserAccount getUserByEmail(String email) {
        String sql = "SELECT * FROM UserAccount WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new UserAccount(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("address"),
                    rs.getInt("role_id")
                );
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy thông tin người dùng theo email: " + e.getMessage());
        }
        return null;
    }

    public boolean updatePassword(UserAccount user) {
        String sql = "UPDATE UserAccount SET password = ? WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getPassword());
            stmt.setInt(2, user.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật mật khẩu: " + e.getMessage());
            return false;
        }
    }
    
    
}
