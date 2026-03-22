package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Voucher;

public class VoucherDAO {

    private Voucher mapRow(ResultSet rs) throws SQLException {
        Voucher v = new Voucher();
        v.setVoucherId(rs.getInt("voucher_id"));
        v.setMemberId(rs.getInt("member_id"));
        v.setCode(rs.getString("code"));
        v.setDiscountPct(rs.getBigDecimal("discount_pct"));
        v.setUsed(rs.getBoolean("is_used"));
        v.setCreatedDate(rs.getDate("created_date"));
        return v;
    }

    public void insert(Voucher v) throws SQLException {
        String sql = "INSERT INTO Vouchers (member_id, code, discount_pct) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, v.getMemberId());
            ps.setString(2, v.getCode());
            ps.setBigDecimal(3, v.getDiscountPct());
            ps.executeUpdate();
        }
    }

    /** Tìm voucher chưa dùng theo code và memberId */
    public Voucher findValidByCodeAndMember(String code, int memberId) throws SQLException {
        String sql = "SELECT * FROM Vouchers WHERE code = ? AND member_id = ? AND is_used = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setInt(2, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    /** Lấy tất cả voucher chưa dùng của member */
    public List<Voucher> findUnusedByMember(int memberId) throws SQLException {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers WHERE member_id = ? AND is_used = 0 ORDER BY created_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    public boolean markUsed(int voucherId) throws SQLException {
        String sql = "UPDATE Vouchers SET is_used = 1 WHERE voucher_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            return ps.executeUpdate() > 0;
        }
    }
}
