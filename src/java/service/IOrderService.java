package service;

import java.util.List;
import model.Order;
import model.OrderDetail;

public interface IOrderService {
    List<Order> getAllOrders();
    List<Order> getOrdersByMember(int memberId);
    Order getOrderById(int orderId);
    List<OrderDetail> getOrderDetails(int orderId);
    int createOrder(Order order, List<OrderDetail> details);
    boolean approveOrder(int orderId);
    boolean cancelOrder(int orderId);
}
