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
                    rs.getInt("id"),
                    rs.getString("address"),
                    rs.getString("email"),
                    rs.getString("hotline"),
                    rs.getString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(AboutUs about) {
        String sql = "INSERT INTO AboutUs(address, email, hotline, description) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, about.getAddress());
            ps.setString(2, about.getEmail());
            ps.setString(3, about.getHotline());
            ps.setString(4, about.getDescription());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(AboutUs about) {
        String sql = "UPDATE AboutUs SET address=?, email=?, hotline=?, description=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, about.getAddress());
            ps.setString(2, about.getEmail());
            ps.setString(3, about.getHotline());
            ps.setString(4, about.getDescription());
            ps.setInt(5, about.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM AboutUs WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public AboutUs getById(int id) {
        String sql = "SELECT * FROM AboutUs WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new AboutUs(
                    rs.getInt("id"),
                    rs.getString("address"),
                    rs.getString("email"),
                    rs.getString("hotline"),
                    rs.getString("description")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}