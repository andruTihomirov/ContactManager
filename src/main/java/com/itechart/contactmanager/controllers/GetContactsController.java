package com.itechart.contactmanager.controllers;

import com.itechart.contactmanager.hibernate.DAO;
import com.itechart.contactmanager.hibernate.impl.PersonDAO;
import com.itechart.contactmanager.model.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
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

    private DAO dao;

    @RequestMapping(value="/", method = RequestMethod.GET)
    public String getMainPage() {
        return "getContacts";
    }

    @RequestMapping(value="/contacts", method = RequestMethod.GET)
    public @ResponseBody List<Person> getContacts() {
        List<Person> persons0 = dao.getAll();
        return persons0;
    }

    @Autowired(required=true)
    @Qualifier(value="personDAO")
    public void setPersonService(DAO personDAO) {
        this.dao = personDAO;
    }

}