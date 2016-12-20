package com.itechart.contactmanager.spring.services.impl;

import com.itechart.contactmanager.model.User;
import com.itechart.contactmanager.model.UserProfile;
import com.itechart.contactmanager.spring.services.UserService;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("customUserDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {

    private final static Logger logger = Logger.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private UserService userService;

    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String sso)
            throws UsernameNotFoundException {
        User user = userService.getBySso(sso);
        if (user == null) {
            logger.error("Method loadUserByUsername() called. User not found. Username: [" + sso + "]");
            throw new UsernameNotFoundException("Username not found");
        }
        logger.info("Method loadUserByUsername() called. Username: [" + sso + "]");
        return new org.springframework.security.core.userdetails.User(user.getSsoId(), user.getPassword(),
                user.getState().equals("Active"), true, true, true, getGrantedAuthorities(user));
    }


    private List<GrantedAuthority> getGrantedAuthorities(User user) {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        logger.info("Method getGrantedAuthorities() called.");
        for (UserProfile userProfile : user.getUserProfiles()) {
            String userType = userProfile.getType();
            authorities.add(new SimpleGrantedAuthority("ROLE_" + userType));
            logger.info("Authority with role: [ROLE_" + userType + "] added.");
        }
        return authorities;
    }

}
