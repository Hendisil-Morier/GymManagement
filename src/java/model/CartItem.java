package model;

import java.math.BigDecimal;

public class CartItem {

    private int packageId;
    private String packageName;
    private String serviceName;
    private int serviceId;
    private String itemType;
    private int quantity;
    private BigDecimal price;

    public CartItem() {
    }

    public CartItem(int packageId, String packageName, String serviceName, int serviceId, String itemType, int quantity, BigDecimal price) {
        this.packageId = packageId;
        this.packageName = packageName;
        this.serviceName = serviceName;
        this.serviceId = serviceId;
        this.itemType = itemType;
        this.quantity = quantity;
        this.price = price;
    }

    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
