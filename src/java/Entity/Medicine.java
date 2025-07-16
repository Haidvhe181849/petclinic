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
  

    public Medicine() {
    }

    public Medicine(String medicineName, String image, String supplier, String type) {
        this.medicineName = medicineName;
        this.image = image;
        this.supplier = supplier;
        this.type = type;
        
    }

    public Medicine(String medicineId, String medicineName, String image, String supplier, String type) {
        this.medicineId = medicineId;
        this.medicineName = medicineName;
        this.image = image;
        this.supplier = supplier;
        this.type = type;
      
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
  
}
