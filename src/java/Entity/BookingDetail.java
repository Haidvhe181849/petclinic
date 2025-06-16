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
public class BookingDetail {
    private String bookingId;
    private String customerName;
    private String customerPhone;
    private String customerEmail;
    private String petName;
    private String petType;
    private String breed;
    private String serviceName;
    private String employeeName;
    private Timestamp bookingTime;
    private String status;
    private Timestamp actualCheckinTime;
    private String note;
    private String cancelReason;

    public BookingDetail(String bookingId, String customerName, String customerPhone, String customerEmail, String petName, String petType, String breed, String serviceName, String employeeName, Timestamp bookingTime, String status, Timestamp actualCheckinTime, String note, String cancelReason) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.customerEmail = customerEmail;
        this.petName = petName;
        this.petType = petType;
        this.breed = breed;
        this.serviceName = serviceName;
        this.employeeName = employeeName;
        this.bookingTime = bookingTime;
        this.status = status;
        this.actualCheckinTime = actualCheckinTime;
        this.note = note;
        this.cancelReason = cancelReason;
    }

    public BookingDetail() {
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

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
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

    public String getBreed() {
        return breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
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

    public Timestamp getActualCheckinTime() {
        return actualCheckinTime;
    }

    public void setActualCheckinTime(Timestamp actualCheckinTime) {
        this.actualCheckinTime = actualCheckinTime;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    @Override
    public String toString() {
        return "BookingDetail{" + "bookingId=" + bookingId + ", customerName=" + customerName + ", customerPhone=" + customerPhone + ", customerEmail=" + customerEmail + ", petName=" + petName + ", petType=" + petType + ", breed=" + breed + ", serviceName=" + serviceName + ", employeeName=" + employeeName + ", bookingTime=" + bookingTime + ", status=" + status + ", actualCheckinTime=" + actualCheckinTime + ", note=" + note + ", cancelReason=" + cancelReason + '}';
    }

 


}
