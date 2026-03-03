package service;

import dao.MemberDAO;
import dao.OrderDAO;
import dao.PaymentDAO;
import dao.RevenueDAO;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;
import model.Member;
import model.Order;
import model.OrderDetail;
import model.Payment;
import model.Revenue;

public class OrderService implements IOrderService {

    private final OrderDAO orderDAO = new OrderDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final RevenueDAO revenueDAO = new RevenueDAO();
    private final MemberDAO memberDAO = new MemberDAO();

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
        try {
            Order order = orderDAO.findById(orderId);
            if (order == null || !"Pending".equals(order.getStatus())) return false;

            int durationMonths = getDurationFromOrderDetails(orderId);

            Calendar cal = Calendar.getInstance();
            java.sql.Date startDate = new java.sql.Date(cal.getTimeInMillis());
            cal.add(Calendar.MONTH, durationMonths);
            java.sql.Date endDate = new java.sql.Date(cal.getTimeInMillis());

            orderDAO.activateOrder(orderId, startDate, endDate);

            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setAmount(order.getTotalAmount());
            payment.setMethod("Cash");
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
