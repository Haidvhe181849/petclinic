package Entity;

import java.time.LocalDateTime;

public class MedicalRecord {
    private int medicalRecordId;
    private String bookingId;
    private String petId;
    private String employeeId;
    private String symptoms;
    private String diagnosis;
    private String testResults;
    private String image;
    private LocalDateTime createdAt;

    // Constructors
    public MedicalRecord() {}

    public MedicalRecord(int medicalRecordId, String bookingId, String petId, String employeeId, String symptoms, String diagnosis, String testResults, String image, LocalDateTime createdAt) {
        this.medicalRecordId = medicalRecordId;
        this.bookingId = bookingId;
        this.petId = petId;
        this.employeeId = employeeId;
        this.symptoms = symptoms;
        this.diagnosis = diagnosis;
        this.testResults = testResults;
        this.image = image;
        this.createdAt = createdAt;
    }

    public MedicalRecord(String bookingId, String petId, String employeeId, String symptoms, String diagnosis, String testResults, String image, LocalDateTime createdAt) {
        this.bookingId = bookingId;
        this.petId = petId;
        this.employeeId = employeeId;
        this.symptoms = symptoms;
        this.diagnosis = diagnosis;
        this.testResults = testResults;
        this.image = image;
        this.createdAt = createdAt;
    }
    

    // Getters and Setters

    public int getMedicalRecordId() {
        return medicalRecordId;
    }

    public void setMedicalRecordId(int medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getPetId() {
        return petId;
    }

    public void setPetId(String petId) {
        this.petId = petId;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getTestResults() {
        return testResults;
    }

    public void setTestResults(String testResults) {
        this.testResults = testResults;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }


    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
