package service;

import java.util.List;
import model.Member;

public interface IMemberService {
    List<Member> getAllMembers();
    Member getMemberById(int memberId);
    Member getMemberByUserId(int userId);
    boolean addMember(Member member);
    boolean updateMember(Member member);
    boolean deleteMember(int memberId);
    List<Member> searchMembers(String keyword);
    void classifyMember(int memberId);
}
