package util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import model.Member;
import model.Order;

/**
 * Tiện ích gửi email xác nhận đơn hàng.
 * Để dùng được, bạn cần thêm thư viện Jakarta Mail vào project
 * và cấu hình lại EMAIL_USERNAME / EMAIL_PASSWORD cho phù hợp.
 */
public class EmailUtil {

    // Cấu hình Mailtrap sandbox để test gửi mail
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587; // có thể dùng 25, 465, 587 hoặc 2525
    private static final String EMAIL_USERNAME = "minaminhan18@gmail.com";
    private static final String EMAIL_PASSWORD = "qnqs cmhf qhts unqs";

    public static void sendOrderConfirmation(Member member, Order order) {
        if (member == null || member.getEmail() == null || member.getEmail().isBlank()) {
            return; // không có email để gửi
        }
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            // Mailtrap hỗ trợ STARTTLS trên tất cả các port
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", String.valueOf(SMTP_PORT));

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("no-reply@gym-management.local", "Gym Management"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(member.getEmail()));
            message.setSubject("Xác nhận đăng ký gói tập thành công #" + order.getOrderId());

            String text = "Xin chào " + member.getFullName() + ",\n\n"
                    + "Đơn đăng ký gói tập #" + order.getOrderId() + " của bạn đã được thanh toán và kích hoạt thành công.\n"
                    + "Số tiền: " + order.getTotalAmount() + " VND\n\n"
                    + "Cảm ơn bạn đã lựa chọn phòng gym của chúng tôi.\n";

            message.setText(text);

            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

