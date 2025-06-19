/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Entity.UserAccount;
import Utility.DBContext;

import java.sql.*;
import java.util.*;
/**
 *
 * @author trung123
 */
public class DoctorPatientDAO extends DBContext {

    public List<UserAccount> getPatientsByDoctor(String doctorId) {
        List<UserAccount> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT ua.user_id, ua.name, ua.email, ua.phone
            FROM Booking b
            JOIN UserAccount ua ON b.user_id = ua.user_id
            WHERE b.employee_id = ?
            """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, doctorId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UserAccount u = new UserAccount();
                u.setuserId(rs.getString("user_id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                list.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
