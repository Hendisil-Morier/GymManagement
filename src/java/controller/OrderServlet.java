package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Member;
import model.Order;
import model.OrderDetail;
import model.User;
import service.MemberService;
import service.OrderService;

@WebServlet(name = "OrderServlet", urlPatterns = {"/orders"})
public class OrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();
    private final MemberService memberService = new MemberService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "detail":
                int orderId = Integer.parseInt(request.getParameter("id"));
                Order order = orderService.getOrderById(orderId);
                List<OrderDetail> details = orderService.getOrderDetails(orderId);
                if (order != null) {
                    Member orderMember = memberService.getMemberById(order.getMemberId());
                    request.setAttribute("orderMember", orderMember);
                }
                request.setAttribute("order", order);
                request.setAttribute("details", details);
                request.getRequestDispatcher("/orders/orderDetail.jsp").forward(request, response);
                break;
            case "approve":
                int approveId = Integer.parseInt(request.getParameter("id"));
                orderService.approveOrder(approveId);
                response.sendRedirect(request.getContextPath() + "/orders");
                break;
            case "cancel":
                int cancelId = Integer.parseInt(request.getParameter("id"));
                orderService.cancelOrder(cancelId);
                response.sendRedirect(request.getContextPath() + "/orders");
                break;
            default:
                List<Order> orders;
                if ("Member".equals(user.getRole())) {
                    Member member = (Member) session.getAttribute("member");
                    orders = member != null ? orderService.getOrdersByMember(member.getMemberId()) : List.of();
                } else {
                    orders = orderService.getAllOrders();
                }
                request.setAttribute("orders", orders);

                List<Member> allMembers = memberService.getAllMembers();
                request.setAttribute("allMembers", allMembers);

                request.getRequestDispatcher("/orders/orderList.jsp").forward(request, response);
                break;
        }
    }
}
