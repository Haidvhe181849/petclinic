/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author LENOVO
 */
public class Medicine {
    private String medicineId;
    private String medicineName;
    private String image;
    private String supplier;
    private String type;
    private String dosage;

    public Medicine() {
    }

    public Medicine(String medicineName, String image, String supplier, String type, String dosage) {
        this.medicineName = medicineName;
        this.image = image;
        this.supplier = supplier;
        this.type = type;
        this.dosage = dosage;
    }

    public Medicine(String medicineId, String medicineName, String image, String supplier, String type, String dosage) {
        this.medicineId = medicineId;
        this.medicineName = medicineName;
        this.image = image;
        this.supplier = supplier;
        this.type = type;
        this.dosage = dosage;
    }

    public String getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(String medicineId) {
        this.medicineId = medicineId;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    @Override
    public String toString() {
        return "Medicine{" + "medicineId=" + medicineId + ", medicineName=" + medicineName + ", image=" + image + ", supplier=" + supplier + ", type=" + type + ", dosage=" + dosage + '}';
    }

    
    
    
}
