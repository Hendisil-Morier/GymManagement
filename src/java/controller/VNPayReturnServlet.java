package controller;

import dao.VoucherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import model.Voucher;
import service.OrderService;
import util.VNPayUtil;

@WebServlet(name = "VNPayReturnController", urlPatterns = {"/vnpay-return"})
public class VNPayReturnServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();
    private final VoucherDAO voucherDAO = new VoucherDAO();

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
                orderService.approveOrderWithMethod(orderId, "VNPAY");

                HttpSession session = request.getSession();

                // Đánh dấu voucher đã dùng nếu có
                String pendingCode = (String) session.getAttribute("pendingVoucherCode");
                Object pendingMemberIdObj = session.getAttribute("pendingVoucherMemberId");
                if (pendingCode != null && pendingMemberIdObj != null) {
                    try {
                        int memberId = (int) pendingMemberIdObj;
                        Voucher v = voucherDAO.findValidByCodeAndMember(pendingCode, memberId);
                        if (v != null) voucherDAO.markUsed(v.getVoucherId());
                    } catch (Exception e) { e.printStackTrace(); }
                    session.removeAttribute("pendingVoucherCode");
                    session.removeAttribute("pendingVoucherMemberId");
                }

                session.removeAttribute("cart");
                response.sendRedirect(request.getContextPath() + "/cart?action=checkout&successOrderId=" + txnRef);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        String code = responseCode != null ? responseCode : "UNKNOWN";
        response.sendRedirect(request.getContextPath() + "/cart?action=checkout&vnp_ResponseCode=" + code);
    }
}
