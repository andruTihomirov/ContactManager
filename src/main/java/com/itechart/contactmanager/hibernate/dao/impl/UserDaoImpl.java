package com.itechart.contactmanager.hibernate.dao.impl;

import com.itechart.contactmanager.hibernate.dao.UserDao;
import com.itechart.contactmanager.model.User;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository("userDao")
public class UserDaoImpl implements UserDao {

    private static final Logger logger = LoggerFactory.getLogger(PersonDAOImpl.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public User get(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        User user = (User) session.get(User.class, id);
        logger.info("Method get() called. Found user:\n" + user);
        return user;
    }

    public User getBySSO(String sso) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(User.class);
        criteria.add(Restrictions.eq("ssoId", sso));
        User user = (User) criteria.uniqueResult();
        logger.info("Method getBySSO() called. Found user:\n" + user);
        return user;
    }

}
