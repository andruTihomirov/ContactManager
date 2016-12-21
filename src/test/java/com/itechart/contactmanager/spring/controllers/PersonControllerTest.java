package com.itechart.contactmanager.spring.controllers;

import com.itechart.contactmanager.model.Person;
import com.itechart.contactmanager.spring.controllers.PersonController;
import com.itechart.contactmanager.spring.services.PersonService;
import java.util.ArrayList;
import java.util.List;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;


import static org.mockito.Matchers.isA;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

/**
 * Created by andrei.tsikhamirau on 12/21/2016.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:root-context.xml", "classpath:mvc-dispatcher-servlet.xml",
        "classpath:spring-security.xml"})
@WebAppConfiguration
public class PersonControllerTest {

    public static final String PERSONS_JSP = "/WEB-INF/pages/persons.jsp";
    public static final String MAIN_URL = "/";
    public static final String PERSONS_URL = "/persons";

    public Person person;

    private MockMvc mockMvc;

    @Autowired
    private WebApplicationContext webApplicationContext;

    private PersonService personService;

    @Before
    public void setUp() {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        personService = Mockito.mock(PersonService.class);
        Mockito.reset(personService);
    }

    @Test
    public void testGetMainPage() throws Exception {
        mockMvc.perform(get(MAIN_URL))
                .andExpect(status().isOk())
                .andExpect(view().name(PersonController.VIEW_PERSONS))
                .andExpect(forwardedUrl(PERSONS_JSP));
    }

    @Test
    public void testGetPersons() throws Exception {
        List<Person> persons = buildPersons();

        when(personService.getAllPersons()).thenReturn(persons);

        mockMvc.perform(post(PERSONS_URL))
                .andExpect(status().isOk());

        verify(personService, times(1)).getAllPersons();
        verifyNoMoreInteractions(personService);
    }

    private List<Person> buildPersons() {
        List<Person> persons = new ArrayList<Person>();
        Person person0 = new Person("test0", "test0", "test0", null,  "test0", "test0", "test0");
        Person person1 = new Person("test1", "test1", "test1", null,  "test1", "test1", "test1");
        Person person2 = new Person("test2", "test2", "test2", null,  "test2", "test2", "test2");
        persons.add(person0);
        persons.add(person1);
        persons.add(person2);
        return persons;
    }
}
