package service;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import model.Member;
import model.Order;

public class EmailService {


    private final String username = firstNonBlank(
            System.getProperty("gym.mail.username"),
            System.getenv("GYM_MAIL_USERNAME"),
            "minaminhan18@gmail.com" // <-- THAY EMAIL CỦA BẠN VÀO ĐÂY
    );
    private final String password = firstNonBlank(
            System.getProperty("gym.mail.password"),
            System.getenv("GYM_MAIL_PASSWORD"),
            "qnqs cmhf qhts unqs" // <-- THAY MẬT KHẨU ỨNG DỤNG GMAIL (APP PASSWORD) VÀO ĐÂY
    );

    private static String firstNonBlank(String... values) {
        if (values == null) return null;
        for (String v : values) {
            if (v != null && !v.isBlank()) return v;
        }
        return null;
    }

    private Session createSession() {
        if (username == null || password == null || username.contains("YOUR_EMAIL")) {
            throw new IllegalStateException("Vui lòng cấu hình Email và App Password trong file EmailService.java (dòng 26, 31).");
        }
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
    }

    public void sendOrderApprovedEmail(Member member, Order order, String voucherCode) {
        if (member == null || member.getEmail() == null || member.getEmail().isBlank()) return;

        try {
            Session session = createSession();
            Message message = new MimeMessage(session);

            try {
                message.setFrom(new InternetAddress(username, "Gym Management"));
            } catch (UnsupportedEncodingException e) {
                message.setFrom(new InternetAddress(username));
            }

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(member.getEmail())
            );
            message.setSubject("Xác nhận đơn hàng #" + order.getOrderId());

            StringBuilder text = new StringBuilder();
            text.append("Xin chào ").append(member.getFullName()).append(",\n\n")
                .append("Đơn hàng #").append(order.getOrderId()).append(" của bạn đã được phê duyệt.\n")
                .append("Tổng tiền: ").append(order.getTotalAmount()).append(" VND\n")
                .append("Ngày bắt đầu gói: ").append(order.getStartDate()).append("\n")
                .append("Ngày kết thúc gói: ").append(order.getEndDate()).append("\n");

            if (voucherCode != null) {
                text.append("\n✨ Ưu đãi đặc biệt cho lần mua kế tiếp:\n")
                    .append("Bạn nhận được voucher giảm 10%: ").append(voucherCode).append("\n")
                    .append("Sử dụng mã này khi thanh toán đơn hàng tiếp theo của bạn.\n");
            }

            text.append("\nCảm ơn bạn đã sử dụng dịch vụ của chúng tôi.");

            message.setText(text.toString());
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}

