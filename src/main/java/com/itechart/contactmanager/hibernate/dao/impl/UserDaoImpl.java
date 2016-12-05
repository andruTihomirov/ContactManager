package com.itechart.contactmanager.hibernate.dao.impl;

import com.itechart.contactmanager.hibernate.dao.AbstractDao;
import com.itechart.contactmanager.hibernate.dao.UserDao;
import com.itechart.contactmanager.model.User;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

@Repository("userDao")
public class UserDaoImpl extends AbstractDao<Integer, User> implements UserDao {

	public User findById(int id) {
		return getByKey(id);
	}

	public User findBySSO(String sso) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("ssoId", sso));
		return (User) crit.uniqueResult();
	}

	
}
