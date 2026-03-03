package model;

import java.math.BigDecimal;

public class GymPackage {

    private int packageId;
    private String packageName;
    private BigDecimal price;
    private int durationMonth;
    private String description;
    private String status;

    public GymPackage() {
    }

    public GymPackage(int packageId, String packageName, BigDecimal price,
                      int durationMonth, String description, String status) {
        this.packageId = packageId;
        this.packageName = packageName;
        this.price = price;
        this.durationMonth = durationMonth;
        this.description = description;
        this.status = status;
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getDurationMonth() {
        return durationMonth;
    }

    public void setDurationMonth(int durationMonth) {
        this.durationMonth = durationMonth;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
