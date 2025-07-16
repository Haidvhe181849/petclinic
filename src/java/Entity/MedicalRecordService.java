package Entity;

public class MedicalRecordService {
    private int medicalRecordId;
    private String serviceId;

    // Constructors
    public MedicalRecordService() {
    }

    public MedicalRecordService(int medicalRecordId, String serviceId) {
        this.medicalRecordId = medicalRecordId;
        this.serviceId = serviceId;
    }

    // Getters and Setters
    public int getMedicalRecordId() {
        return medicalRecordId;
    }

    public void setMedicalRecordId(int medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }
}
