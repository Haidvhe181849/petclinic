/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author LENOVO
 */
public class AnimalType {
    private String animalTypeId;
    private String image;
    private String typeName;
    private boolean status;

    public AnimalType() {
    }

    public AnimalType(String animalTypeId, String image, String typeName, boolean status) {
        this.animalTypeId = animalTypeId;
        this.image = image;
        this.typeName = typeName;
        this.status = status;
    }

    public String getAnimalTypeId() {
        return animalTypeId;
    }

    public void setAnimalTypeId(String animalTypeId) {
        this.animalTypeId = animalTypeId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "AnimalType{" + "animalTypeId=" + animalTypeId + ", image=" + image + ", typeName=" + typeName + ", status=" + status + '}';
    }
    
    
}


    