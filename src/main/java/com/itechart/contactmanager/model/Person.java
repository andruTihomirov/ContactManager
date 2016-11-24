package com.itechart.contactmanager.model;

import java.util.List;

/**
 * Created by andrei.tsikhamirau on 11/23/2016.
 */
public class Person {

    private String name;
    private String surname;
    private String patronymic;
    private List<String> phoneNumbers;
    private String dob;
    private String address;

    public Person() {
    }

    public Person(String name, String surname, String patronymic, List phoneNumbers, String dob, String address) {
        this.name = name;
        this.surname = surname;
        this.patronymic = patronymic;
        this.phoneNumbers = phoneNumbers;
        this.dob = dob;
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPatronymic() {
        return patronymic;
    }

    public void setPatronymic(String patronymic) {
        this.patronymic = patronymic;
    }

    public List getPhoneNumbers() {
        return phoneNumbers;
    }

    public void setPhoneNumbers(List phoneNumbers) {
        this.phoneNumbers = phoneNumbers;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
