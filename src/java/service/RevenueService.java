package service;

import dao.MemberDAO;
import dao.PackageDAO;
import dao.RevenueDAO;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class RevenueService {

    private final RevenueDAO revenueDAO = new RevenueDAO();
    private final MemberDAO memberDAO = new MemberDAO();
    private final PackageDAO packageDAO = new PackageDAO();

    public BigDecimal getTotalRevenue() {
        try { return revenueDAO.getTotalRevenue(); }
        catch (Exception e) { e.printStackTrace(); return BigDecimal.ZERO; }
    }

    public BigDecimal getRevenueByMonth(int year, int month) {
        try { return revenueDAO.getRevenueByMonth(year, month); }
        catch (Exception e) { e.printStackTrace(); return BigDecimal.ZERO; }
    }

    public BigDecimal getRevenueByYear(int year) {
        try { return revenueDAO.getRevenueByYear(year); }
        catch (Exception e) { e.printStackTrace(); return BigDecimal.ZERO; }
    }

    public Map<String, BigDecimal> getMonthlyRevenue(int year) {
        try { return revenueDAO.getMonthlyRevenue(year); }
        catch (Exception e) { e.printStackTrace(); return Map.of(); }
    }

    public BigDecimal getRevenueToday() {
        try { return revenueDAO.getRevenueToday(); }
        catch (Exception e) { e.printStackTrace(); return BigDecimal.ZERO; }
    }

    public int getNewMembersThisMonth() {
        try { return memberDAO.countNewThisMonth(); }
        catch (Exception e) { e.printStackTrace(); return 0; }
    }

    public int getTotalMembers() {
        try { return memberDAO.countAll(); }
        catch (Exception e) { e.printStackTrace(); return 0; }
    }

    public String getBestSellingPackage() {
        try { return packageDAO.getBestSellingPackage(); }
        catch (Exception e) { e.printStackTrace(); return "N/A"; }
    }
    
    /**
 * Dự báo doanh thu tháng tiếp theo bằng Moving Average 3 tháng gần nhất.
 * Trả về List mỗi phần tử là [thang, doanhThuThuc, doanhThuDuBao]:
 *   - thang: 1–12
 *   - doanhThuThuc: thực tế (0 nếu chưa có)
 *   - doanhThuDuBao: trung bình 3 tháng trước đó (-1 nếu chưa đủ dữ liệu)
 */
    public List<double[]> getForecastData(int year) {
        try {
            Map<Integer, BigDecimal> actual = revenueDAO.getMonthlyRevenueMap(year);
            List<double[]> result = new ArrayList<>();

            for (int m = 1; m <= 12; m++) {
                double thuc = actual.get(m).doubleValue();
                double duBao = -1;

                // Tính moving average 3 tháng trước (m-3, m-2, m-1)
                if (m > 3) {
                    double sum = actual.get(m - 1).doubleValue()
                               + actual.get(m - 2).doubleValue()
                               + actual.get(m - 3).doubleValue();
                    duBao = sum / 3.0;
                }
                result.add(new double[]{m, thuc, duBao});
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}
