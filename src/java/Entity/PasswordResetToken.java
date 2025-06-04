/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.util.Date;
/**
 *
 * @author USA
 */
public class PasswordResetToken {

    private int id;
    private int userId;
    private String token;
    private Date expiry;
    
    public PasswordResetToken() {
    }

    public PasswordResetToken(int id, int userId, String token, Date expiry) {
        this.id = id;
        this.userId = userId;
        this.token = token;
        this.expiry = expiry;
    }

   
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getExpiry() {
        return expiry;
    }

    public void setExpiry(Date expiry) {
        this.expiry = expiry;
    }
}
