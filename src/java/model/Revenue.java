package model;

import java.math.BigDecimal;
import java.util.Date;

public class Revenue {

    private int revenueId;
    private int paymentId;
    private Date revenueDate;
    private BigDecimal amount;
    private String sourceType;

    public Revenue() {
    }

    public Revenue(int revenueId, int paymentId, Date revenueDate, BigDecimal amount, String sourceType) {
        this.revenueId = revenueId;
        this.paymentId = paymentId;
        this.revenueDate = revenueDate;
        this.amount = amount;
        this.sourceType = sourceType;
    }

    public int getRevenueId() {
        return revenueId;
    }

    public void setRevenueId(int revenueId) {
        this.revenueId = revenueId;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public Date getRevenueDate() {
        return revenueDate;
    }

    public void setRevenueDate(Date revenueDate) {
        this.revenueDate = revenueDate;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getSourceType() {
        return sourceType;
    }

    public void setSourceType(String sourceType) {
        this.sourceType = sourceType;
    }
}
