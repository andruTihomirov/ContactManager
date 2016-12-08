package com.itechart.contactmanager.hibernate.dao.impl;

import com.itechart.contactmanager.hibernate.dao.PersonDAO;
import com.itechart.contactmanager.model.Person;
import com.itechart.contactmanager.model.Phone;
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
public class PersonDAOImpl implements PersonDAO {

    private static final Logger logger = LoggerFactory.getLogger(PersonDAOImpl.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public List<Person> getAll() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Person> persons = session.createQuery("from Person").list();
        return persons;
    }

    public Person get(Long id) {
        Session session = this.sessionFactory.getCurrentSession();
        Person person = (Person) session.load(Person.class, id);
        return person;
    }

    public Person update(Person person) {
        System.out.println(person);
        Session session = this.sessionFactory.getCurrentSession();
        List<Phone> phones = person.getPhones();
        if (phones != null) {
            for (Phone phone : phones) {
                phone.setPerson(person);
            }
        }
        session.merge(person);
        return person;
    }

    public boolean delete(Long id) {
        Session session = this.sessionFactory.getCurrentSession();
        Person person = (Person) session.load(Person.class, id);
        if (null != person) {
            session.delete(person);
            return true;
        }
        return false;
    }

    public void add(Person person) {
        Session session = this.sessionFactory.getCurrentSession();
        List<Phone> phones = person.getPhones();
        if (phones != null) {
            for (Phone phone : phones) {
                phone.setPerson(person);
            }
        }
        session.persist(person);
    }
}
