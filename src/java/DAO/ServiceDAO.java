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

public class ServiceDAO extends DBContext {

    private Connection connection;

    public ServiceDAO(Connection connection) {
        this.connection = connection;
    }

    public Vector<Service> getAllService(String sql) {
        Vector<Service> listService = new Vector<>();
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                Service s = new Service(
                        rs.getString("service_id"),
                        rs.getString("image"),
                        rs.getString("service_name"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getBoolean("status")
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
                        rs.getString("service_id"),
                        rs.getString("image"),
                        rs.getString("service_name"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getBoolean("status")
                );
                listService.add(s);
            }
            System.out.println("Services fetched: " + listService.size());
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, "Error fetching services", ex);
        }
        return listService;
    }

    public List<Service> searchFilteredServices(String name, String status, String order, Double minPrice, Double maxPrice) {
        List<Service> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Service WHERE 1=1");

        if (name != null && !name.isEmpty()) {
            sql.append(" AND service_name LIKE N'%").append(name.replaceAll("\\s+", "%")).append("%'");
        }

        if (status != null && !status.isEmpty()) {
            if (status.equalsIgnoreCase("active")) {
                sql.append(" AND status = 1");
            } else if (status.equalsIgnoreCase("inactive")) {
                sql.append(" AND status = 0");
            }
        }

        if (minPrice != null) {
            sql.append(" AND price >= ").append(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND price <= ").append(maxPrice);
        }

        if (order != null && (order.equalsIgnoreCase("asc") || order.equalsIgnoreCase("desc"))) {
            sql.append(" ORDER BY price ").append(order);
        }

        // Gọi hàm getAllService truyền câu query
        return getAllService(sql.toString());
    }

    public int insertService(Service s) {
        String sql = "INSERT INTO Service (service_id, image, service_name, price, description, status) VALUES (?, ?, ?, ?, ?, ?)";
        int i = 0;
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, s.getServiceId());
            ptm.setString(2, s.getImage());
            ptm.setString(3, s.getServiceName());
            ptm.setDouble(4, s.getPrice());
            ptm.setString(5, s.getDescription());
            ptm.setBoolean(6, s.isStatus());

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
                num++;
                return String.format("S%03d", num);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "S001";
    }

    public void updateService(Service s) {
        String sql = "UPDATE Service SET image = ?, service_name = ?, price = ?, description = ?, status = ? WHERE service_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, s.getImage());
            ptm.setString(2, s.getServiceName());
            ptm.setDouble(3, s.getPrice());
            ptm.setString(4, s.getDescription());
            ptm.setBoolean(5, s.isStatus());
            ptm.setString(6, s.getServiceId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public int deleteService(String service_id) {
        String sql = "DELETE FROM [dbo].[Service] WHERE service_id=?";
        int i = 0;
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, service_id);
            i = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return i;
    }

    public boolean isDuplicateServiceName(String serviceName, String excludeId) {
        String sql = "SELECT COUNT(*) FROM Service WHERE service_name = ?"
                + (excludeId != null ? " AND service_id != ?" : "");
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, serviceName);
            if (excludeId != null) {
                ptm.setString(2, excludeId);
            }
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

}
