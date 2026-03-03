package service;

import dao.MemberDAO;
import java.math.BigDecimal;
import java.util.List;
import model.Member;

public class MemberService implements IMemberService {

    private final MemberDAO memberDAO = new MemberDAO();

    @Override
    public List<Member> getAllMembers() {
        try {
            return memberDAO.findAll();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    @Override
    public Member getMemberById(int memberId) {
        try {
            return memberDAO.findById(memberId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Member getMemberByUserId(int userId) {
        try {
            return memberDAO.findByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean addMember(Member member) {
        try {
            return memberDAO.insert(member);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateMember(Member member) {
        try {
            return memberDAO.update(member);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteMember(int memberId) {
        try {
            return memberDAO.delete(memberId);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Member> searchMembers(String keyword) {
        try {
            return memberDAO.search(keyword);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    @Override
    public void classifyMember(int memberId) {
        try {
            Member m = memberDAO.findById(memberId);
            if (m == null) return;

            String type = "New Member";
            if (m.getTotalSpending() != null && m.getTotalSpending().compareTo(new BigDecimal("10000000")) > 0) {
                type = "VIP";
            } else if (m.getRenewalCount() > 3) {
                type = "Loyal Member";
            }
            memberDAO.updateMemberType(memberId, type);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
