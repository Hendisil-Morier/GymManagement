package controller;

import dao.PackageDAO;
import dao.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import model.*;
import service.OrderService;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();
    private final ServiceDAO serviceDAO = new ServiceDAO();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "view";

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        switch (action) {
            case "remove":
                int index = Integer.parseInt(request.getParameter("index"));
                cart.removeItem(index);
                response.sendRedirect(request.getContextPath() + "/cart");
                break;
            case "clear":
                cart.clear();
                response.sendRedirect(request.getContextPath() + "/cart");
                break;
            case "checkout":
                request.setAttribute("cart", cart);
                request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
                break;
            default:
                request.setAttribute("cart", cart);
                request.getRequestDispatcher("/cart/cart.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        if ("addPackage".equals(action)) {
            try {
                int pkgId = Integer.parseInt(request.getParameter("packageId"));
                GymPackage pkg = packageDAO.findById(pkgId);
                if (pkg != null) {
                    CartItem item = new CartItem();
                    item.setPackageId(pkgId);
                    item.setPackageName(pkg.getPackageName());
                    item.setItemType("Package");
                    item.setQuantity(1);
                    item.setPrice(pkg.getPrice());
                    cart.addItem(item);
                }
            } catch (Exception e) { e.printStackTrace(); }
            response.sendRedirect(request.getContextPath() + "/cart");

        } else if ("addService".equals(action)) {
            try {
                int svcId = Integer.parseInt(request.getParameter("serviceId"));
                Service svc = serviceDAO.findById(svcId);
                if (svc != null) {
                    CartItem item = new CartItem();
                    item.setServiceId(svcId);
                    item.setServiceName(svc.getServiceName());
                    item.setItemType("Service");
                    item.setQuantity(1);
                    item.setPrice(svc.getPrice());
                    cart.addItem(item);
                }
            } catch (Exception e) { e.printStackTrace(); }
            response.sendRedirect(request.getContextPath() + "/cart");

        } else if ("placeOrder".equals(action)) {
            User user = (User) session.getAttribute("user");
            Member member = (Member) session.getAttribute("member");

            if (user == null || member == null || cart.getItems().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            Order order = new Order();
            order.setMemberId(member.getMemberId());
            order.setStatus("Pending");
            order.setTotalAmount(cart.getTotal());

            List<OrderDetail> details = new ArrayList<>();
            for (CartItem ci : cart.getItems()) {
                OrderDetail od = new OrderDetail();
                od.setItemType(ci.getItemType());
                od.setQuantity(ci.getQuantity());
                od.setPrice(ci.getPrice());
                if ("Package".equals(ci.getItemType())) {
                    od.setPackageId(ci.getPackageId());
                } else {
                    od.setServiceId(ci.getServiceId());
                }
                details.add(od);
            }

            int orderId = orderService.createOrder(order, details);
            if (orderId > 0) {
                cart.clear();
                request.setAttribute("orderId", orderId);
                request.setAttribute("successMsg", "Order placed successfully! Order #" + orderId);
                request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMsg", "Failed to place order.");
                request.setAttribute("cart", cart);
                request.getRequestDispatcher("/cart/cart.jsp").forward(request, response);
            }
        }
    }
}
