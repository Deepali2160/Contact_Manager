package com.yash.contactmanager.serviceimpl;

import com.yash.contactmanager.dao.UserDao;
import com.yash.contactmanager.daoimpl.UserDaoImpl;
import com.yash.contactmanager.model.User;
import com.yash.contactmanager.service.UserService;

public class UserServiceImpl implements UserService {
       private UserDao userDao;

       public UserServiceImpl()
       {
           this.userDao = new UserDaoImpl(); //Intializing userDao field userdaoimpl can access methods of userdao
       }
    @Override
    public boolean registerUser(User user) {
        return userDao.registerUser(user);
    }

    @Override
    public User loginUser(String email, String password) {
        return userDao.loginUser(email, password);
    }

    @Override
    public boolean isEmailExists(String email) {
        return userDao.isEmailExists(email);
    }
}
