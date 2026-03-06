package com.OceanViewResort.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.concurrent.TimeUnit;

import com.OceanViewResort.Dao.GuestDAO;
import com.OceanViewResort.Dao.ReservationDAO;
import com.OceanViewResort.Dao.RoomDAO;
import com.OceanViewResort.Model.Guest;
import com.OceanViewResort.Model.Reservation;
import com.OceanViewResort.Model.Room;


@WebServlet("/newReservation")
public class NewReservationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoomDAO roomDAO = new RoomDAO();
        request.setAttribute("roomTypes", roomDAO.getRoomTypes());

        // Pre-fill from availability check
        String roomId = request.getParameter("roomId");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        if (roomId != null) {
            Room room = roomDAO.getRoomById(Integer.parseInt(roomId));
            request.setAttribute("selectedRoom", room);
            request.setAttribute("checkIn", checkIn);
            request.setAttribute("checkOut", checkOut);

            // Calculate nights and total
            if (checkIn != null && checkOut != null && room != null) {
                Date inDate = Date.valueOf(checkIn);
                Date outDate = Date.valueOf(checkOut);
                long nights = TimeUnit.DAYS.convert(outDate.getTime() - inDate.getTime(), TimeUnit.MILLISECONDS);
                request.setAttribute("nights", nights);
                request.setAttribute("totalAmount", nights * room.getPricePerNight());
            }
        }

        request.getRequestDispatcher("/Views/new_reservation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get guest details
        String guestName = request.getParameter("guestName");
        String address = request.getParameter("address");
        String contact = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        // Save guest
        GuestDAO guestDAO = new GuestDAO();
        Guest guest = new Guest();
        guest.setName(guestName);
        guest.setAddress(address);
        guest.setContactNumber(contact);
        guest.setEmail(email);
        int guestId = guestDAO.addGuest(guest);

        // Calculate total
        RoomDAO roomDAO = new RoomDAO();
        Room room = roomDAO.getRoomById(roomId);
        Date inDate = Date.valueOf(checkIn);
        Date outDate = Date.valueOf(checkOut);
        long nights = TimeUnit.DAYS.convert(outDate.getTime() - inDate.getTime(), TimeUnit.MILLISECONDS);
        double totalAmount = nights * room.getPricePerNight();

        // Save reservation
        ReservationDAO reservationDAO = new ReservationDAO();
        Reservation reservation = new Reservation();
        reservation.setGuestId(guestId);
        reservation.setRoomId(roomId);
        reservation.setCheckInDate(inDate);
        reservation.setCheckOutDate(outDate);
        reservation.setTotalAmount(totalAmount);
        reservation.setStatus("Active");

        int reservationId = reservationDAO.addReservation(reservation);

        // Update room status to Occupied
        roomDAO.updateRoomStatus(roomId, "Occupied");

        // Show confirmation
        request.setAttribute("success", "Reservation created successfully!");
        request.setAttribute("reservationId", reservationId);
        request.setAttribute("guestName", guestName);
        request.setAttribute("roomNumber", room.getRoomNumber());
        request.setAttribute("roomType", room.getRoomType());
        request.setAttribute("checkIn", checkIn);
        request.setAttribute("checkOut", checkOut);
        request.setAttribute("nights", nights);
        request.setAttribute("totalAmount", totalAmount);

        request.getRequestDispatcher("/Views/new_reservation.jsp").forward(request, response);
    }
}
