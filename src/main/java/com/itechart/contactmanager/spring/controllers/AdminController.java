package com.itechart.contactmanager.spring.controllers;

import com.itechart.contactmanager.spring.utils.UserUtil;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by andrei.tsikhamirau on 12/9/2016.
 */

@Controller
public class AdminController {

    private final static Logger logger = Logger.getLogger(AdminController.class);

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String getAdminPage(ModelMap model) {
        String userName = UserUtil.getUserName();
        model.addAttribute("user", userName);
        logger.info("Method getAdminPage() called. User name: [" + userName + "]");
        return "admin";
    }

}
