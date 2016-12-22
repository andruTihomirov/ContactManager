package com.itechart.contactmanager.spring.controllers;

import com.itechart.contactmanager.utils.TestUtil;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;


import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

/**
 * Created by andrei.tsikhamirau on 12/22/2016.
 */
@RunWith(MockitoJUnitRunner.class)
@ContextConfiguration(locations = {"classpath:spring-security.xml", "classpath:mvc-dispatcher-servlet.xml"})
public class AuthenticationControllerTest {

    private static final String VIEW_LOGIN = "login";
    private static final String VIEW_LOGOUT = "logout";

    private static final String LOGIN_JSP = TestUtil.VIEW_RESOLVER_PREFIX + VIEW_LOGIN + TestUtil.VIEW_RESOLVER_SUFFIX;
    private static final String LOGOUT_JSP = TestUtil.VIEW_RESOLVER_PREFIX + VIEW_LOGOUT + TestUtil.VIEW_RESOLVER_SUFFIX;

    private static final String LOGIN_URL = "/login";
    public static final String LOGOUT_URL = "/logout";

    private MockMvc mockMvc;

    @Before
    public void setUp() {
        AuthenticationController authenticationController = new AuthenticationController();
        mockMvc = MockMvcBuilders.standaloneSetup(authenticationController)
                .setViewResolvers(TestUtil.viewResolver())
                .build();
    }

    @Test
    public void testLoginPage() throws Exception {
        mockMvc.perform(get(LOGIN_URL))
                .andExpect(status().isOk())
                .andExpect(view().name(VIEW_LOGIN))
                .andExpect(forwardedUrl(LOGIN_JSP));
    }

    @Test
    public void testGetLogoutPage() throws Exception {

    }
}
