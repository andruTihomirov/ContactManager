package com.itechart.contactmanager.services.impl;

import com.itechart.contactmanager.hibernate.PersonDAO;
import com.itechart.contactmanager.model.Person;
import com.itechart.contactmanager.services.PersonService;
import org.hibernate.Hibernate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Andru on 27.11.2016.
 */
@Service
public class PersonServiceImpl implements PersonService {

    private PersonDAO personDAO;

    @Transactional
    public void addPerson(Person person) {
        personDAO.add(person);
    }

    @Transactional
    public void updatePerson(Person person) {
        personDAO.update(person);
    }

    @Transactional
    public List<Person> getAllPersons() {
        return personDAO.getAll();
    }

    @Transactional
    public Person getPerson(Long id) {
        Person person = personDAO.get(id);
        Hibernate.initialize(person);
        return person;
    }

    @Transactional
    public void deletePerson(Long id) {
        this.personDAO.delete(id);
    }

    public void setPersonDAO(PersonDAO personDAO) {
        this.personDAO = personDAO;
    }
}
