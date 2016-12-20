package com.itechart.contactmanager.spring.services.impl;

import com.itechart.contactmanager.hibernate.dao.UserDao;
import com.itechart.contactmanager.model.User;
import com.itechart.contactmanager.spring.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Transactional
    public User getById(int id) {
        return userDao.get(id);
    }

    @Transactional
    public User getBySso(String sso) {
        return userDao.getBySSO(sso);
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
}
