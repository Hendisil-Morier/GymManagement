package dao;

import java.sql.*;
import model.User;

public class UserDAO {

    public User login(String username, String password) throws SQLException {
        String sql = "SELECT u.user_id, u.username, u.password, r.role_name, u.status "
                   + "FROM Users u JOIN Roles r ON u.role_id = r.role_id "
                   + "WHERE u.username = ? AND u.password = ? AND u.status = 'Active'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role_name"));
                    user.setStatus(rs.getString("status"));
                    return user;
                }
            }
        }
        return null;
    }

    public User findById(int userId) throws SQLException {
        String sql = "SELECT u.user_id, u.username, u.password, r.role_name, u.status "
                   + "FROM Users u JOIN Roles r ON u.role_id = r.role_id WHERE u.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role_name"));
                    user.setStatus(rs.getString("status"));
                    return user;
                }
            }
        }
        return null;
    }

    public boolean createUser(String username, String password, int roleId) throws SQLException {
        String sql = "INSERT INTO Users (username, password, role_id, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setInt(3, roleId);
            ps.setString(4,"Active");
            return ps.executeUpdate() > 0;
        }
    }

    public int getLastInsertedUserId() throws SQLException {
        String sql = "SELECT TOP 1 user_id FROM Users ORDER BY user_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("user_id");
            }
        }
        return -1;
    }
}
