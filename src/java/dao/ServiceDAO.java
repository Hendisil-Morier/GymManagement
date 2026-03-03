package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Service;

public class ServiceDAO {

    private Service mapRow(ResultSet rs) throws SQLException {
        Service s = new Service();
        s.setServiceId(rs.getInt("service_id"));
        s.setServiceName(rs.getString("service_name"));
        s.setPrice(rs.getBigDecimal("price"));
        s.setDescription(rs.getString("description"));
        s.setStatus(rs.getString("status"));
        return s;
    }

    public List<Service> findAll() throws SQLException {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Services WHERE status = 'Active' ORDER BY service_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public Service findById(int serviceId) throws SQLException {
        String sql = "SELECT * FROM Services WHERE service_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean insert(Service s) throws SQLException {
        String sql = "INSERT INTO Services (service_name, price, description) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getServiceName());
            ps.setBigDecimal(2, s.getPrice());
            ps.setString(3, s.getDescription());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Service s) throws SQLException {
        String sql = "UPDATE Services SET service_name=?, price=?, description=?, status=? WHERE service_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getServiceName());
            ps.setBigDecimal(2, s.getPrice());
            ps.setString(3, s.getDescription());
            ps.setString(4, s.getStatus());
            ps.setInt(5, s.getServiceId());
            return ps.executeUpdate() > 0;
        }
    }
}
