package com.itechart.contactmanager.spring.services;

import com.itechart.contactmanager.model.User;

public interface UserService {

	User findById(int id);
	
	User findBySso(String sso);
	
}