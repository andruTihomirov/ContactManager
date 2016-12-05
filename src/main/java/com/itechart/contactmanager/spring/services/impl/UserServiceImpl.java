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
	private UserDao dao;

	public User findById(int id) {
		return dao.findById(id);
	}

	public User findBySso(String sso) {
		return dao.findBySSO(sso);
	}

}
