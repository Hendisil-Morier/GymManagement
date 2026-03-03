package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Equipment;

public class EquipmentDAO {

    private Equipment mapRow(ResultSet rs) throws SQLException {
        Equipment e = new Equipment();
        e.setEquipmentId(rs.getInt("equipment_id"));
        e.setEquipmentName(rs.getString("equipment_name"));
        e.setQuantity(rs.getInt("quantity"));
        e.setStatus(rs.getString("status"));
        e.setPurchaseDate(rs.getDate("purchase_date"));
        e.setPurchasePrice(rs.getBigDecimal("purchase_price"));
        int suppId = rs.getInt("supplier_id");
        e.setSupplierId(rs.wasNull() ? 0 : suppId);
        return e;
    }

    public List<Equipment> findAll() throws SQLException {
        List<Equipment> list = new ArrayList<>();
        String sql = "SELECT * FROM Equipment ORDER BY equipment_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public Equipment findById(int equipmentId) throws SQLException {
        String sql = "SELECT * FROM Equipment WHERE equipment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, equipmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean insert(Equipment e) throws SQLException {
        String sql = "INSERT INTO Equipment (equipment_name, quantity, status, purchase_date, purchase_price, supplier_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, e.getEquipmentName());
            ps.setInt(2, e.getQuantity());
            ps.setString(3, e.getStatus() != null ? e.getStatus() : "Active");
            ps.setDate(4, e.getPurchaseDate() != null ? new java.sql.Date(e.getPurchaseDate().getTime()) : null);
            ps.setBigDecimal(5, e.getPurchasePrice());
            if (e.getSupplierId() > 0) {
                ps.setInt(6, e.getSupplierId());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Equipment e) throws SQLException {
        String sql = "UPDATE Equipment SET equipment_name=?, quantity=?, status=?, purchase_date=?, purchase_price=?, supplier_id=? WHERE equipment_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, e.getEquipmentName());
            ps.setInt(2, e.getQuantity());
            ps.setString(3, e.getStatus());
            ps.setDate(4, e.getPurchaseDate() != null ? new java.sql.Date(e.getPurchaseDate().getTime()) : null);
            ps.setBigDecimal(5, e.getPurchasePrice());
            if (e.getSupplierId() > 0) {
                ps.setInt(6, e.getSupplierId());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            ps.setInt(7, e.getEquipmentId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int equipmentId) throws SQLException {
        String sql = "DELETE FROM Equipment WHERE equipment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, equipmentId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateStatus(int equipmentId, String status) throws SQLException {
        String sql = "UPDATE Equipment SET status = ? WHERE equipment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, equipmentId);
            return ps.executeUpdate() > 0;
        }
    }

    public List<Equipment> findByStatus(String status) throws SQLException {
        List<Equipment> list = new ArrayList<>();
        String sql = "SELECT * FROM Equipment WHERE status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }
}
