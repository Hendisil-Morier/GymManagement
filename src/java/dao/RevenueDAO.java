package dao;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Revenue;

public class RevenueDAO {

    public boolean insert(Revenue r) throws SQLException {
        String sql = "INSERT INTO Revenue (payment_id, revenue_date, amount, source_type) VALUES (?, GETDATE(), ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, r.getPaymentId());
            ps.setBigDecimal(2, r.getAmount());
            ps.setString(3, r.getSourceType());
            return ps.executeUpdate() > 0;
        }
    }

    public BigDecimal getTotalRevenue() throws SQLException {
        String sql = "SELECT ISNULL(SUM(amount), 0) AS total FROM Revenue";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal("total");
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal getRevenueByMonth(int year, int month) throws SQLException {
        String sql = "SELECT ISNULL(SUM(amount), 0) AS total FROM Revenue WHERE YEAR(revenue_date) = ? AND MONTH(revenue_date) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal("total");
            }
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal getRevenueByYear(int year) throws SQLException {
        String sql = "SELECT ISNULL(SUM(amount), 0) AS total FROM Revenue WHERE YEAR(revenue_date) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal("total");
            }
        }
        return BigDecimal.ZERO;
    }

    public Map<String, BigDecimal> getMonthlyRevenue(int year) throws SQLException {
        Map<String, BigDecimal> map = new LinkedHashMap<>();
        String sql = "SELECT MONTH(revenue_date) AS m, SUM(amount) AS total FROM Revenue "
                   + "WHERE YEAR(revenue_date) = ? GROUP BY MONTH(revenue_date) ORDER BY m";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put("Month " + rs.getInt("m"), rs.getBigDecimal("total"));
                }
            }
        }
        return map;
    }

    public BigDecimal getRevenueToday() throws SQLException {
        String sql = "SELECT ISNULL(SUM(amount), 0) AS total FROM Revenue WHERE CAST(revenue_date AS DATE) = CAST(GETDATE() AS DATE)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal("total");
        }
        return BigDecimal.ZERO;
    }

    public List<Revenue> findAll() throws SQLException {
        List<Revenue> list = new ArrayList<>();
        String sql = "SELECT * FROM Revenue ORDER BY revenue_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Revenue r = new Revenue();
                r.setRevenueId(rs.getInt("revenue_id"));
                r.setPaymentId(rs.getInt("payment_id"));
                r.setRevenueDate(rs.getDate("revenue_date"));
                r.setAmount(rs.getBigDecimal("amount"));
                r.setSourceType(rs.getString("source_type"));
                list.add(r);
            }
        }
        return list;
    }
}
