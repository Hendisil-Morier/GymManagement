package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import service.OrderService;
import util.VNPayConfig;
import util.VNPayUtil;

@WebServlet(name = "VNPayReturnController", urlPatterns = {"/vnpay-return"})
public class VNPayReturnServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, String> fields = new HashMap<>();
        Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                fields.put(fieldName, fieldValue);
            }
        }

        boolean isValidSignature = VNPayUtil.verifyReturnHash(fields);

        String responseCode = request.getParameter("vnp_ResponseCode");
        String txnRef = request.getParameter("vnp_TxnRef");

        if (isValidSignature && "00".equals(responseCode) && txnRef != null) {
            try {
                int orderId = Integer.parseInt(txnRef);

                // Cập nhật đơn hàng thành Active + tạo Payment với method VNPAY (tái sử dụng logic business)
                boolean approved = orderService.approveOrderWithMethod(orderId, "VNPAY");

                HttpSession session = request.getSession();
                // Sau khi thanh toán thành công, có thể xóa giỏ hàng
                session.removeAttribute("cart");

                // Redirect về trang checkout với thông tin thành công để hiển thị cho người dùng
                response.sendRedirect(request.getContextPath() + "/cart?action=checkout&successOrderId=" + txnRef);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Thanh toán thất bại hoặc sai chữ ký -> quay lại trang checkout với thông báo lỗi
        String code = responseCode != null ? responseCode : "UNKNOWN";
        response.sendRedirect(request.getContextPath() + "/cart?action=checkout&vnp_ResponseCode=" + code);
    }
}

