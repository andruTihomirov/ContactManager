package com.itechart.contactmanager.spring.controllers;

import com.itechart.contactmanager.model.Person;
import com.itechart.contactmanager.spring.services.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by andrei.tsikhamirau on 11/22/2016.
 */
@Controller
@RequestMapping("/")
public class GetContactsController {

    private PersonService personService;

//    @RequestMapping(value = "/", method = RequestMethod.GET)
//    public String getMainPage() {
//        return "persons";
//    }

    @RequestMapping(value = "/persons", method = RequestMethod.GET)
    public @ResponseBody List<Person> getPersons() {
        List<Person> persons = personService.getAllPersons();
        return persons;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String createPerson(@RequestBody Person person) {
        personService.addPerson(person);
        return "persons";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updatePerson(@RequestBody Person person) {
        personService.updatePerson(person);
        return "persons";
    }


    @RequestMapping("/delete/{id}")
    public String deletePerson(@PathVariable("id") Long id) {
        System.out.println("DELETE: called.");
        personService.deletePerson(id);
        return "persons";
    }

    @Autowired
    @Qualifier(value = "personService")
    public void setPersonService(PersonService personService) {
        this.personService = personService;
    }

}