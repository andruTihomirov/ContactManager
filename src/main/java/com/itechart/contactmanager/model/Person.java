package com.itechart.contactmanager.model;

import org.hibernate.annotations.*;
import org.hibernate.annotations.CascadeType;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.List;

/**
 * Created by andrei.tsikhamirau on 11/23/2016.
 */

@Entity
@Table(name = "person")
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "imagePath")
    private String imagePath;

    @Column(name = "name")
    private String name;

    @Column(name = "surname")
    private String surname;

    @Column(name = "patronymic")
    private String patronymic;

    @Column(name = "phoneNumbers")
    private String phoneNumbers;

    @Column(name = "dob")
    private String dob;

    @Column(name = "address")
    private String address;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "person")
    @Cascade({CascadeType.SAVE_UPDATE})
    private List<Phone> phones;

    public Person() {
    }

    public Person(String name, String surname, String patronymic, String phoneNumbers, String dob,
                  String address, String imagePath) {
        this.name = name;
        this.surname = surname;
        this.patronymic = patronymic;
        this.phoneNumbers = phoneNumbers;
        this.dob = dob;
        this.address = address;
        this.imagePath = imagePath;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
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

    public String getPhoneNumbers() {
        return phoneNumbers;
    }

    public void setPhoneNumbers(String phoneNumbers) {
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

    public List<Phone> getPhones() {
        return phones;
    }

    public void setPhones(List<Phone> phones) {
        this.phones = phones;
    }

    @Override
    public String toString() {
        String topLevelData = "ID: [" + id + "]\nName: [" + name + "]\nSurname: [" + surname + "]\nPatronymic: [" + patronymic +
                "]\nDOB: [" + dob + "]\nAddress: [" + address + "]";

        String innerData = "";
        if(phones != null) {
            for(Phone phone : phones) {
                    innerData += "\n" + phone.getNumber();
            }
        }

        return topLevelData + innerData;
    }
}
