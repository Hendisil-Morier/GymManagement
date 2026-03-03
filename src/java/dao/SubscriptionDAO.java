package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Subscription;

public class SubscriptionDAO {

    private Subscription mapRow(ResultSet rs) throws SQLException {
        Subscription s = new Subscription();
        s.setSubscriptionId(rs.getInt("subscription_id"));
        s.setPlanName(rs.getString("plan_name"));
        s.setMaxMembers(rs.getInt("max_members"));
        s.setPrice(rs.getBigDecimal("price"));
        s.setStartDate(rs.getDate("start_date"));
        s.setEndDate(rs.getDate("end_date"));
        s.setStatus(rs.getString("status"));
        return s;
    }

    public List<Subscription> findAll() throws SQLException {
        List<Subscription> list = new ArrayList<>();
        String sql = "SELECT * FROM Subscriptions ORDER BY subscription_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public Subscription findActive() throws SQLException {
        String sql = "SELECT * FROM Subscriptions WHERE status = 'Active' ORDER BY subscription_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    public Subscription findById(int subscriptionId) throws SQLException {
        String sql = "SELECT * FROM Subscriptions WHERE subscription_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subscriptionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean update(Subscription s) throws SQLException {
        String sql = "UPDATE Subscriptions SET plan_name=?, max_members=?, price=?, start_date=?, end_date=?, status=? WHERE subscription_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getPlanName());
            ps.setInt(2, s.getMaxMembers());
            ps.setBigDecimal(3, s.getPrice());
            ps.setDate(4, s.getStartDate() != null ? new java.sql.Date(s.getStartDate().getTime()) : null);
            ps.setDate(5, s.getEndDate() != null ? new java.sql.Date(s.getEndDate().getTime()) : null);
            ps.setString(6, s.getStatus());
            ps.setInt(7, s.getSubscriptionId());
            return ps.executeUpdate() > 0;
        }
    }
}
