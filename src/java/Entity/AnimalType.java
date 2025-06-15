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
    private String typeName;

    public AnimalType() {
    }

    public AnimalType(String typeName) {
        this.typeName = typeName;
    }
    
    public AnimalType(String animalTypeId, String typeName) {
        this.animalTypeId = animalTypeId;
        this.typeName = typeName;
    }

    public String getAnimalTypeId() {
        return animalTypeId;
    }

    public void setAnimalTypeId(String animalTypeId) {
        this.animalTypeId = animalTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    @Override
    public String toString() {
        return "AnimalType{" + "animalTypeId=" + animalTypeId + ", typeName=" + typeName + '}';
    }
    
    
}

