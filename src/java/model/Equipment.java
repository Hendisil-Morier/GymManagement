package model;

import java.math.BigDecimal;
import java.util.Date;

public class Equipment {

    private int equipmentId;
    private String equipmentName;
    private int quantity;
    private String status;
    private Date purchaseDate;
    private BigDecimal purchasePrice;
    private int supplierId;

    public Equipment() {
    }

    public Equipment(int equipmentId, String equipmentName, int quantity, String status,
                     Date purchaseDate, BigDecimal purchasePrice, int supplierId) {
        this.equipmentId = equipmentId;
        this.equipmentName = equipmentName;
        this.quantity = quantity;
        this.status = status;
        this.purchaseDate = purchaseDate;
        this.purchasePrice = purchasePrice;
        this.supplierId = supplierId;
    }

    public int getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentId(int equipmentId) {
        this.equipmentId = equipmentId;
    }

    public String getEquipmentName() {
        return equipmentName;
    }

    public void setEquipmentName(String equipmentName) {
        this.equipmentName = equipmentName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public BigDecimal getPurchasePrice() {
        return purchasePrice;
    }

    public void setPurchasePrice(BigDecimal purchasePrice) {
        this.purchasePrice = purchasePrice;
    }

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }
}
