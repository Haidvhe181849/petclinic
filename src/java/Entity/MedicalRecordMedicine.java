package Entity;

public class MedicalRecordMedicine {
    private int medicalRecordId;
    private String medicineId;

    public MedicalRecordMedicine() {
    }

    public MedicalRecordMedicine(int medicalRecordId, String medicineId) {
        this.medicalRecordId = medicalRecordId;
        this.medicineId = medicineId;
    }

    public int getMedicalRecordId() {
        return medicalRecordId;
    }

    public void setMedicalRecordId(int medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }

    public String getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(String medicineId) {
        this.medicineId = medicineId;
    }

    @Override
    public String toString() {
        return "MedicalRecordMedicine{" +
                "medicalRecordId=" + medicalRecordId +
                ", medicineId='" + medicineId + '\'' +
                '}';
    }
}

