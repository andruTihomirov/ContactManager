package com.itechart.contactmanager.hibernate.dao.impl;

import com.itechart.contactmanager.hibernate.dao.PersonDAO;
import com.itechart.contactmanager.model.Person;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by andrei.tsikhamirau on 11/24/2016.
 */
@Repository
public class PersonDAOImpl implements PersonDAO {

    private final static Logger logger = Logger.getLogger(PersonDAOImpl.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public List<Person> getAll() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Person> persons = session.createQuery("from Person").list();
        logger.info("Method getAll() called. Found persons:\n" + persons);
        return persons;
    }

    public Person get(Long id) {
        Session session = this.sessionFactory.getCurrentSession();
        Person person = (Person) session.load(Person.class, id);
        logger.info("Method get() called. Found person:\n" + person);
        return person;
    }

    public Person update(Person person) {
        Session session = this.sessionFactory.getCurrentSession();
        session.merge(person);
        logger.info("Method update() called. Person with updated data:\n" + person);
        return person;
    }

    public boolean delete(Long id) {
        Session session = this.sessionFactory.getCurrentSession();
        Person person = (Person) session.load(Person.class, id);
        if (null != person) {
            session.delete(person);
            logger.info("Method delete() called. Deleted person:\n[" + person + "]");
            return true;
        }
        logger.error("Method delete() called. Can't delete person with id [" + id + "]");
        return false;
    }

    public void add(Person person) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(person);
        logger.info("Method add() called. Added person:\n" + person);
    }
}
