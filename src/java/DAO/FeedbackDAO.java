package DAO;

import Entity.Feedback;
import Utility.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO extends DBContext {
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    // Add default constructor
    public FeedbackDAO() {
        super();
    }
    
    // Add constructor with connection parameter
    public FeedbackDAO(Connection connection) {
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

    public List<Feedback> getAllFeedbacks() {
        List<Feedback> list = new ArrayList<>();
        String query = "SELECT f.*, u.email as user_email, u.name as user_name "
                + "FROM [dbo].[Feedback] f "
                + "LEFT JOIN [dbo].[UserAccount] u ON f.user_id = u.user_id "
                + "ORDER BY f.post_time DESC";
        try {
           
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            System.out.println("Executing query: " + query);

            while (rs.next()) {
                Feedback f = new Feedback();
                f.setFeedbackId(rs.getInt("feedback_id"));
                f.setUserId(rs.getInt("user_id"));
                f.setBookingId(rs.getString("booking_id"));
                f.setFeedbackText(rs.getString("feedback_text"));
                f.setReplyText(rs.getString("reply_text"));
                f.setPostTime(rs.getTimestamp("post_time"));
                f.setStarRating(rs.getInt("star_rating"));
                f.setVisible(rs.getBoolean("is_visible"));
                f.setUserEmail(rs.getString("user_email"));
                f.setUserName(rs.getString("user_name"));
                list.add(f);
                System.out.println("Found feedback: " + f.getFeedbackId() + " - " + f.getFeedbackText());
            }
            System.out.println("Total feedbacks found: " + list.size());
        } catch (Exception e) {
            System.out.println("Error in getAllFeedbacks: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    public Feedback getFeedbackById(int feedbackId) {
        String query = "SELECT f.*, u.email as user_email, u.name as user_name "
                + "FROM [dbo].[Feedback] f "
                + "LEFT JOIN [dbo].[UserAccount] u ON f.user_id = u.user_id "
                + "WHERE f.feedback_id = ?";
        try {
           
            System.out.println("Getting feedback with ID: " + feedbackId);

            ps = connection.prepareStatement(query);
            ps.setInt(1, feedbackId);
            System.out.println("Executing query: " + query);

            rs = ps.executeQuery();
            if (rs.next()) {
                Feedback f = new Feedback();
                f.setFeedbackId(rs.getInt("feedback_id"));
                f.setUserId(rs.getInt("user_id"));
                f.setBookingId(rs.getString("booking_id"));
                f.setFeedbackText(rs.getString("feedback_text"));
                f.setReplyText(rs.getString("reply_text"));
                f.setPostTime(rs.getTimestamp("post_time"));
                f.setStarRating(rs.getInt("star_rating"));
                f.setVisible(rs.getBoolean("is_visible"));
                f.setUserEmail(rs.getString("user_email"));
                f.setUserName(rs.getString("user_name"));
                System.out.println("Found feedback: " + f.getFeedbackId() + " - " + f.getFeedbackText());
                return f;
            }
            System.out.println("No feedback found with ID: " + feedbackId);
            return null;
        } catch (Exception e) {
            System.out.println("Error in getFeedbackById: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            closeResources();
        }
    }

    public boolean toggleVisibility(int feedbackId, boolean visible) {
        String query = "UPDATE [dbo].[Feedback] SET is_visible = ? WHERE feedback_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setBoolean(1, visible);
            ps.setInt(2, feedbackId);
            System.out.println("Toggling visibility: ID=" + feedbackId + ", visible=" + visible);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error in toggleVisibility: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    public boolean replyToFeedback(int feedbackId, String replyText) {
        String query = "UPDATE [dbo].[Feedback] SET reply_text = ? WHERE feedback_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, replyText);
            ps.setInt(2, feedbackId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error in replyToFeedback: " + e.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    public int getTotalFeedbackCount() {
        String query = "SELECT COUNT(*) FROM [dbo].[Feedback]";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Error in getTotalFeedbackCount: " + e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    public List<Feedback> getFeedbacksByPage(int page, int pageSize) {
        List<Feedback> list = new ArrayList<>();
        String query = "SELECT f.*, u.email as user_email, u.name as user_name "
                + "FROM [dbo].[Feedback] f "
                + "LEFT JOIN [dbo].[UserAccount] u ON f.user_id = u.user_id "
                + "ORDER BY f.post_time DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            rs = ps.executeQuery();
            while (rs.next()) {
                Feedback f = new Feedback();
                f.setFeedbackId(rs.getInt("feedback_id"));
                f.setUserId(rs.getInt("user_id"));
                f.setBookingId(rs.getString("booking_id"));
                f.setFeedbackText(rs.getString("feedback_text"));
                f.setReplyText(rs.getString("reply_text"));
                f.setPostTime(rs.getTimestamp("post_time"));
                f.setStarRating(rs.getInt("star_rating"));
                f.setVisible(rs.getBoolean("is_visible"));
                f.setUserEmail(rs.getString("user_email"));
                f.setUserName(rs.getString("user_name"));
                list.add(f);
            }
        } catch (Exception e) {
            System.out.println("Error in getFeedbacksByPage: " + e.getMessage());
        } finally {
            closeResources();
        }
        return list;
    }
    
    // Check if a booking already has feedback
    public boolean hasBookingFeedback(String bookingId) {
        String query = "SELECT COUNT(*) FROM [dbo].[Feedback] WHERE booking_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, bookingId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.out.println("Error in hasBookingFeedback: " + e.getMessage());
        } finally {
            closeResources();
        }
        return false;
    }
    
    // Add new feedback
    public boolean addFeedback(Feedback feedback) {
        String query = "INSERT INTO [dbo].[Feedback] (user_id, booking_id, feedback_text, post_time, star_rating, is_visible) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, feedback.getUserId());
            ps.setString(2, feedback.getBookingId());
            ps.setString(3, feedback.getFeedbackText());
            ps.setTimestamp(4, feedback.getPostTime());
            ps.setInt(5, feedback.getStarRating());
            ps.setBoolean(6, feedback.isVisible());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error in addFeedback: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }
    
    // Get feedback by booking ID
    public Feedback getFeedbackByBookingId(String bookingId) {
        String query = "SELECT f.*, u.email as user_email, u.name as user_name "
                + "FROM [dbo].[Feedback] f "
                + "LEFT JOIN [dbo].[UserAccount] u ON f.user_id = u.user_id "
                + "WHERE f.booking_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, bookingId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Feedback f = new Feedback();
                f.setFeedbackId(rs.getInt("feedback_id"));
                f.setUserId(rs.getInt("user_id"));
                f.setBookingId(rs.getString("booking_id"));
                f.setFeedbackText(rs.getString("feedback_text"));
                f.setReplyText(rs.getString("reply_text"));
                f.setPostTime(rs.getTimestamp("post_time"));
                f.setStarRating(rs.getInt("star_rating"));
                f.setVisible(rs.getBoolean("is_visible"));
                f.setUserEmail(rs.getString("user_email"));
                f.setUserName(rs.getString("user_name"));
                return f;
            }
            return null;
        } catch (Exception e) {
            System.out.println("Error in getFeedbackByBookingId: " + e.getMessage());
            return null;
        } finally {
            closeResources();
        }
    }

    public static void main(String[] args) {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Feedback> feedbacks = feedbackDAO.getAllFeedbacks();

        System.out.println("------ All Feedbacks ------");
        for (Feedback f : feedbacks) {
            System.out.println("ID: " + f.getFeedbackId());
            System.out.println("User: " + f.getUserName() + " (" + f.getUserEmail() + ")");
            System.out.println("Booking ID: " + f.getBookingId());
            System.out.println("Text: " + f.getFeedbackText());
            System.out.println("Reply: " + f.getReplyText());
            System.out.println("Posted at: " + f.getPostTime());
            System.out.println("Star Rating: " + f.getStarRating());
            System.out.println("Visible: " + f.isVisible());
            System.out.println("-----------------------------");
        }

        if (feedbacks.isEmpty()) {
            System.out.println("No feedbacks found.");
        }
    }
}
