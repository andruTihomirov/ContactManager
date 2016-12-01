package com.itechart.contactmanager.spring.services;

import com.itechart.contactmanager.model.Person;

import java.util.List;

/**
 * Created by Andru on 27.11.2016.
 */
public interface PersonService {
    void addPerson(Person p);

    void updatePerson(Person p);

    List<Person> getAllPersons();

    Person getPerson(Long id);

    void deletePerson(Long id);
}
