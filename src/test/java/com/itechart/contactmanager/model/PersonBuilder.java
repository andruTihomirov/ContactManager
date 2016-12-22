package com.itechart.contactmanager.model;

import java.util.List;

/**
 * Created by andrei.tsikhamirau on 12/22/2016.
 */
public class PersonBuilder {

    private Person person;

    public PersonBuilder() {
        this.person = new Person();
    }

    public PersonBuilder id(Long id) {
        this.person.setId(id);
        return this;
    }

    public PersonBuilder imagePath(String imagePath) {
        this.person.setImagePath(imagePath);
        return this;
    }

    public PersonBuilder name(String name) {
        this.person.setName(name);
        return this;
    }

    public PersonBuilder surname(String surname) {
        this.person.setSurname(surname);
        return this;
    }

    public PersonBuilder patronymic(String patronymic) {
        this.person.setPatronymic(patronymic);
        return this;
    }

    public PersonBuilder dob(String dob) {
        this.person.setDob(dob);
        return this;
    }

    public PersonBuilder address(String address) {
        this.person.setAddress(address);
        return this;
    }

    public PersonBuilder phones(List<Phone> phones) {
        this.person.setPhones(phones);
        return this;
    }

    public Person build() {
        return person;
    }
}
