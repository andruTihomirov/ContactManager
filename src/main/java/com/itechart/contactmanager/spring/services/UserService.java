package com.itechart.contactmanager.spring.services;

import com.itechart.contactmanager.model.User;

public interface UserService {

    User getById(int id);

    User getBySso(String sso);

}