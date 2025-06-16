/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author LENOVO
 */
import java.time.LocalDate;

public class Pet {

    private String petId;
    private int ownerId;
    private String petTypeId;
    private String namePet;
    private double weight;
    private String breed;
    private LocalDate birthdate;
    private String image;

    public Pet() {
    }

    public Pet(String petId, int ownerId, String petTypeId, String namePet,
            double weight, String breed, LocalDate birthdate, String image) {
        this.petId = petId;
        this.ownerId = ownerId;
        this.petTypeId = petTypeId;
        this.namePet = namePet;
        this.weight = weight;
        this.breed = breed;
        this.birthdate = birthdate;
        this.image = image;
    }

    public Pet(String petId, int ownerId) {
        this.petId = petId;
        this.ownerId = ownerId;
    }

    public String getPetId() {
        return petId;
    }

    public void setPetId(String petId) {
        this.petId = petId;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public String getPetTypeId() {
        return petTypeId;
    }

    public void setPetTypeId(String petTypeId) {
        this.petTypeId = petTypeId;
    }

    public String getNamePet() {
        return namePet;
    }

    public void setNamePet(String namePet) {
        this.namePet = namePet;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getBreed() {
        return breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    public LocalDate getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(LocalDate birthdate) {
        this.birthdate = birthdate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Pet{" + "petId=" + petId + ", ownerId=" + ownerId + ", petTypeId=" + petTypeId + ", namePet=" + namePet + ", weight=" + weight + ", breed=" + breed + ", birthdate=" + birthdate + ", image=" + image + '}';
    }
    

    

}
