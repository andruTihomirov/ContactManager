package com.itechart.contactmanager.controllers;

import com.itechart.contactmanager.hibernate.DAO;
import com.itechart.contactmanager.model.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public @ResponseBody List<Person> getContacts() {
        List<Person> persons = dao.getAll();
        return persons;
    }

    @RequestMapping("/edit/{id}")
    public String editPerson(@PathVariable("id") Long id, Model model) {
        Person person = (Person) dao.find(id);
        model.addAttribute("person", person);
        return "edit";
    }

    @Autowired(required = true)
    @Qualifier(value = "personDAO")
    public void setPersonService(DAO personDAO) {
        this.dao = personDAO;
    }

}