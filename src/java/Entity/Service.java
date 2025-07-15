package Entity;

/**
 *
 * @author LENOVO
 */
public class Service {

    private String serviceId;
    private String image;
    private String serviceName;
    private double price;
    private String description;
    private boolean status;

    public Service() {
        this.serviceId = "";
        this.image = "";
        this.serviceName = "";
        this.price = 0;
        this.description = "";
        this.status = true; 
    }

    public Service(String image, String serviceName, double price, String description, boolean status) {
        this.image = image;
        this.serviceName = serviceName;
        this.price = price;
        this.description = description;
        this.status = status;
    }

    public Service(String serviceId, String image, String serviceName, double price, String description, boolean status) {
        this.serviceId = serviceId;
        this.image = image;
        this.serviceName = serviceName;
        this.price = price;
        this.description = description;
        this.status = status;
    }

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Service{" +
                "serviceId='" + serviceId + '\'' +
                ", image='" + image + '\'' +
                ", serviceName='" + serviceName + '\'' +
                ", price=" + price +
                ", description='" + description + '\'' +
                ", status=" + status +
                '}';
    }
}
