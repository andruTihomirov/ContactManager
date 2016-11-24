package com.itechart.contactmanager.controllers;

import com.itechart.contactmanager.model.Person;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by andrei.tsikhamirau on 11/22/2016.
 */
@Controller
@RequestMapping("/")
public class GetContactsController {

    @RequestMapping(value="/", method = RequestMethod.GET)
    public String getMainPage() {
        return "getContacts";
    }

    @RequestMapping(value="/contacts", method = RequestMethod.GET)
    public @ResponseBody List<Person> getContacts() {

        List<String> phoneNumber = new ArrayList<String>();
        phoneNumber.add("+375291111111");
        phoneNumber.add("+375292222222");
        Person person = new Person("Name0", "Surename0", "Patronymic0", phoneNumber, "12.12.2000", "address0");

        List<Person> persons = new ArrayList<Person>();
        persons.add(person);

        return persons;
    }


}