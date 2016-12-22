package com.itechart.contactmanager.model;

/**
 * Created by andrei.tsikhamirau on 12/22/2016.
 */
public class PhoneBuilder {

    private Phone phone;

    public PhoneBuilder() {
        this.phone = new Phone();
    }

    public PhoneBuilder id(Long id) {
        this.phone.setId(id);
        return this;
    }

    public PhoneBuilder number(String number) {
        this.phone.setNumber(number);
        return this;
    }

    public Phone build() {
        return this.phone;
    }

}
