package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Member;

public class MemberDAO {

    private Member mapRow(ResultSet rs) throws SQLException {
        Member m = new Member();
        m.setMemberId(rs.getInt("member_id"));
        m.setUserId(rs.getInt("user_id"));
        m.setFullName(rs.getString("full_name"));
        m.setEmail(rs.getString("email"));
        m.setPhone(rs.getString("phone"));
        m.setGender(rs.getString("gender"));
        m.setDateOfBirth(rs.getDate("date_of_birth"));
        m.setBmi(rs.getBigDecimal("bmi"));
        m.setMemberType(rs.getString("member_type"));
        m.setTotalSpending(rs.getBigDecimal("total_spending"));
        m.setRenewalCount(rs.getInt("renewal_count"));
        m.setJoinDate(rs.getDate("join_date"));
        return m;
    }

    public List<Member> findAll() throws SQLException {
        List<Member> list = new ArrayList<>();
        String sql = "SELECT * FROM Members ORDER BY member_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public Member findById(int memberId) throws SQLException {
        String sql = "SELECT * FROM Members WHERE member_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public Member findByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM Members WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean insert(Member m) throws SQLException {
        String sql = "INSERT INTO Members (user_id, full_name, email, phone, gender, date_of_birth, bmi, member_type) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, m.getUserId());
            ps.setString(2, m.getFullName());
            ps.setString(3, m.getEmail());
            ps.setString(4, m.getPhone());
            ps.setString(5, m.getGender());
            ps.setDate(6, m.getDateOfBirth() != null ? new java.sql.Date(m.getDateOfBirth().getTime()) : null);
            ps.setBigDecimal(7, m.getBmi());
            ps.setString(8, m.getMemberType() != null ? m.getMemberType() : "New Member");
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Member m) throws SQLException {
        String sql = "UPDATE Members SET full_name=?, email=?, phone=?, gender=?, date_of_birth=?, bmi=?, member_type=? "
                   + "WHERE member_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getFullName());
            ps.setString(2, m.getEmail());
            ps.setString(3, m.getPhone());
            ps.setString(4, m.getGender());
            ps.setDate(5, m.getDateOfBirth() != null ? new java.sql.Date(m.getDateOfBirth().getTime()) : null);
            ps.setBigDecimal(6, m.getBmi());
            ps.setString(7, m.getMemberType());
            ps.setInt(8, m.getMemberId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int memberId) throws SQLException {
        String sql = "DELETE FROM Members WHERE member_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            return ps.executeUpdate() > 0;
        }
    }

    public List<Member> search(String keyword) throws SQLException {
        List<Member> list = new ArrayList<>();
        String sql = "SELECT * FROM Members WHERE full_name LIKE ? OR email LIKE ? OR phone LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    public boolean updateMemberType(int memberId, String memberType) throws SQLException {
        String sql = "UPDATE Members SET member_type = ? WHERE member_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, memberType);
            ps.setInt(2, memberId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateSpending(int memberId, java.math.BigDecimal amount) throws SQLException {
        String sql = "UPDATE Members SET total_spending = total_spending + ?, renewal_count = renewal_count + 1 WHERE member_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, amount);
            ps.setInt(2, memberId);
            return ps.executeUpdate() > 0;
        }
    }

    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Members";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int countNewThisMonth() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Members WHERE MONTH(join_date) = MONTH(GETDATE()) AND YEAR(join_date) = YEAR(GETDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }
}
