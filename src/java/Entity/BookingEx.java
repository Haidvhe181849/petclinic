/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;
import java.sql.Timestamp;
/**
 *
 * @author LENOVO
 */
public class BookingEx {
    private String bookingId;
    private String customerName;
    private String petName;
    private String petType;
    private String serviceName;
    private String employeeName;
    private Timestamp bookingTime;
    private String status;

    public BookingEx(String bookingId, String customerName, String petName, String petType, String serviceName, String employeeName, Timestamp bookingTime, String status) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.petName = petName;
        this.petType = petType;
        this.serviceName = serviceName;
        this.employeeName = employeeName;
        this.bookingTime = bookingTime;
        this.status = status;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName;
    }

    public String getPetType() {
        return petType;
    }

    public void setPetType(String petType) {
        this.petType = petType;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public Timestamp getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(Timestamp bookingTime) {
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
        return "BookingEx{" + "bookingId=" + bookingId + ", customerName=" + customerName + ", petName=" + petName + ", petType=" + petType + ", serviceName=" + serviceName + ", employeeName=" + employeeName + ", bookingTime=" + bookingTime + ", status=" + status + '}';
    }
    
    
    
}
