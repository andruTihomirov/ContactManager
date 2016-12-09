package com.itechart.contactmanager.spring.controllers;

import com.itechart.contactmanager.spring.utils.UserUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by andrei.tsikhamirau on 12/9/2016.
 */

@Controller
public class AdminController {

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminPage(ModelMap model) {
        model.addAttribute("user", UserUtil.getUserName());
        return "admin";
    }

}
