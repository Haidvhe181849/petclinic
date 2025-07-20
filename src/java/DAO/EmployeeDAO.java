/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Employee;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    private Connection connection;

    public EmployeeDAO(Connection connection) {
        this.connection = connection;
    }

    // Thêm nhân viên
    public void addEmployee(Employee e) {
        String sql = "INSERT INTO Employee (employee_id, name, image, phone, email, password, address, role_id, experience, working_hours, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, e.getEmployeeId());
            ps.setString(2, e.getName());
            ps.setString(3, e.getImage());
            ps.setString(4, e.getPhone());
            ps.setString(5, e.getEmail());
            ps.setString(6, e.getPassword());
            ps.setString(7, e.getAddress());
            ps.setInt(8, e.getRoleId());
            ps.setString(9, e.getExperience());
            ps.setString(10, e.getWorkingHours());
            ps.setBoolean(11, e.isStatus());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Cập nhật nhân viên
    public void updateEmployee(Employee e) {
        String sql = "UPDATE Employee SET name=?, image=?, phone=?, email=?, password=?, address=?, role_id=?, experience=?, working_hours=?, status=? WHERE employee_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, e.getName());
            ps.setString(2, e.getImage());
            ps.setString(3, e.getPhone());
            ps.setString(4, e.getEmail());
            ps.setString(5, e.getPassword());
            ps.setString(6, e.getAddress());
            ps.setInt(7, e.getRoleId());
            ps.setString(8, e.getExperience());
            ps.setString(9, e.getWorkingHours());
            ps.setBoolean(10, e.isStatus());
            ps.setString(11, e.getEmployeeId());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Xóa nhân viên
    public void deleteEmployee(String id) {
        String sql = "DELETE FROM Employee WHERE employee_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Lấy tất cả nhân viên
    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM Employee";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Employee e = new Employee(
                        rs.getString("employee_id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("experience"),
                        rs.getString("working_hours"),
                        rs.getBoolean("status")
                );
                list.add(e);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Lấy tất cả nhân viên
    public List<Employee> getAllDoctor() {
        List<Employee> listd = new ArrayList<>();
        String sql = "SELECT * FROM Employee where role_id = 3";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Employee e = new Employee(
                        rs.getString("employee_id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("experience"),
                        rs.getString("working_hours"),
                        rs.getBoolean("status")
                );
                listd.add(e);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listd;
    }

    // Sinh mã tự động
    public String generateNextEmployeeId() {
        String prefix = "E";
        String sql = "SELECT TOP 1 employee_id FROM Employee ORDER BY employee_id DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("employee_id");
                int num = Integer.parseInt(lastId.substring(1));
                return prefix + String.format("%03d", num + 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "E001";
    }

    // Lấy 1 nhân viên theo ID
    public Employee getEmployeeById(String id) {
        String sql = "SELECT * FROM Employee WHERE employee_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Employee(
                        rs.getString("employee_id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("experience"),
                        rs.getString("working_hours"),
                        rs.getBoolean("status")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Lọc nhân viên
    public List<Employee> filterEmployees(String name, String phone, Integer roleId,
            String sortColumn, String sortType, Boolean status) {
        List<Employee> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Employee WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
            params.add("%" + name.trim() + "%");
        }
        if (phone != null && !phone.trim().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + phone.trim() + "%");
        }
        if (roleId != null) {
            sql.append(" AND role_id = ?");
            params.add(roleId);
        }
        if (status != null) {
            sql.append(" AND status = ?");
            params.add(status);
        }
        if (sortColumn != null && (sortColumn.equals("name") || sortColumn.equals("email") || sortColumn.equals("role_id"))) {
            sql.append(" ORDER BY ").append(sortColumn);
            if ("desc".equalsIgnoreCase(sortType)) {
                sql.append(" DESC");
            } else {
                sql.append(" ASC");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Employee e = new Employee(
                        rs.getString("employee_id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("experience"),
                        rs.getString("working_hours"),
                        rs.getBoolean("status")
                );
                list.add(e);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }

    public Employee getEmployeeByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM Employee WHERE email = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Employee(
                        rs.getString("employee_id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("experience"),
                        rs.getString("working_hours"),
                        rs.getBoolean("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePassword(String employeeId, String newPassword) {
        String sql = "UPDATE Employee SET password = ? WHERE employee_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, employeeId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Kiểm tra email đã tồn tại chưa (ngoại trừ employeeId nếu đang update)
    public boolean isEmailExists(String email, String excludeEmployeeId) throws SQLException {
        String sql = "SELECT 1 FROM Employee WHERE email = ? AND employee_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, excludeEmployeeId);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // true nếu đã tồn tại
        }
    }

// Kiểm tra phone đã tồn tại chưa
    public boolean isPhoneExists(String phone, String excludeEmployeeId) throws SQLException {
        String sql = "SELECT 1 FROM Employee WHERE phone = ? AND employee_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phone);
            ps.setString(2, excludeEmployeeId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    public List<Employee> getAvailableDoctorsAtTime(Timestamp ts) throws SQLException {
    String sql = """
        SELECT * FROM Employee
        WHERE role_id = (SELECT role_id FROM Role WHERE role_name = 'Doctor')
        AND employee_id NOT IN (
            SELECT employee_id
            FROM Booking
            WHERE booking_time = ?
            AND employee_id IS NOT NULL
        )
        AND status = 1
    """;
    List<Employee> list = new ArrayList<>();
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setTimestamp(1, ts);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Employee(
                    rs.getString("employee_id"),
                    rs.getString("name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("address"),
                    rs.getString("image"),
                    rs.getInt("role_id"),
                    rs.getString("experience"),
                    rs.getString("working_hours"),
                    rs.getBoolean("status")
            ));
        }
    }
    return list;
}


}
