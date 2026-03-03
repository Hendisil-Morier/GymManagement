package service;

import dao.MemberDAO;
import dao.PackageDAO;
import dao.RevenueDAO;
import java.math.BigDecimal;
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
}
