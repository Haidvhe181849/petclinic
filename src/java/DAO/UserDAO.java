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
import java.util.ArrayList;
import java.util.List;

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
                        rs.getString("image"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("status") // lấy status
                );
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đăng nhập: " + e.getMessage());
        }
        return null;
    }

    public boolean register(UserAccount user) {
        String sql = "INSERT INTO UserAccount (name, phone, email, username, password, address, role_id, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPhone());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getUsername());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getAddress());
            stmt.setInt(7, user.getRoleId());
            stmt.setString(8, user.getStatus()); // thêm status
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
                        rs.getInt("role_id"),
                        rs.getString("status") // lấy status
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
                        rs.getInt("role_id"),
                        rs.getString("status") // lấy status
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

    public List<UserAccount> getAllAccounts() {
        List<UserAccount> list = new ArrayList<>();
        String sql = "SELECT * FROM UserAccount";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                UserAccount user = new UserAccount(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("status"));
                list.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách tài khoản: " + e.getMessage());
        }
        return list;
    }

    public boolean updateUser(UserAccount user) {
        String sql = "UPDATE UserAccount SET name=?, phone=?, email=?, username=?, password=?, address=?, role_id=?, status=? WHERE user_id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPhone());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getUsername());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getAddress());
            stmt.setInt(7, user.getRoleId());
            stmt.setString(8, user.getStatus());
            stmt.setInt(9, user.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật tài khoản: " + e.getMessage());
            return false;
        }
    }

    public boolean toggleStatus(int userId) {
        // First check if user exists
        UserAccount user = getUserById(userId);
        if (user == null) {
            System.err.println("Không tìm thấy tài khoản có ID: " + userId);
            return false;
        }

        String sql = "UPDATE UserAccount SET status = CASE WHEN status = 'Active' THEN 'Inactive' ELSE 'Active' END WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Đã cập nhật trạng thái tài khoản ID " + userId + " thành công");
                return true;
            } else {
                System.err.println("Không thể cập nhật trạng thái tài khoản ID " + userId);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đổi trạng thái tài khoản: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

}
