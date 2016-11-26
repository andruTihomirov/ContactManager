package com.itechart.contactmanager.controllers;

import com.itechart.contactmanager.hibernate.DAO;
import com.itechart.contactmanager.model.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by andrei.tsikhamirau on 11/22/2016.
 */
@Controller
@RequestMapping("/")
public class GetContactsController {

    private DAO dao;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String getMainPage() {
        return "persons";
    }

    @RequestMapping(value = "/persons", method = RequestMethod.GET)
    public @ResponseBody List<Person> getPersons() {
        List<Person> persons = dao.getAll();
        return persons;
    }

    @RequestMapping("/create")
    public String createPerson() {
        return "createPerson";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addPerson(
            @ModelAttribute("name") String name,
            @ModelAttribute("surname") String surname,
            @ModelAttribute("patronymic") String patronymic,
            @ModelAttribute("phoneNumbers") String phoneNumbers,
            @ModelAttribute("dob") String dob,
            @ModelAttribute("address") String address,
            @ModelAttribute("imagePath") String imagePath) {
        Person person = new Person(name, surname, patronymic, phoneNumbers, dob, address, imagePath);
        dao.add(person);
        return "persons";
    }

    @RequestMapping("/update/{id}")
    public String updatePerson(@PathVariable("id") Long id) {
        return "persons";
    }

    @RequestMapping("/delete/{id}")
    public String deletePerson(@PathVariable("id") Long id) {
        System.out.println("DELETE: called.");
        dao.delete(id);
        return "persons";
    }

    @Autowired(required = true)
    @Qualifier(value = "personDAO")
    public void setPersonService(DAO personDAO) {
        this.dao = personDAO;
    }

}