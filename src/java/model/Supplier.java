package model;

public class Supplier {

    private int supplierId;
    private String companyName;
    private String phone;
    private String email;
    private String supplyType;
    private String address;
    private String status;

    public Supplier() {
    }

    public Supplier(int supplierId, String companyName, String phone, String email,
                    String supplyType, String address, String status) {
        this.supplierId = supplierId;
        this.companyName = companyName;
        this.phone = phone;
        this.email = email;
        this.supplyType = supplyType;
        this.address = address;
        this.status = status;
    }

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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

    public String getSupplyType() {
        return supplyType;
    }

    public void setSupplyType(String supplyType) {
        this.supplyType = supplyType;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
