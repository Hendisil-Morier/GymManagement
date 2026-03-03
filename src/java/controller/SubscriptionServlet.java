package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Subscription;
import service.SubscriptionService;
import service.RevenueService;

@WebServlet(name = "SubscriptionServlet", urlPatterns = {"/subscriptions"})
public class SubscriptionServlet extends HttpServlet {

    private final SubscriptionService subscriptionService = new SubscriptionService();
    private final RevenueService revenueService = new RevenueService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Subscription> plans = subscriptionService.getAllPlans();
        Subscription activePlan = subscriptionService.getActivePlan();
        boolean upgradeRequired = subscriptionService.isUpgradeRequired();
        boolean expired = subscriptionService.isExpired();
        int totalMembers = revenueService.getTotalMembers();

        request.setAttribute("plans", plans);
        request.setAttribute("activePlan", activePlan);
        request.setAttribute("upgradeRequired", upgradeRequired);
        request.setAttribute("expired", expired);
        request.setAttribute("totalMembers", totalMembers);
        request.getRequestDispatcher("/subscriptions.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("changePlan".equals(action)) {
            int planId = Integer.parseInt(request.getParameter("planId"));
            subscriptionService.changePlan(planId);
        }
        response.sendRedirect(request.getContextPath() + "/subscriptions");
    }
}
