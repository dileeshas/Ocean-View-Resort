package com.OceanViewResort.Test;

import static org.junit.Assert.*;
import org.junit.Test;

import com.OceanViewResort.Dao.GuestDAO;
import com.OceanViewResort.Model.Guest;

public class GuestDAOTest {

    @Test
    public void testAddGuest() {

        GuestDAO dao = new GuestDAO();

        Guest guest = new Guest();
        guest.setName("John Doe");
        guest.setAddress("Colombo");
        guest.setContactNumber("0771234567");
        guest.setEmail("john@gmail.com");

        int generatedId = dao.addGuest(guest);

        assertTrue(generatedId > 0);
    }

    @Test
    public void testGetGuestById() {

        GuestDAO dao = new GuestDAO();
        int testId = 1;
        Guest guest = dao.getGuestById(testId);
        assertNotNull(guest);
    }
}