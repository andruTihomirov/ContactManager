package com.itechart.contactmanager.utils;

import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

/**
 * Created by andrei.tsikhamirau on 12/22/2016.
 */
public class TestUtil {

    public static final String VIEW_RESOLVER_PREFIX = "/WEB-INF/pages/";
    public static final String VIEW_RESOLVER_SUFFIX = ".jsp";

    private TestUtil() {}

    public static ViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();

        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix(VIEW_RESOLVER_PREFIX);
        viewResolver.setSuffix(VIEW_RESOLVER_SUFFIX);

        return viewResolver;
    }
}
