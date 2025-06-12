/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author LENOVO
 */


public class Employee {

    private String employeeId;
    private String name;
    private String phone;
    private String email;
    private String password;
    private String address;
    private int roleId;
    private String experience;
    private String workingHours;
    private boolean status;

  
    public Employee() {
    }

    public Employee(String name, String phone, String email, String password, String address, int roleId, String experience, String workingHours, boolean status) {
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.password = password;
        this.address = address;
        this.roleId = roleId;
        this.experience = experience;
        this.workingHours = workingHours;
        this.status = status;
    }

    public Employee(String employeeId, String name, String phone, String email, String password, String address, int roleId, String experience, String workingHours, boolean status) {
        this.employeeId = employeeId;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.password = password;
        this.address = address;
        this.roleId = roleId;
        this.experience = experience;
        this.workingHours = workingHours;
        this.status = status;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getWorkingHours() {
        return workingHours;
    }

    public void setWorkingHours(String workingHours) {
        this.workingHours = workingHours;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Employee{" + "employeeId=" + employeeId + ", name=" + name + ", phone=" + phone + ", email=" + email + ", password=" + password + ", address=" + address + ", roleId=" + roleId + ", experience=" + experience + ", workingHours=" + workingHours + ", status=" + status + '}';
    }
    

  
}
