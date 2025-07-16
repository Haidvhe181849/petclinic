/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
    private String employeeName;
    private String petName;
    private String serviceName;
    private double servicePrice;

    private String formattedDate;
    private String formattedTime;

    public Booking() {
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

    public Booking(String bookingId, int userId, String employeeId, String serviceId, String petId, String note, LocalDateTime bookingTime, String status, String employeeName, String petName) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.employeeId = employeeId;
        this.serviceId = serviceId;
        this.petId = petId;
        this.note = note;
        this.bookingTime = bookingTime;
        this.status = status;
        this.employeeName = employeeName;
        this.petName = petName;
    }

    public Booking(String bookingId, int userId, String serviceId, String petId, String note, LocalDateTime bookingTime, String status) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.employeeId = null;
        this.serviceId = serviceId;
        this.petId = petId;
        this.note = note;
        this.bookingTime = bookingTime;
        this.status = status;
    }

    public Booking(String bookingId, String note, LocalDateTime bookingTime, String status, String employeeName, String petName, String serviceName) {
        this.bookingId = bookingId;
        this.note = note;
        this.bookingTime = bookingTime;
        this.status = status;
        this.employeeName = employeeName;
        this.petName = petName;
        this.serviceName = serviceName;
    }

    public Booking(String bookingId, LocalDateTime bookingTime, String status, String employeeName, String petName, String serviceName, String formattedDate, String formattedTime) {
        this.bookingId = bookingId;
        this.bookingTime = bookingTime;
        this.formattedDate = formattedDate;
        this.formattedTime = formattedTime;
        this.status = status;
        this.petName = petName;
        this.serviceName = serviceName;
        this.employeeName = employeeName;
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

    public String getFormattedDate() {
        return bookingTime != null ? bookingTime.toLocalDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
    }

    public void setFormattedDate(String formattedDate) {
        this.formattedDate = formattedDate;
    }

    public String getFormattedTime() {
        return bookingTime != null ? bookingTime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")) : "";
    }

    public void setFormattedTime(String formattedTime) {
        this.formattedTime = formattedTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public double getServicePrice() {
        return servicePrice;
    }

    public void setServicePrice(double servicePrice) {
        this.servicePrice = servicePrice;
    }

    @Override
    public String toString() {
        return "Booking{" + "bookingId=" + bookingId + ", userId=" + userId + ", employeeId=" + employeeId + ", serviceId=" + serviceId + ", petId=" + petId + ", note=" + note + ", bookingTime=" + bookingTime + ", status=" + status + '}';
    }

}
