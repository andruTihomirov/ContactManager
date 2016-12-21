package com.itechart.contactmanager.model;

public class PersonBuilder {
    private String name;
    private String surname;
    private String patronymic;
    private String phoneNumbers;
    private String dob;
    private String address;
    private String imagePath;

    public PersonBuilder setName(String name) {
        this.name = name;
        return this;
    }

    public PersonBuilder setSurname(String surname) {
        this.surname = surname;
        return this;
    }

    public PersonBuilder setPatronymic(String patronymic) {
        this.patronymic = patronymic;
        return this;
    }

    public PersonBuilder setPhoneNumbers(String phoneNumbers) {
        this.phoneNumbers = phoneNumbers;
        return this;
    }

    public PersonBuilder setDob(String dob) {
        this.dob = dob;
        return this;
    }

    public PersonBuilder setAddress(String address) {
        this.address = address;
        return this;
    }

    public PersonBuilder setImagePath(String imagePath) {
        this.imagePath = imagePath;
        return this;
    }

    public Person createPerson() {
        return new Person(name, surname, patronymic, phoneNumbers, dob, address, imagePath);
    }
}