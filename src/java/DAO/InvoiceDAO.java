package DAO;

import Entity.Invoice;
import Utility.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.math.BigDecimal;

public class InvoiceDAO extends DBContext {
    private Connection connection;
    
    public InvoiceDAO(Connection connection) {
        this.connection = connection;
    }
    
    public int insertInvoice(Invoice invoice) {
        String sql = "INSERT INTO Invoice (booking_id, invoice_date, total_amount, payment_method, payment_status) "
                + "VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, invoice.getBookingId());
            ps.setTimestamp(2, Timestamp.valueOf(invoice.getInvoiceDate()));
            ps.setBigDecimal(3, invoice.getTotalAmount());
            ps.setString(4, invoice.getPaymentMethod());
            ps.setString(5, invoice.getPaymentStatus());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public Invoice getInvoiceByBookingId(String bookingId) {
        String sql = "SELECT * FROM Invoice WHERE booking_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Invoice invoice = new Invoice();
                    invoice.setInvoiceId(rs.getInt("invoice_id"));
                    invoice.setBookingId(rs.getString("booking_id"));
                    invoice.setInvoiceDate(rs.getTimestamp("invoice_date").toLocalDateTime());
                    invoice.setTotalAmount(rs.getBigDecimal("total_amount"));
                    invoice.setPaymentMethod(rs.getString("payment_method"));
                    invoice.setPaymentStatus(rs.getString("payment_status"));
                    return invoice;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean updatePaymentStatus(String bookingId, String status) {
        String sql = "UPDATE Invoice SET payment_status = ? WHERE booking_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, bookingId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 