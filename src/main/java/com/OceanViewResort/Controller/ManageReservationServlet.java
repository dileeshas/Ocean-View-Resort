package com.OceanViewResort.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.OceanViewResort.Dao.ReservationDAO;
import com.OceanViewResort.Model.Reservation;
import com.OceanViewResort.Dao.RoomDAO;


@WebServlet("/manageReservation")
public class ManageReservationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        ReservationDAO reservationDAO = new ReservationDAO();

        if ("cancel".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            reservationDAO.updateStatus(id, "Cancelled");

            // Free up the room
            Reservation res = reservationDAO.getReservationById(id);
            if (res != null) {
            	new RoomDAO().updateRoomStatus(res.getRoomId(), "Available");
            }

            request.setAttribute("message", "Reservation #" + id + " has been cancelled.");
        }

        if ("view".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Reservation res = reservationDAO.getReservationById(id);
            request.setAttribute("viewReservation", res);
        }

        List<Reservation> reservations = reservationDAO.getAllReservations();
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("/Views/manage_reservation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("searchTerm");
        ReservationDAO reservationDAO = new ReservationDAO();

        List<Reservation> reservations;
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(searchTerm.trim());
                Reservation r = reservationDAO.getReservationById(id);
                reservations = new java.util.ArrayList<>();
                if (r != null) reservations.add(r);
            } catch (NumberFormatException e) {
                reservations = reservationDAO.searchByGuestName(searchTerm.trim());
            }
        } else {
            reservations = reservationDAO.getAllReservations();
        }

        request.setAttribute("reservations", reservations);
        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("/Views/manage_reservation.jsp").forward(request, response);
    }
}
