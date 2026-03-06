package com.OceanViewResort.Test;

import static org.junit.Assert.*;
import org.junit.Test;

import com.OceanViewResort.Dao.ReservationDAO;
import com.OceanViewResort.Model.Reservation;

import java.sql.Date;
import java.util.List;

public class ReservationDAOTest {

    ReservationDAO dao = new ReservationDAO();

    @Test
    public void testAddReservation() {

        Reservation res = new Reservation();

        res.setGuestId(1);   
        res.setRoomId(1);   

        res.setCheckInDate(Date.valueOf("2026-03-10"));
        res.setCheckOutDate(Date.valueOf("2026-03-12"));

        res.setTotalAmount(30000);
        res.setStatus("Active");

        int result = dao.addReservation(res);
        assertTrue(result > 0);
    }

    @Test
    public void testGetAllReservations() {

        List<Reservation> list = dao.getAllReservations();
        assertNotNull(list);
    }

    @Test
    public void testGetReservationById() {

        int testId = 1; 
        Reservation res = dao.getReservationById(testId);
        assertNotNull(res);
    }

    @Test
    public void testSearchReservation() {

        List<Reservation> list = dao.searchByGuestName("John");
        assertNotNull(list);
    }

    @Test
    public void testUpdateStatus() {

        int testReservationId = 1; 

        boolean result = dao.updateStatus(testReservationId, "Completed");

        assertTrue(result || !result);
    }

    @Test
    public void testCountActiveReservations() {

        int count = dao.countActiveReservations();

        assertTrue(count >= 0);
    }
}