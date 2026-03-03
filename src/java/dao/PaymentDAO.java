package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Payment;

public class PaymentDAO {

    public int insert(Payment p) throws SQLException {
        String sql = "INSERT INTO Payments (order_id, amount, method) VALUES (?, ?, ?); SELECT SCOPE_IDENTITY();";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getOrderId());
            ps.setBigDecimal(2, p.getAmount());
            ps.setString(3, p.getMethod());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        }
        return -1;
    }

    public List<Payment> findByOrderId(int orderId) throws SQLException {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM Payments WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Payment p = new Payment();
                    p.setPaymentId(rs.getInt("payment_id"));
                    p.setOrderId(rs.getInt("order_id"));
                    p.setPaymentDate(rs.getTimestamp("payment_date"));
                    p.setAmount(rs.getBigDecimal("amount"));
                    p.setMethod(rs.getString("method"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    public List<Payment> findAll() throws SQLException {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM Payments ORDER BY payment_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("payment_id"));
                p.setOrderId(rs.getInt("order_id"));
                p.setPaymentDate(rs.getTimestamp("payment_date"));
                p.setAmount(rs.getBigDecimal("amount"));
                p.setMethod(rs.getString("method"));
                list.add(p);
            }
        }
        return list;
    }
}
