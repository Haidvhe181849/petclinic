
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
        String sql = "SELECT * FROM Employee WHERE role_id = 2";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Employee doctor = new Employee(
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
                doctors.add(doctor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return doctors;
    }

}
