/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Service;
import Utility.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author LENOVO
 */
public class ServiceDAO extends DBContext {

    private Connection connection;

    public ServiceDAO(Connection connection) {
        this.connection = connection;
    }


    public List<Service> getAllServices() throws SQLException {
        String sql = "SELECT * FROM Service";
        List<Service> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Service s = new Service(
                        rs.getString("service_id"),
                        rs.getString("service_name"),
                        rs.getDouble("price"),
                        rs.getString("description")
                );
                list.add(s);
            }
        }
        return list;
    }

    public Vector<Service> getAllService(String sql) {
        Vector<Service> listService = new Vector<>();

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Service s = new Service(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getString(4)
                );
                listService.add(s);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listService;
    }

    public Vector<Service> searchService(String sql) {
        Vector<Service> listService = new Vector<>();

        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {

            while (rs.next()) {
                Service s = new Service(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getString(4)
                );
                listService.add(s);
            }
            System.out.println("Products fetched: " + listService.size());

        } catch (SQLException ex) {
            Logger.getLogger(NewsDAO.class.getName()).log(Level.SEVERE, "Error fetching products", ex);
        }
        return listService;
    }

    public int insertService(Service s) {
        String sql = "INSERT INTO Service (service_id, service_name, price, description) VALUES (?, ?, ?, ?)";
        int i = 0;
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, s.getService_id());
            ptm.setString(2, s.getService_name());
            ptm.setDouble(3, s.getPrice());
            ptm.setString(4, s.getDescription());

            i = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return i;
    }

    public String generateNextServiceId() {
        String sql = "SELECT TOP 1 service_id FROM Service ORDER BY service_id DESC";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("service_id");
                int num = Integer.parseInt(lastId.substring(1));
                num++; // tăng lên
                return String.format("S%03d", num);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "S001";
    }

    public void updateService(Service s) {
        String sql = "UPDATE Service SET service_name = ?, price = ?, description = ? WHERE service_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, s.getService_name());
            ptm.setDouble(2, s.getPrice());
            ptm.setString(3, s.getDescription());
            ptm.setString(4, s.getService_id());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public int deleteService(String service_id) {
        String sql = "DELETE FROM [dbo].[Service]\n"
                + "      WHERE service_id=?";
        int i = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, service_id);
            i = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return i;
    }


}
