/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author LENOVO
 */
public class Service {
    
    private String service_id;
    private String service_name;
    private double price;
    private String description;

    public Service() {
        this.service_id = "";
        this.service_name = "";
        this.price = 0;
        this.description = "";
    }

    public Service(String service_name, double price, String description) {
        this.service_name = service_name;
        this.price = price;
        this.description = description;
    }

    public Service(String service_id, String service_name, double price, String description) {
        this.service_id = service_id;
        this.service_name = service_name;
        this.price = price;
        this.description = description;
    }

     public String getServiceId() {
        return service_id;
    }

    public void setServiceId(String serviceId) {
        this.service_id = service_id;
    }

    public String getServiceName() {
        return service_name;
    }

    public void setServiceName(String serviceName) {
        this.service_name = service_name;
    }
    
    public String getService_id() {
        return service_id;
    }

    public void setService_id(String service_id) {
        this.service_id = service_id;
    }

    public String getService_name() {
        return service_name;
    }

    public void setService_name(String service_name) {
        this.service_name = service_name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Service{" + "service_id=" + service_id + ", service_name=" + service_name + ", price=" + price + ", description=" + description + '}';
    }
    
    
    
    
    
}
