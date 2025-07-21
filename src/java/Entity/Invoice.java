/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author LENOVO
 */
public class Invoice {
    private int invoiceId;
    private String bookingId;
    private LocalDateTime invoiceDate;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String paymentStatus;
    
    public Invoice() {
    }
    
    public Invoice(int invoiceId, String bookingId, LocalDateTime invoiceDate, BigDecimal totalAmount, String paymentMethod, String paymentStatus) {
        this.invoiceId = invoiceId;
        this.bookingId = bookingId;
        this.invoiceDate = invoiceDate;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
    }
    
    public Invoice(String bookingId, BigDecimal totalAmount, String paymentMethod, String paymentStatus) {
        this.bookingId = bookingId;
        this.invoiceDate = LocalDateTime.now();
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public LocalDateTime getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(LocalDateTime invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
}
