package service;

import model.User;

public interface IAuthService {
    User login(String username, String password);
    boolean register(String username, String password, String fullName, String email, String phone, String gender);
}
