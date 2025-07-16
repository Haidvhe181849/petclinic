package Entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class MedicalInvoice {
    private int invoiceId;
    private int medicalRecordId;
    private BigDecimal totalAmount;
    private LocalDateTime paymentDate;
    private boolean paymentStatus; // true = đã thanh toán, false = chưa
    private String note;

    // Constructors
    public MedicalInvoice() {
    }

    public MedicalInvoice(int invoiceId, int medicalRecordId, BigDecimal totalAmount,
                          LocalDateTime paymentDate, boolean paymentStatus, String note) {
        this.invoiceId = invoiceId;
        this.medicalRecordId = medicalRecordId;
        this.totalAmount = totalAmount;
        this.paymentDate = paymentDate;
        this.paymentStatus = paymentStatus;
        this.note = note;
    }

    // Getters and Setters
    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getMedicalRecordId() {
        return medicalRecordId;
    }

    public void setMedicalRecordId(int medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    public boolean isPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(boolean paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}

