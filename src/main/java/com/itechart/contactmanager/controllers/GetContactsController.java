package com.itechart.contactmanager.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by andrei.tsikhamirau on 11/22/2016.
 */
@Controller
@RequestMapping("/contacts")
public class GetContactsController {

    @RequestMapping(value="/", method = RequestMethod.GET)
    public String getMovie() {
        return "getContacts";

    }

}