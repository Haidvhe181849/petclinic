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
    private int id;
    private String address;
    private String email;
    private String hotline;
    private String description;

    // Constructors
    public AboutUs() {}

    public AboutUs(int id, String address, String email, String hotline, String description) {
        this.id = id;
        this.address = address;
        this.email = email;
        this.hotline = hotline;
        this.description = description;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getHotline() { return hotline; }
    public void setHotline(String hotline) { this.hotline = hotline; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
