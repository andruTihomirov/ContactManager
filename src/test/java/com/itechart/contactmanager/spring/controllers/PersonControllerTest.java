package com.itechart.contactmanager.spring.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itechart.contactmanager.model.Person;
import com.itechart.contactmanager.preparators.TestPreparator;
import com.itechart.contactmanager.spring.services.PersonService;
import java.util.List;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;


import static org.mockito.Matchers.any;
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
@RunWith(MockitoJUnitRunner.class)
@ContextConfiguration(locations = {"classpath:mvc-dispatcher-servlet.xml"})
@WebAppConfiguration
public class PersonControllerTest {

    private static final String VIEW_RESOLVER_PREFIX = "/WEB-INF/pages/";
    private static final String VIEW_RESOLVER_SUFFIX = ".jsp";

    public static final String PERSONS_JSP = VIEW_RESOLVER_PREFIX + "persons" + VIEW_RESOLVER_SUFFIX;

    public static final String MAIN_URL = "/";
    public static final String PERSONS_URL = "/persons";
    public static final String CREATE_URL = "/create";
    public static final String UPDATE_URL = "/update";
    public static final String DELETE_URL = "/delete/{id}";

    public static final long ID = 1L;
    public static final int PERSON_COUNT = 4;

    public Person person;

    private MockMvc mockMvc;

    @Mock
    private PersonService personService;

    @Before
    public void setUp() {

        PersonController personController = new PersonController();
        personController.setPersonService(personService);

        mockMvc = MockMvcBuilders.standaloneSetup(personController)
                .setViewResolvers(viewResolver())
                .build();
    }

    private ViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();

        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix(VIEW_RESOLVER_PREFIX);
        viewResolver.setSuffix(VIEW_RESOLVER_SUFFIX);

        return viewResolver;
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
        List<Person> persons = TestPreparator.preparePersons(PERSON_COUNT);
        when(personService.getAllPersons()).thenReturn(persons);

        mockMvc.perform(get(PERSONS_URL))
                .andExpect(status().isOk());

        verify(personService, times(1)).getAllPersons();
        verifyNoMoreInteractions(personService);
    }

    @Test
    public void testCreatePerson() throws Exception {
        Person person = TestPreparator.preparePerson(ID);

        ObjectMapper mapper = new ObjectMapper();
        String personJson =  mapper.writeValueAsString(person);

        mockMvc.perform(post(CREATE_URL).contentType(MediaType.APPLICATION_JSON).content(personJson))
                .andExpect(status().isOk())
                .andExpect(view().name(PersonController.VIEW_PERSONS));

        verify(personService, times(1)).addPerson(any(Person.class));
        verifyNoMoreInteractions(personService);

    }

    @Test
    public void testUpdatePerson() throws Exception {
        Person person = TestPreparator.preparePerson(ID);

        ObjectMapper mapper = new ObjectMapper();
        String personJson =  mapper.writeValueAsString(person);

        mockMvc.perform(post(UPDATE_URL).contentType(MediaType.APPLICATION_JSON).content(personJson))
                .andExpect(status().isOk())
                .andExpect(view().name(PersonController.VIEW_PERSONS));

        verify(personService, times(1)).updatePerson(any(Person.class));
        verifyNoMoreInteractions(personService);
    }

    @Test
    public void testDeletePerson() throws Exception {
        mockMvc.perform(get(DELETE_URL, ID))
                .andExpect(status().isOk())
                .andExpect(view().name(PersonController.VIEW_PERSONS));
    }

}
