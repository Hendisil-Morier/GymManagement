package service;

import dao.MemberDAO;
import dao.UserDAO;
import model.Member;
import model.User;

public class AuthService implements IAuthService {

    private final UserDAO userDAO = new UserDAO();
    private final MemberDAO memberDAO = new MemberDAO();

    @Override
    public User login(String username, String password) {
        try {
            return userDAO.login(username, password);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean register(String username, String password, String fullName,
                            String email, String phone, String gender) {
        try {
            boolean created = userDAO.createUser(username, password, 3);
            if (created) {
                int userId = userDAO.getLastInsertedUserId();
                Member m = new Member();
                m.setUserId(userId);
                m.setFullName(fullName);
                m.setEmail(email);
                m.setPhone(phone);
                m.setGender(gender);
                m.setMemberType("New Member");
                return memberDAO.insert(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
