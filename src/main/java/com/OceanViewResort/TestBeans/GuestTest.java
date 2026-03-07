package com.OceanViewResort.TestBeans;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import com.OceanViewResort.Model.Guest;

class GuestTest {

    @Test
    void testGuestConstructorAndGetters() {
        // Create a Guest object
        Guest guest = new Guest(1, "John Doe", "123 Ocean Street", "1234567890", "john@example.com");

        // Test getters
        assertEquals(1, guest.getGuestId());
        assertEquals("John Doe", guest.getName());
        assertEquals("123 Ocean Street", guest.getAddress());
        assertEquals("1234567890", guest.getContactNumber());
        assertEquals("john@example.com", guest.getEmail());
    }

    @Test
    void testGuestSetters() {
        // Create an empty Guest object
        Guest guest = new Guest();

        // Test setters
        guest.setGuestId(2);
        guest.setName("Jane Smith");
        guest.setAddress("456 Beach Road");
        guest.setContactNumber("0987654321");
        guest.setEmail("jane@example.com");

        // Verify the values using getters
        assertEquals(2, guest.getGuestId());
        assertEquals("Jane Smith", guest.getName());
        assertEquals("456 Beach Road", guest.getAddress());
        assertEquals("0987654321", guest.getContactNumber());
        assertEquals("jane@example.com", guest.getEmail());
    }
}