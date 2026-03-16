package util;



/**

 * VNPay Configuration Constants.

 * Replace vnp_TmnCode and vnp_HashSecret with your actual sandbox credentials

 * from https://sandbox.vnpayment.vn/devreg

 */

public class VNPayConfig {



    // ===== VNPAY SANDBOX CREDENTIALS =====

    // Mã website (Terminal ID) môi trường TEST
    public static final String VNP_TMN_CODE = "MOPVGQ9B";

    // Chuỗi bí mật tạo checksum môi trường TEST
    public static final String VNP_HASH_SECRET = "263J74VAJ3E0JC8DXNY74AALIROTXBHB";

    // =====================================



    public static final String VNP_PAY_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";

    public static final String VNP_VERSION = "2.1.0";

    public static final String VNP_COMMAND = "pay";

    public static final String VNP_ORDER_TYPE = "billpayment";

    public static final String VNP_LOCALE = "vn";

    public static final String VNP_CURRENCY_CODE = "VND";

    public static final String VNP_RETURN_URL_PATH = "/vnpay-return";

}