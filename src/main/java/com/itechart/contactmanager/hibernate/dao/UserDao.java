package com.itechart.contactmanager.hibernate.dao;

import com.itechart.contactmanager.model.User;

public interface UserDao {

    User get(int id);

    User getBySSO(String sso);

}

