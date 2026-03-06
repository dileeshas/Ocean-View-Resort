package com.OceanViewResort.Test;


import static org.junit.Assert.*;
import org.junit.Test;

import com.OceanViewResort.Model.User;

public class UserTest {

    @Test
    public void testUserConstructor() {

        User user = new User(1, "admin", "admin123");

        assertEquals(1, user.getUserId());
        assertEquals("admin", user.getUsername());
        assertEquals("admin123", user.getPassword());
    }
}