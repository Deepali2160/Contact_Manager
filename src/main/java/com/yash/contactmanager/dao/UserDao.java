package com.yash.contactmanager.dao;

import com.yash.contactmanager.model.User;

public interface UserDao {
    boolean registerUser(User user);

    User loginUser(String email, String password);

    boolean isEmailExists(String email);
}
