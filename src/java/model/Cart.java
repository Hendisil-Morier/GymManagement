package model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Cart {

    private List<CartItem> items;
    private BigDecimal discountAmount = BigDecimal.ZERO;
    private String appliedVoucherCode;

    public Cart() {
        this.items = new ArrayList<>();
    }

    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }

    public String getAppliedVoucherCode() { return appliedVoucherCode; }
    public void setAppliedVoucherCode(String appliedVoucherCode) { this.appliedVoucherCode = appliedVoucherCode; }

    public void clearVoucher() {
        this.discountAmount = BigDecimal.ZERO;
        this.appliedVoucherCode = null;
    }

    public void addItem(CartItem item) {
        items.add(item);
    }

    public void removeItem(int index) {
        if (index >= 0 && index < items.size()) {
            items.remove(index);
        }
    }

    public List<CartItem> getItems() {
        return items;
    }

    public BigDecimal getSubtotal() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
        }
        return total;
    }

    public BigDecimal getTotal() {
        BigDecimal result = getSubtotal().subtract(discountAmount);
        return result.compareTo(BigDecimal.ZERO) < 0 ? BigDecimal.ZERO : result;
    }

    public void clear() {
        items.clear();
    }
}
