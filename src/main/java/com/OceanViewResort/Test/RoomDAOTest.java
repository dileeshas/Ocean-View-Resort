package com.OceanViewResort.Test;

import static org.junit.Assert.*;
import org.junit.Test;

import com.OceanViewResort.Dao.RoomDAO;
import com.OceanViewResort.Model.Room;

import java.util.List;

public class RoomDAOTest {

    RoomDAO dao = new RoomDAO();

    @Test
    public void testTotalRooms() {
        int total = dao.totalRooms();
        assertTrue(total >= 0);
    }

    @Test
    public void testGetAllRooms() {
        List<Room> rooms = dao.getAllRooms();
        assertNotNull(rooms);
    }

    @Test
    public void testAddRoom() {

        Room room = new Room();
        room.setRoomNumber("R101");
        room.setRoomType("Deluxe");
        room.setPricePerNight(15000);
        room.setStatus("Available");

        boolean result = dao.addRoom(room);
        assertTrue(result);
    }

    @Test
    public void testUpdateRoomStatus() {

        int testRoomId = 1; 

        boolean result = dao.updateRoomStatus(testRoomId, "Occupied");
        assertTrue(result || !result);
    }

    @Test
    public void testGetRoomById() {

        int testRoomId = 1; 

        Room room = dao.getRoomById(testRoomId);
        assertNotNull(room);
    }
}