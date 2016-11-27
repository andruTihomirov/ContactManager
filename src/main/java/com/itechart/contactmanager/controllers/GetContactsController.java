package com.itechart.contactmanager.controllers;

import com.itechart.contactmanager.hibernate.PersonDAO;
import com.itechart.contactmanager.model.Person;
import com.itechart.contactmanager.services.PersonService;
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

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String getMainPage() {
        return "persons";
    }

    @RequestMapping(value = "/persons", method = RequestMethod.GET)
    public @ResponseBody List<Person> getPersons() {
        List<Person> persons = personService.getAllPersons();
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
        personService.addPerson(person);
        return "persons";
    }

    @RequestMapping("/update/{id}")
    public String updatePerson(@PathVariable("id") Long id) {
        return "persons";
    }

    @RequestMapping("/delete/{id}")
    public String deletePerson(@PathVariable("id") Long id) {
        System.out.println("DELETE: called.");
        personService.deletePerson(id);
        return "persons";
    }

    @Autowired(required = true)
    @Qualifier(value = "personService")
    public void setPersonService(PersonService personService) {
        this.personService = personService;
    }

}