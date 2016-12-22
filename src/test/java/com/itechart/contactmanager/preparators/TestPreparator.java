package com.itechart.contactmanager.preparators;

import com.itechart.contactmanager.model.Person;
import com.itechart.contactmanager.model.PersonBuilder;
import com.itechart.contactmanager.model.Phone;
import com.itechart.contactmanager.model.PhoneBuilder;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by andrei.tsikhamirau on 12/22/2016.
 */
public class TestPreparator {

    private TestPreparator() {}

    public static List<Person> preparePersons(int count) {
        List<Person> persons = new ArrayList<Person>();

        for(int i = 0; i < count; i++) {
            long id = (long) i;
            persons.add(preparePerson(id));
        }

        return persons;
    }

    public static Person preparePerson(Long id) {
        return new PersonBuilder()
                .id(id)
                .imagePath("/ContactManager/static/img/leia.gif")
                .name("Name_" + id)
                .surname("Surname_" + id)
                .patronymic("patronymic" + id)
                .dob("01/01/1993")
                .address("address_" + id)
                .phones(preparePhones(2))
                .build();
    }

    public static List<Phone> preparePhones(int count) {
        List<Phone> phones = new ArrayList<Phone>();

        for(int i = 0; i < count; i++) {
            long id = (long) i;
            phones.add(preparePhone(id));
        }

        return phones;

    }

    public static Phone preparePhone(Long id) {
        return new PhoneBuilder()
                .id(id)
                .number("+123456789" + id)
                .build();
    }
}
