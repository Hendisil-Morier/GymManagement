package model;

import java.math.BigDecimal;
import java.util.Date;

public class Voucher {
    private int voucherId;
    private int memberId;
    private String code;
    private BigDecimal discountPct;
    private boolean used;
    private Date createdDate;

    public Voucher() {}

    public int getVoucherId() { return voucherId; }
    public void setVoucherId(int voucherId) { this.voucherId = voucherId; }

    public int getMemberId() { return memberId; }
    public void setMemberId(int memberId) { this.memberId = memberId; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public BigDecimal getDiscountPct() { return discountPct; }
    public void setDiscountPct(BigDecimal discountPct) { this.discountPct = discountPct; }

    public boolean isUsed() { return used; }
    public void setUsed(boolean used) { this.used = used; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}
