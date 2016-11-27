package com.itechart.contactmanager.model;

import javax.persistence.*;

/**
 * Created by Andru on 27.11.2016.
 */
@Entity
public class Phones {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "imagePath")
    private String number;

//    @ManyToOne
//    @JoinColumn(name = "person_id", nullable = false)
//    private Person person;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

//    public Person getPerson() {
//        return person;
//    }
//
//    public void setPerson(Person person) {
//        this.person = person;
//    }
}
