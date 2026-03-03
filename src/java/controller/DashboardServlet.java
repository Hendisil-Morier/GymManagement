package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Calendar;
import model.User;
import service.RevenueService;
import service.SubscriptionService;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private final RevenueService revenueService = new RevenueService();
    private final SubscriptionService subscriptionService = new SubscriptionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("role", user.getRole());

        if ("Admin".equals(user.getRole())) {
            int year = Calendar.getInstance().get(Calendar.YEAR);
            request.setAttribute("totalRevenue", revenueService.getTotalRevenue());
            request.setAttribute("revenueToday", revenueService.getRevenueToday());
            request.setAttribute("totalMembers", revenueService.getTotalMembers());
            request.setAttribute("newMembersThisMonth", revenueService.getNewMembersThisMonth());
            request.setAttribute("bestSellingPackage", revenueService.getBestSellingPackage());
            request.setAttribute("monthlyRevenue", revenueService.getMonthlyRevenue(year));
            request.setAttribute("upgradeRequired", subscriptionService.isUpgradeRequired());
            request.setAttribute("subscriptionExpired", subscriptionService.isExpired());
            request.setAttribute("activePlan", subscriptionService.getActivePlan());
        }

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}
