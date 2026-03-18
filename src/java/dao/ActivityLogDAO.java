package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ActivityLog;

public class ActivityLogDAO {

    public void insert(ActivityLog log) {
        String sql = "INSERT INTO ActivityLog (user_id, username, role, action, target_url) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, log.getUserId());
            ps.setString(2, log.getUsername());
            ps.setString(3, log.getRole());
            ps.setString(4, log.getAction());
            ps.setString(5, log.getTargetUrl());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ActivityLog> findAll() {
        List<ActivityLog> list = new ArrayList<>();
        String sql = "SELECT TOP 200 * FROM ActivityLog ORDER BY log_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ActivityLog log = new ActivityLog();
                log.setLogId(rs.getInt("log_id"));
                log.setUserId(rs.getInt("user_id"));
                log.setUsername(rs.getString("username"));
                log.setRole(rs.getString("role"));
                log.setAction(rs.getString("action"));
                log.setTargetUrl(rs.getString("target_url"));
                log.setLogTime(rs.getTimestamp("log_time"));
                list.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ActivityLog> findByRole(String role) {
        List<ActivityLog> list = new ArrayList<>();
        String sql = "SELECT TOP 200 * FROM ActivityLog WHERE role = ? ORDER BY log_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ActivityLog log = new ActivityLog();
                    log.setLogId(rs.getInt("log_id"));
                    log.setUserId(rs.getInt("user_id"));
                    log.setUsername(rs.getString("username"));
                    log.setRole(rs.getString("role"));
                    log.setAction(rs.getString("action"));
                    log.setTargetUrl(rs.getString("target_url"));
                    log.setLogTime(rs.getTimestamp("log_time"));
                    list.add(log);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
