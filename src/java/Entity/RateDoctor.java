package Entity;

import java.sql.Timestamp;

public class RateDoctor {
    private int rateId;
    private int userId;
    private String employeeId;
    private String bookingId;
    private int rating;
    private String comment;
    private Timestamp rateTime;
    
    // Additional fields for display purposes
    private String userName;
    private String userEmail;
    private String doctorName;
    
    public RateDoctor() {
    }
    
    public RateDoctor(int rateId, int userId, String employeeId, String bookingId, int rating, String comment, Timestamp rateTime) {
        this.rateId = rateId;
        this.userId = userId;
        this.employeeId = employeeId;
        this.bookingId = bookingId;
        this.rating = rating;
        this.comment = comment;
        this.rateTime = rateTime;
    }

    public int getRateId() {
        return rateId;
    }

    public void setRateId(int rateId) {
        this.rateId = rateId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getRateTime() {
        return rateTime;
    }

    public void setRateTime(Timestamp rateTime) {
        this.rateTime = rateTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    @Override
    public String toString() {
        return "RateDoctor{" + "rateId=" + rateId + ", userId=" + userId + ", employeeId=" + employeeId + 
               ", bookingId=" + bookingId + ", rating=" + rating + ", comment=" + comment + ", rateTime=" + rateTime + '}';
    }
} 