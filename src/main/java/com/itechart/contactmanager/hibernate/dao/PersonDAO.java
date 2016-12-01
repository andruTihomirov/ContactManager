package com.itechart.contactmanager.hibernate.dao;

import com.itechart.contactmanager.model.Person;

import java.util.List;

/**
 * Created by andrei.tsikhamirau on 11/24/2016.
 */
public interface PersonDAO {

    List<Person> getAll();

    Person get(Long id);

    Person update(Person entity);

    boolean delete(Long id);

    void add(Person entity);

}
