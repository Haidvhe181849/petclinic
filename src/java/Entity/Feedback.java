/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.sql.Timestamp;

/**
 * Entity class for feedback management
 */
public class Feedback {
    private int feedbackId;
    private int userId;
    private String bookingId;
    private String feedbackText;
    private String replyText;
    private Timestamp postTime;
    private int starRating;
    private boolean isVisible;
    private String userEmail; // Thông tin join từ bảng User
    private String userName; // Thông tin join từ bảng User

    public Feedback() {
        this.isVisible = true; // Mặc định là hiển thị
    }

    // Constructor đầy đủ
    public Feedback(int feedbackId, int userId, String bookingId, String feedbackText,
            String replyText, Timestamp postTime, int starRating, boolean isVisible,
            String userEmail, String userName) {
        this.feedbackId = feedbackId;
        this.userId = userId;
        this.bookingId = bookingId;
        this.feedbackText = feedbackText;
        this.replyText = replyText;
        this.postTime = postTime;
        this.starRating = starRating;
        this.isVisible = isVisible;
        this.userEmail = userEmail;
        this.userName = userName;
    }

    // Getters and Setters
    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getFeedbackText() {
        return feedbackText;
    }

    public void setFeedbackText(String feedbackText) {
        this.feedbackText = feedbackText;
    }

    public String getReplyText() {
        return replyText;
    }

    public void setReplyText(String replyText) {
        this.replyText = replyText;
    }

    public Timestamp getPostTime() {
        return postTime;
    }

    public void setPostTime(Timestamp postTime) {
        this.postTime = postTime;
    }

    public int getStarRating() {
        return starRating;
    }

    public void setStarRating(int starRating) {
        this.starRating = starRating;
    }

    public boolean isVisible() {
        return isVisible;
    }

    public void setVisible(boolean visible) {
        isVisible = visible;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "Feedback{" +
                "feedbackId=" + feedbackId +
                ", userId=" + userId +
                ", bookingId='" + bookingId + '\'' +
                ", feedbackText='" + feedbackText + '\'' +
                ", starRating=" + starRating +
                ", userName='" + userName + '\'' +
                '}';
    }
}
