package DAO;

import java.util.Date;
import Entity.Employee;
import java.util.ArrayList;
import java.util.List;
import Utility.DBContext;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.stream.Collectors;

/**
 *
 * @author quang
 */
public class DoctorDAO {

    private Connection connection;

    public DoctorDAO(Connection connection) {
        this.connection = connection;
    }

    public List<Employee> getAllDoctors() {
        List<Employee> doctors = new ArrayList<>();
        String sql = "SELECT * FROM Employee WHERE role_id = 3";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Employee doctor = new Employee();
                doctor.setEmployeeId(rs.getString("employee_id"));
                doctor.setName(rs.getString("name"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setEmail(rs.getString("email"));
                doctor.setPassword(rs.getString("password"));
                doctor.setAddress(rs.getString("address"));
                doctor.setRoleId(rs.getInt("role_id"));
                doctor.setExperience(rs.getString("experience"));
                doctor.setWorkingHours(rs.getString("working_hours"));
                doctor.setStatus("Active".equalsIgnoreCase(rs.getString("status")));

                doctors.add(doctor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return doctors;
    }

    // Thêm mới bác sĩ (ID tự sinh theo dạng 'DOCxxx')
    public void insertDoctor(Employee e) {
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

    // Cập nhật thông tin bác sĩ
    public boolean updateDoctor(Employee doctor) {
        String sql = "UPDATE Employee SET name=?, image=?, phone=?, email=?, password=?, address=?, experience=?, working_hours=?, status=? "
                + "WHERE employee_id=? AND role_id = 3";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, doctor.getName());
            stmt.setString(2, doctor.getImage());
            stmt.setString(3, doctor.getPhone());
            stmt.setString(4, doctor.getEmail());
            stmt.setString(5, doctor.getPassword());
            stmt.setString(6, doctor.getAddress());
            stmt.setString(7, doctor.getExperience());
            stmt.setString(8, doctor.getWorkingHours());
            stmt.setBoolean(9, doctor.isStatus());
            stmt.setString(10, doctor.getEmployeeId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Vô hiệu hóa bác sĩ
    public boolean deactivateDoctor(String doctorId) {
        String sql = "UPDATE Employee SET status = 0 WHERE employee_id = ? AND role_id = 3";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, doctorId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // =============================================
    public String generateNextDoctorId() {
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

    // Lọc nhân viên
    public List<Employee> filterDoctors(String name, String phone,
            String sortColumn, String sortType, Boolean status) {
        List<Employee> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Employee WHERE role_id = 3");
        List<Object> params = new ArrayList<>();

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
            params.add("%" + name.trim() + "%");
        }
        if (phone != null && !phone.trim().isEmpty()) {
            sql.append(" AND phone LIKE ?");
            params.add("%" + phone.trim() + "%");
        }
        if (status != null) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        // Chỉ cho phép sắp xếp theo các cột an toàn
        List<String> allowedSortColumns = Arrays.asList("name", "email", "status");
        if (sortColumn != null && allowedSortColumns.contains(sortColumn)) {
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
    
    public List<Employee> getAllDoctors1() {
        List<Employee> doctors = new ArrayList<>();
        String sql = "SELECT * FROM Employee WHERE role_id = 3";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Employee doctor = new Employee();
                doctor.setEmployeeId(rs.getString("employee_id"));
                doctor.setName(rs.getString("name"));
                doctor.setImage(rs.getString("image"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setEmail(rs.getString("email"));
                doctor.setPassword(rs.getString("password"));
                doctor.setAddress(rs.getString("address"));
                doctor.setRoleId(rs.getInt("role_id"));
                doctor.setExperience(rs.getString("experience"));
                doctor.setWorkingHours(rs.getString("working_hours"));
                doctor.setStatus("Active".equalsIgnoreCase(rs.getString("status")));

                doctors.add(doctor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return doctors;
    }

}
