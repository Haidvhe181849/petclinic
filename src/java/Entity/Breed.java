/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author LENOVO
 */
public class Breed {
    private String breedId;
    private String image;
    private String breedName;
    private String animalTypeId; 
    private boolean isActive;

    public Breed() {
    }

    public Breed(String breedId, String image, String breedName, boolean isActive) {
        this.breedId = breedId;
        this.image = image;
        this.breedName = breedName;
        this.isActive = isActive;
    }
    
    

    public Breed(String breedId, String image, String breedName, String animalTypeId, boolean isActive) {
        this.breedId = breedId;
        this.image = image;
        this.breedName = breedName;
        this.animalTypeId = animalTypeId;
        this.isActive = isActive;
    }

    public String getBreedId() {
        return breedId;
    }

    public void setBreedId(String breedId) {
        this.breedId = breedId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBreedName() {
        return breedName;
    }

    public void setBreedName(String breedName) {
        this.breedName = breedName;
    }

    public String getAnimalTypeId() {
        return animalTypeId;
    }

    public void setAnimalTypeId(String animalTypeId) {
        this.animalTypeId = animalTypeId;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    @Override
    public String toString() {
        return "Breed{" + "breedId=" + breedId + ", image=" + image + ", breedName=" + breedName + ", animalTypeId=" + animalTypeId + ", isActive=" + isActive + '}';
    }

}
