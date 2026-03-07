package com.OceanViewResort.TestBeans;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import com.OceanViewResort.Model.Room;

class RoomTest {

    @Test
    void testRoomConstructorAndGetters() {
        // Create a Room object using constructor
        Room room = new Room(101, "A101", "Deluxe", 200.50, "Available");

        // Verify that getters return correct values
        assertEquals(101, room.getRoomId());
        assertEquals("A101", room.getRoomNumber());
        assertEquals("Deluxe", room.getRoomType());
        assertEquals(200.50, room.getPricePerNight(), 0.001);
        assertEquals("Available", room.getStatus());
    }

    @Test
    void testRoomSetters() {
        // Create a Room object using default constructor
        Room room = new Room();

        // Set values using setters
        room.setRoomId(102);
        room.setRoomNumber("B202");
        room.setRoomType("Suite");
        room.setPricePerNight(350.75);
        room.setStatus("Occupied");

        // Verify that getters return updated values
        assertEquals(102, room.getRoomId());
        assertEquals("B202", room.getRoomNumber());
        assertEquals("Suite", room.getRoomType());
        assertEquals(350.75, room.getPricePerNight(), 0.001);
        assertEquals("Occupied", room.getStatus());
    }
}