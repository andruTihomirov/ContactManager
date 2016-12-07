package com.itechart.contactmanager.spring.services.impl;

import com.itechart.contactmanager.hibernate.dao.UserDao;
import com.itechart.contactmanager.model.User;
import com.itechart.contactmanager.spring.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	public User findById(int id) {
		return userDao.findById(id);
	}

	public User findBySso(String sso) {
		return userDao.findBySSO(sso);
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
}
