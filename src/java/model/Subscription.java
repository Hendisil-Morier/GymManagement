package model;

import java.math.BigDecimal;
import java.util.Date;

public class Subscription {

    private int subscriptionId;
    private String planName;
    private int maxMembers;
    private BigDecimal price;
    private Date startDate;
    private Date endDate;
    private String status;

    public Subscription() {
    }

    public Subscription(int subscriptionId, String planName, int maxMembers, BigDecimal price, Date startDate, Date endDate, String status) {
        this.subscriptionId = subscriptionId;
        this.planName = planName;
        this.maxMembers = maxMembers;
        this.price = price;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
    }

    public int getSubscriptionId() {
        return subscriptionId;
    }

    public void setSubscriptionId(int subscriptionId) {
        this.subscriptionId = subscriptionId;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public int getMaxMembers() {
        return maxMembers;
    }

    public void setMaxMembers(int maxMembers) {
        this.maxMembers = maxMembers;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
