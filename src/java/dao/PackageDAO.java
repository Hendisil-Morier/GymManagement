package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.GymPackage;

public class PackageDAO {

    private GymPackage mapRow(ResultSet rs) throws SQLException {
        GymPackage p = new GymPackage();
        p.setPackageId(rs.getInt("package_id"));
        p.setPackageName(rs.getString("package_name"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setDurationMonth(rs.getInt("duration_month"));
        p.setDescription(rs.getString("description"));
        p.setStatus(rs.getString("status"));
        return p;
    }

    public List<GymPackage> findAll() throws SQLException {
        List<GymPackage> list = new ArrayList<>();
        String sql = "SELECT * FROM Packages WHERE status = 'Active' ORDER BY duration_month";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public GymPackage findById(int packageId) throws SQLException {
        String sql = "SELECT * FROM Packages WHERE package_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, packageId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean insert(GymPackage p) throws SQLException {
        String sql = "INSERT INTO Packages (package_name, price, duration_month, description) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getPackageName());
            ps.setBigDecimal(2, p.getPrice());
            ps.setInt(3, p.getDurationMonth());
            ps.setString(4, p.getDescription());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(GymPackage p) throws SQLException {
        String sql = "UPDATE Packages SET package_name=?, price=?, duration_month=?, description=?, status=? WHERE package_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getPackageName());
            ps.setBigDecimal(2, p.getPrice());
            ps.setInt(3, p.getDurationMonth());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getStatus());
            ps.setInt(6, p.getPackageId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int packageId) throws SQLException {
        String sql = "UPDATE Packages SET status = 'Inactive' WHERE package_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, packageId);
            return ps.executeUpdate() > 0;
        }
    }

    public String getBestSellingPackage() throws SQLException {
        String sql = "SELECT TOP 1 p.package_name FROM OrderDetails od "
                   + "JOIN Packages p ON od.package_id = p.package_id "
                   + "WHERE od.item_type = 'Package' "
                   + "GROUP BY p.package_name ORDER BY COUNT(*) DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getString("package_name");
        }
        return "N/A";
    }
}
