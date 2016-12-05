package com.itechart.contactmanager.hibernate.dao;

import com.itechart.contactmanager.model.User;

public interface UserDao {

	User findById(int id);
	
	User findBySSO(String sso);
	
}

