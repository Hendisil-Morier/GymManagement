package service;

import dao.MemberDAO;
import dao.SubscriptionDAO;
import java.util.Date;
import java.util.List;
import model.Subscription;

public class SubscriptionService {

    private final SubscriptionDAO subscriptionDAO = new SubscriptionDAO();
    private final MemberDAO memberDAO = new MemberDAO();

    public List<Subscription> getAllPlans() {
        try { return subscriptionDAO.findAll(); }
        catch (Exception e) { e.printStackTrace(); return List.of(); }
    }

    public Subscription getActivePlan() {
        try { return subscriptionDAO.findActive(); }
        catch (Exception e) { e.printStackTrace(); return null; }
    }

    public boolean isUpgradeRequired() {
        try {
            Subscription active = subscriptionDAO.findActive();
            if (active == null) return false;
            if (active.getMaxMembers() < 0) return false;
            int currentCount = memberDAO.countAll();
            return currentCount >= active.getMaxMembers();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isExpired() {
        try {
            Subscription active = subscriptionDAO.findActive();
            if (active == null) return true;
            return active.getEndDate() != null && active.getEndDate().before(new Date());
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
    }

    public boolean changePlan(int subscriptionId) {
        try {
            Subscription s = subscriptionDAO.findById(subscriptionId);
            if (s != null) {
                s.setStatus("Active");
                return subscriptionDAO.update(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
