package model;

import java.math.BigDecimal;
import java.util.Date;

public class Order {

    private int orderId;
    private int memberId;
    private Date orderDate;
    private String status;
    private BigDecimal totalAmount;
    private Date startDate;
    private Date endDate;

    public Order() {
    }

    public Order(int orderId, int memberId, Date orderDate, String status, BigDecimal totalAmount, Date startDate, Date endDate) {
        this.orderId = orderId;
        this.memberId = memberId;
        this.orderDate = orderDate;
        this.status = status;
        this.totalAmount = totalAmount;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
