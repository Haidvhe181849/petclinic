package DAO;

import Entity.UserAccount;
import Utility.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserAccountDAO extends DBContext {

    public List<UserAccount> getAllAccounts() {
        List<UserAccount> accounts = new ArrayList<>();
        String sql = "SELECT * FROM UserAccount ORDER BY user_id";

        try {
            if (connection == null || connection.isClosed()) {
                connection = getConnection();
            }

            PreparedStatement stmt = connection.prepareStatement(sql);
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
                        rs.getString("status") != null ? rs.getString("status") : "Active"
                );
                accounts.add(user);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.err.println("Lỗi lấy danh sách tài khoản: " + e.getMessage());
        }

        return accounts;
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
                        rs.getString("status") != null ? rs.getString("status") : "Active"
                );
            }
        } catch (SQLException e) {
            System.err.println("Lỗi lấy thông tin người dùng: " + e.getMessage());
        }
        return null;
    }

    public boolean isEmailExists(String email, int excludeUserId) {
        String sql = "SELECT COUNT(*) FROM UserAccount WHERE email = ? AND user_id != ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setInt(2, excludeUserId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra email: " + e.getMessage());
        }
        return false;
    }

    public boolean isUsernameExists(String username, int excludeUserId) {
        String sql = "SELECT COUNT(*) FROM UserAccount WHERE username = ? AND user_id != ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setInt(2, excludeUserId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi kiểm tra username: " + e.getMessage());
        }
        return false;
    }

    public boolean createUser(UserAccount user) {
        if (isEmailExists(user.getEmail(), 0) || isUsernameExists(user.getUsername(), 0)) {
            return false;
        }

        String sql = "INSERT INTO UserAccount (name, phone, email, username, password, address, role_id, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPhone());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getUsername());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getAddress());
            stmt.setInt(7, user.getRoleId());
            stmt.setString(8, user.getStatus() != null ? user.getStatus() : "Active");

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi tạo tài khoản: " + e.getMessage());
            return false;
        }
    }

    public boolean updateUser(UserAccount user) {
        if (isEmailExists(user.getEmail(), user.getUserId()) || isUsernameExists(user.getUsername(), user.getUserId())) {
            return false;
        }

        String sql = (user.getPassword() == null || user.getPassword().isEmpty()) ?
                "UPDATE UserAccount SET name = ?, phone = ?, email = ?, username = ?, address = ?, role_id = ?, status = ? WHERE user_id = ?" :
                "UPDATE UserAccount SET name = ?, phone = ?, email = ?, username = ?, password = ?, address = ?, role_id = ?, status = ? WHERE user_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getPhone());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getUsername());
            int index = 5;
            if (sql.contains("password")) {
                stmt.setString(index++, user.getPassword());
            }
            stmt.setString(index++, user.getAddress());
            stmt.setInt(index++, user.getRoleId());
            stmt.setString(index++, user.getStatus() != null ? user.getStatus() : "Active");
            stmt.setInt(index, user.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật tài khoản: " + e.getMessage());
            return false;
        }
    }

    public boolean updateUserStatus(int userId, String newStatus) {
        String sql = "UPDATE UserAccount SET status = ? WHERE user_id = ?";
        try {
            if (connection == null || connection.isClosed()) {
                connection = getConnection();
            }
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, newStatus);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi cập nhật trạng thái tài khoản: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM UserAccount WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi xóa tài khoản: " + e.getMessage());
            return false;
        }
    }

    public List<UserAccount> getFilteredAccounts(int roleId, String status, String searchTerm) {
        List<UserAccount> filteredAccounts = new ArrayList<>();

        try {
            List<UserAccount> allAccounts = getAllAccounts();

            for (UserAccount user : allAccounts) {
                boolean matchesRole = roleId <= 0 || user.getRoleId() == roleId;
                boolean matchesStatus = status == null || status.isEmpty() || user.getStatus().equalsIgnoreCase(status);
                boolean matchesSearch = searchTerm == null || searchTerm.isEmpty()
                        || user.getName().toLowerCase().contains(searchTerm.toLowerCase())
                        || user.getEmail().toLowerCase().contains(searchTerm.toLowerCase())
                        || user.getUsername().toLowerCase().contains(searchTerm.toLowerCase());

                if (matchesRole && matchesStatus && matchesSearch) {
                    filteredAccounts.add(user);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi lọc danh sách tài khoản: " + e.getMessage());
        }

        return filteredAccounts;
    }
} 