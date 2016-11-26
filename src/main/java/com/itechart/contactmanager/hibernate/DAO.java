package com.itechart.contactmanager.hibernate;

import java.util.List;

/**
 * Created by andrei.tsikhamirau on 11/24/2016.
 */
public interface DAO<E, K> {

    List<E> getAll();

    E get(K id);

    E update(E entity);

    boolean delete(K id);

    void add(E entity);

}
