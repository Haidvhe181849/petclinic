package DAO;

import Entity.RateDoctor;
import Utility.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RateDoctorDAO extends DBContext {
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    // Default constructor
    public RateDoctorDAO() {
        super();
    }
    
    // Constructor with connection
    public RateDoctorDAO(Connection connection) {
        super();
        this.connection = connection;
    }

    private void closeResources() {
        try {
            if (rs != null)
                rs.close();
            if (ps != null)
                ps.close();
        } catch (SQLException e) {
            System.out.println("Error closing resources: " + e.getMessage());
        }
    }

    /**
     * Get all doctor ratings
     * @return List of RateDoctor objects
     */
    public List<RateDoctor> getAllRatings() {
        List<RateDoctor> list = new ArrayList<>();
        String query = "SELECT r.*, u.email as user_email, u.name as user_name, e.name as doctor_name "
                + "FROM [dbo].[RateDoctor] r "
                + "LEFT JOIN [dbo].[UserAccount] u ON r.user_id = u.user_id "
                + "LEFT JOIN [dbo].[Employee] e ON r.employee_id = e.employee_id "
                + "ORDER BY r.rate_time DESC";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                RateDoctor r = new RateDoctor();
                r.setRateId(rs.getInt("rate_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setEmployeeId(rs.getString("employee_id"));
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));
                r.setRateTime(rs.getTimestamp("rate_time"));
                r.setUserEmail(rs.getString("user_email"));
                r.setUserName(rs.getString("user_name"));
                r.setDoctorName(rs.getString("doctor_name"));
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("Error in getAllRatings: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    /**
     * Get a rating by its ID
     * @param rateId The rating ID
     * @return RateDoctor object or null if not found
     */
    public RateDoctor getRatingById(int rateId) {
        String query = "SELECT r.*, u.email as user_email, u.name as user_name, e.name as doctor_name "
                + "FROM [dbo].[RateDoctor] r "
                + "LEFT JOIN [dbo].[UserAccount] u ON r.user_id = u.user_id "
                + "LEFT JOIN [dbo].[Employee] e ON r.employee_id = e.employee_id "
                + "WHERE r.rate_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, rateId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                RateDoctor r = new RateDoctor();
                r.setRateId(rs.getInt("rate_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setEmployeeId(rs.getString("employee_id"));
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));
                r.setRateTime(rs.getTimestamp("rate_time"));
                r.setUserEmail(rs.getString("user_email"));
                r.setUserName(rs.getString("user_name"));
                r.setDoctorName(rs.getString("doctor_name"));
                return r;
            }
            return null;
        } catch (Exception e) {
            System.out.println("Error in getRatingById: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            closeResources();
        }
    }

    /**
     * Check if a user has already rated a specific doctor for a specific booking
     * @param userId User ID
     * @param employeeId Doctor ID
     * @param bookingId Booking ID
     * @return true if rating exists, false otherwise
     */
    public boolean hasUserRatedDoctor(int userId, String employeeId, String bookingId) {
        String query = "SELECT COUNT(*) FROM [dbo].[RateDoctor] r "
                + "JOIN [dbo].[Booking] b ON r.employee_id = b.employee_id "
                + "WHERE r.user_id = ? AND r.employee_id = ? AND b.booking_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setString(2, employeeId);
            ps.setString(3, bookingId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.out.println("Error in hasUserRatedDoctor: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    /**
     * Add a new doctor rating
     * @param rating RateDoctor object
     * @return true if successful, false otherwise
     */
    public boolean addRating(RateDoctor rating) {
        String query = "INSERT INTO [dbo].[RateDoctor] (user_id, employee_id, rating, comment, rate_time) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, rating.getUserId());
            ps.setString(2, rating.getEmployeeId());
            ps.setInt(3, rating.getRating());
            ps.setString(4, rating.getComment());
            ps.setTimestamp(5, rating.getRateTime());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error in addRating: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    /**
     * Get average rating for a doctor
     * @param employeeId Doctor ID
     * @return Average rating (0-5) or 0 if no ratings
     */
    public double getAverageRating(String employeeId) {
        String query = "SELECT AVG(CAST(rating AS FLOAT)) FROM [dbo].[RateDoctor] WHERE employee_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, employeeId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                double avg = rs.getDouble(1);
                return avg > 0 ? avg : 0;
            }
        } catch (Exception e) {
            System.out.println("Error in getAverageRating: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    /**
     * Get all ratings for a specific doctor
     * @param employeeId Doctor ID
     * @return List of RateDoctor objects
     */
    public List<RateDoctor> getRatingsByDoctor(String employeeId) {
        List<RateDoctor> list = new ArrayList<>();
        String query = "SELECT r.*, u.email as user_email, u.name as user_name, e.name as doctor_name "
                + "FROM [dbo].[RateDoctor] r "
                + "LEFT JOIN [dbo].[UserAccount] u ON r.user_id = u.user_id "
                + "LEFT JOIN [dbo].[Employee] e ON r.employee_id = e.employee_id "
                + "WHERE r.employee_id = ? "
                + "ORDER BY r.rate_time DESC";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, employeeId);
            rs = ps.executeQuery();

            while (rs.next()) {
                RateDoctor r = new RateDoctor();
                r.setRateId(rs.getInt("rate_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setEmployeeId(rs.getString("employee_id"));
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));
                r.setRateTime(rs.getTimestamp("rate_time"));
                r.setUserEmail(rs.getString("user_email"));
                r.setUserName(rs.getString("user_name"));
                r.setDoctorName(rs.getString("doctor_name"));
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("Error in getRatingsByDoctor: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }
    public RateDoctor getRatingByUserAndBooking(int userId, String employeeId, String bookingId) {
        String query = "SELECT r.*, u.email as user_email, u.name as user_name, e.name as doctor_name "
                + "FROM [dbo].[RateDoctor] r "
                + "LEFT JOIN [dbo].[UserAccount] u ON r.user_id = u.user_id "
                + "LEFT JOIN [dbo].[Employee] e ON r.employee_id = e.employee_id "
                + "JOIN [dbo].[Booking] b ON r.employee_id = b.employee_id "
                + "WHERE r.user_id = ? AND r.employee_id = ? AND b.booking_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setString(2, employeeId);
            ps.setString(3, bookingId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                RateDoctor r = new RateDoctor();
                r.setRateId(rs.getInt("rate_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setEmployeeId(rs.getString("employee_id"));
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));
                r.setRateTime(rs.getTimestamp("rate_time"));
                r.setUserEmail(rs.getString("user_email"));
                r.setUserName(rs.getString("user_name"));
                r.setDoctorName(rs.getString("doctor_name"));
                return r;
            }
        } catch (Exception e) {
            System.out.println("Error in getRatingByUserAndBooking: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }
} 