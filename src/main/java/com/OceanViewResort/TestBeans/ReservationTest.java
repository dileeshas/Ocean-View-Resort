package com.OceanViewResort.TestBeans;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Date;

import org.junit.jupiter.api.Test;

import com.OceanViewResort.Model.Reservation;

class ReservationTest {

    @Test
    void testReservationSettersAndGetters() {
        // Create a Reservation object
        Reservation reservation = new Reservation();

        // Set values using setters
        reservation.setReservationId(101);
        reservation.setGuestId(1);
        reservation.setRoomId(201);
        reservation.setCheckInDate(Date.valueOf("2026-03-10"));
        reservation.setCheckOutDate(Date.valueOf("2026-03-15"));
        reservation.setTotalAmount(1500.75);
        reservation.setStatus("Confirmed");
        reservation.setGuestName("John Doe");
        reservation.setRoomNumber("A101");
        reservation.setRoomType("Deluxe");

        // Verify values using getters
        assertEquals(101, reservation.getReservationId());
        assertEquals(1, reservation.getGuestId());
        assertEquals(201, reservation.getRoomId());
        assertEquals(Date.valueOf("2026-03-10"), reservation.getCheckInDate());
        assertEquals(Date.valueOf("2026-03-15"), reservation.getCheckOutDate());
        assertEquals(1500.75, reservation.getTotalAmount(), 0.001);
        assertEquals("Confirmed", reservation.getStatus());
        assertEquals("John Doe", reservation.getGuestName());
        assertEquals("A101", reservation.getRoomNumber());
        assertEquals("Deluxe", reservation.getRoomType());
    }
}