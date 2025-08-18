package com.yash.contactmanager.service;

import com.yash.contactmanager.model.User;

public interface UserService {
    boolean registerUser(User user);
    User loginUser(String email, String password);
    boolean isEmailExists(String email);
}
