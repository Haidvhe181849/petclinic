/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.time.LocalDateTime;

/**
 *
 * @author LENOVO
 */
public class Booking {

    private String bookingId;
    private int userId;
    private String employeeId;
    private String serviceId;
    private String petId;
    private String note;
    private LocalDateTime bookingTime;
    private String status;

    public Booking() {
    }

    public Booking(int userId, String employeeId, String serviceId, String petId, String note, LocalDateTime bookingTime, String status) {
        this.userId = userId;
        this.employeeId = employeeId;
        this.serviceId = serviceId;
        this.petId = petId;
        this.note = note;
        this.bookingTime = bookingTime;
        this.status = status;
    }

    public Booking(String bookingId, int userId, String employeeId, String serviceId, String petId, String note, LocalDateTime bookingTime, String status) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.employeeId = employeeId;
        this.serviceId = serviceId;
        this.petId = petId;
        this.note = note;
        this.bookingTime = bookingTime;
        this.status = status;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
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

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public String getPetId() {
        return petId;
    }

    public void setPetId(String petId) {
        this.petId = petId;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public LocalDateTime getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(LocalDateTime bookingTime) {
        this.bookingTime = bookingTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Booking{" + "bookingId=" + bookingId + ", userId=" + userId + ", employeeId=" + employeeId + ", serviceId=" + serviceId + ", petId=" + petId + ", note=" + note + ", bookingTime=" + bookingTime + ", status=" + status + '}';
    }

}
