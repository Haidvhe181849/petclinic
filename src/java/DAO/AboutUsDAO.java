/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author trung123
 */
import Entity.AboutUs;
import Utility.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


public class AboutUsDAO  {

     private Connection conn;

    public AboutUsDAO() {
        DBContext db = new DBContext();
        this.conn = db.connection;
    }

    public List<AboutUs> getAll() {
        List<AboutUs> list = new ArrayList<>();
        String sql = "SELECT * FROM AboutUs";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new AboutUs(
                    rs.getString("about_id"),
                    rs.getString("address"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(AboutUs about) {
        String sql = "INSERT INTO AboutUs(about_id, address, email, phone, description) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            // Generate UUID if about_id is null or empty
            if (about.getAbout_id() == null || about.getAbout_id().isEmpty()) {
                about.setAbout_id("AU-" + UUID.randomUUID().toString().substring(0, 8));
            }
            ps.setString(1, about.getAbout_id());
            ps.setString(2, about.getAddress());
            ps.setString(3, about.getEmail());
            ps.setString(4, about.getPhone());
            ps.setString(5, about.getDescription());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(AboutUs about) {
        String sql = "UPDATE AboutUs SET address=?, email=?, phone=?, description=? WHERE about_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, about.getAddress());
            ps.setString(2, about.getEmail());
            ps.setString(3, about.getPhone());
            ps.setString(4, about.getDescription());
            ps.setString(5, about.getAbout_id());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(String about_id) {
        String sql = "DELETE FROM AboutUs WHERE about_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, about_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public AboutUs getById(String about_id) {
        String sql = "SELECT * FROM AboutUs WHERE about_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, about_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new AboutUs(
                    rs.getString("about_id"),
                    rs.getString("address"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("description")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}