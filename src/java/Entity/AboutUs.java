/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author LENOVO
 */
public class AboutUs {
    private String about_id;
    private String address;
    private String email;
    private String phone;
    private String description;

    // Constructors
    public AboutUs() {}

    public AboutUs(String about_id, String address, String email, String phone, String description) {
        this.about_id = about_id;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.description = description;
    }

    // Getters & Setters
    public String getAbout_id() { return about_id; }
    public void setAbout_id(String about_id) { this.about_id = about_id; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
