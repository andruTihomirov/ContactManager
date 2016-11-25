package com.itechart.contactmanager.hibernate.impl;

import com.itechart.contactmanager.hibernate.DAO;
import com.itechart.contactmanager.model.Person;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by andrei.tsikhamirau on 11/24/2016.
 */
@Repository
@Transactional
public class PersonDAO implements DAO<Person, Long> {

    private static final Logger logger = LoggerFactory.getLogger(PersonDAO.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory){
        this.sessionFactory = sessionFactory;
    }

    public List<Person> getAll() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Person> persons = session.createQuery("from Person").list();
        return persons;
    }

    public Person find(Long id) {
        Session session = this.sessionFactory.getCurrentSession();
        Person person = (Person) session.load(Person.class, id);
        return person;
    }

    public Person update(Person entity) {
        return null;
    }

    public boolean delete(Long id) {
        return false;
    }

    public boolean create(Person entity) {
        return false;
    }
}
