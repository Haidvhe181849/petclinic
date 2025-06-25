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
        String sql = "SELECT * FROM Employee WHERE role_id = 4";

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

}
