package service;

import dao.MemberDAO;
import dao.OrderDAO;
import dao.PaymentDAO;
import dao.RevenueDAO;
import dao.VoucherDAO;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;
import model.Member;
import model.Order;
import model.OrderDetail;
import model.Payment;
import model.Revenue;
import model.Voucher;

public class OrderService implements IOrderService {

    private final OrderDAO orderDAO = new OrderDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final RevenueDAO revenueDAO = new RevenueDAO();
    private final MemberDAO memberDAO = new MemberDAO();
    private final VoucherDAO voucherDAO = new VoucherDAO();

    @Override
    public List<Order> getAllOrders() {
        try { return orderDAO.findAll(); }
        catch (Exception e) { e.printStackTrace(); return List.of(); }
    }

    @Override
    public List<Order> getOrdersByMember(int memberId) {
        try { return orderDAO.findByMemberId(memberId); }
        catch (Exception e) { e.printStackTrace(); return List.of(); }
    }

    @Override
    public Order getOrderById(int orderId) {
        try { return orderDAO.findById(orderId); }
        catch (Exception e) { e.printStackTrace(); return null; }
    }

    @Override
    public List<OrderDetail> getOrderDetails(int orderId) {
        try { return orderDAO.findOrderDetails(orderId); }
        catch (Exception e) { e.printStackTrace(); return List.of(); }
    }

    @Override
    public int createOrder(Order order, List<OrderDetail> details) {
        try {
            int orderId = orderDAO.insert(order);
            if (orderId > 0) {
                for (OrderDetail od : details) {
                    od.setOrderId(orderId);
                    orderDAO.insertOrderDetail(od);
                }
            }
            return orderId;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    @Override
    public boolean approveOrder(int orderId) {
        return approveOrderWithMethod(orderId, "Cash");
    }

    public boolean approveOrderWithMethod(int orderId, String method) {
        try {
            Order order = orderDAO.findById(orderId);
            if (order == null || !"Pending".equals(order.getStatus())) return false;

            int durationMonths = getDurationFromOrderDetails(orderId);

            Calendar cal = Calendar.getInstance();
            java.sql.Date startDate = new java.sql.Date(cal.getTimeInMillis());
            cal.add(Calendar.MONTH, durationMonths);
            java.sql.Date endDate = new java.sql.Date(cal.getTimeInMillis());

            orderDAO.activateOrder(orderId, startDate, endDate);

            // Tạo voucher 10% cho lần mua kế tiếp
            String newVoucherCode = null;
            try {
                Member memberForVoucher = memberDAO.findById(order.getMemberId());
                if (memberForVoucher != null) {
                    Voucher voucher = new Voucher();
                    voucher.setMemberId(memberForVoucher.getMemberId());
                    voucher.setCode("GYM10-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
                    voucher.setDiscountPct(new BigDecimal("10.00"));
                    voucherDAO.insert(voucher);
                    newVoucherCode = voucher.getCode();
                }
            } catch (Exception e) { e.printStackTrace(); }

            // Gửi email xác nhận + thông báo voucher
            try {
                Member member = memberDAO.findById(order.getMemberId());
                Order updated = orderDAO.findById(orderId);
                if (member != null && updated != null) {
                    new EmailService().sendOrderApprovedEmail(member, updated, newVoucherCode);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setAmount(order.getTotalAmount());
            payment.setMethod(method);
            int paymentId = paymentDAO.insert(payment);

            if (paymentId > 0) {
                Revenue rev = new Revenue();
                rev.setPaymentId(paymentId);
                rev.setAmount(order.getTotalAmount());
                rev.setSourceType("Package");
                revenueDAO.insert(rev);
            }

            memberDAO.updateSpending(order.getMemberId(), order.getTotalAmount());

            Member m = memberDAO.findById(order.getMemberId());
            if (m != null) {
                String type = "New Member";
                if (m.getTotalSpending() != null && m.getTotalSpending().compareTo(new BigDecimal("10000000")) > 0) {
                    type = "VIP";
                } else if (m.getRenewalCount() > 3) {
                    type = "Loyal Member";
                }
                memberDAO.updateMemberType(m.getMemberId(), type);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean cancelOrder(int orderId) {
        try { return orderDAO.updateStatus(orderId, "Cancelled"); }
        catch (Exception e) { e.printStackTrace(); return false; }
    }

    private int getDurationFromOrderDetails(int orderId) {
        try {
            List<OrderDetail> details = orderDAO.findOrderDetails(orderId);
            for (OrderDetail od : details) {
                if ("Package".equals(od.getItemType()) && od.getPackageId() != null) {
                    dao.PackageDAO pkgDao = new dao.PackageDAO();
                    model.GymPackage pkg = pkgDao.findById(od.getPackageId());
                    if (pkg != null) return pkg.getDurationMonth();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 1;
    }
}
