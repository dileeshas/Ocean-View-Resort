package com.OceanViewResort.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

import com.OceanViewResort.Dao.GuestDAO;
import com.OceanViewResort.Dao.ReservationDAO;
import com.OceanViewResort.Dao.RoomDAO;
import com.OceanViewResort.Model.Guest;
import com.OceanViewResort.Model.Reservation;
import com.OceanViewResort.util.EmailUtil;

@WebServlet("/billing")
public class BillingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/Views/billing.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        ReservationDAO reservationDAO = new ReservationDAO();
        GuestDAO guestDAO = new GuestDAO();

        if ("search".equals(action)) {

            handleSearch(request, response, reservationDAO, guestDAO);

        } 
        else if ("checkout".equals(action)) {

            handleCheckout(request, response, reservationDAO, guestDAO);

        } 
        else if ("sendInvoice".equals(action)) {

            handleSendInvoice(request, response, reservationDAO, guestDAO);

        }
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response,
                              ReservationDAO reservationDAO, GuestDAO guestDAO)
            throws ServletException, IOException {

        String id = request.getParameter("reservationId");

        if (id == null || id.isEmpty()) {

            request.setAttribute("error", "Please enter a Reservation ID.");
            request.getRequestDispatcher("/Views/billing.jsp").forward(request, response);
            return;

        }

        int reservationId = Integer.parseInt(id);

        Reservation reservation = reservationDAO.getReservationById(reservationId);

        if (reservation == null) {

            request.setAttribute("error", "Reservation #" + reservationId + " not found.");
            request.getRequestDispatcher("/Views/billing.jsp").forward(request, response);
            return;

        }

        Guest guest = guestDAO.getGuestById(reservation.getGuestId());

        long nights = TimeUnit.DAYS.convert(
                reservation.getCheckOutDate().getTime() - reservation.getCheckInDate().getTime(),
                TimeUnit.MILLISECONDS
        );

        request.setAttribute("reservation", reservation);
        request.setAttribute("guest", guest);
        request.setAttribute("nights", nights);

        request.getRequestDispatcher("/Views/billing.jsp").forward(request, response);

    }

    private void handleCheckout(HttpServletRequest request, HttpServletResponse response,
                                ReservationDAO reservationDAO, GuestDAO guestDAO)
            throws ServletException, IOException {

        String idParam = request.getParameter("reservationId");

        if (idParam == null || idParam.isEmpty()) {

            request.setAttribute("error", "Invalid reservation ID.");
            request.getRequestDispatcher("/Views/billing.jsp").forward(request, response);
            return;

        }

        int reservationId = Integer.parseInt(idParam);

        Reservation reservation = reservationDAO.getReservationById(reservationId);

        if (reservation == null) {

            request.setAttribute("error", "Reservation not found for checkout.");
            request.getRequestDispatcher("/Views/billing.jsp").forward(request, response);
            return;

        }

        // Update reservation status
        reservationDAO.updateStatus(reservationId, "Checked-Out");

        // Update room status
        new RoomDAO().updateRoomStatus(reservation.getRoomId(), "Available");

        reservation.setStatus("Checked-Out");

        Guest guest = guestDAO.getGuestById(reservation.getGuestId());

        long nights = TimeUnit.DAYS.convert(
                reservation.getCheckOutDate().getTime() - reservation.getCheckInDate().getTime(),
                TimeUnit.MILLISECONDS
        );

        // Send email invoice

        String email = guest.getEmail();

        String subject = "Ocean View Resort - Invoice";

        String message =
                "Dear " + guest.getName() + ",\n\n" +
                "Thank you for staying at Ocean View Resort.\n\n" +
                "Reservation ID: " + reservation.getReservationId() + "\n" +
                "Room Number: " + reservation.getRoomNumber() + "\n" +
                "Check-in Date: " + reservation.getCheckInDate() + "\n" +
                "Check-out Date: " + reservation.getCheckOutDate() + "\n" +
                "Total Amount: $" + reservation.getTotalAmount() + "\n\n" +
                "We hope to see you again!\n\n" +
                "Ocean View Resort";

        EmailUtil.sendEmail(email, subject, message);

        request.setAttribute("reservation", reservation);
        request.setAttribute("guest", guest);
        request.setAttribute("nights", nights);

        request.setAttribute("checkoutSuccess",
                "Guest checked out successfully! Invoice email sent.");

        request.getRequestDispatcher("/Views/billing.jsp").forward(request, response);

    }

    private void handleSendInvoice(HttpServletRequest request, HttpServletResponse response,
                                   ReservationDAO reservationDAO, GuestDAO guestDAO)
            throws ServletException, IOException {

        int reservationId = Integer.parseInt(request.getParameter("reservationId"));

        Reservation reservation = reservationDAO.getReservationById(reservationId);

        Guest guest = guestDAO.getGuestById(reservation.getGuestId());

        String email = guest.getEmail();

        String subject = "Ocean View Resort - Invoice";

        String message =
                "Dear " + guest.getName() + ",\n\n" +
                "Your invoice details:\n\n" +
                "Reservation ID: " + reservation.getReservationId() + "\n" +
                "Room: " + reservation.getRoomNumber() + "\n" +
                "Total Amount: $" + reservation.getTotalAmount() + "\n\n" +
                "Thank you for staying with us.";

        EmailUtil.sendEmail(email, subject, message);

        request.setAttribute("reservation", reservation);
        request.setAttribute("guest", guest);

        request.setAttribute("checkoutSuccess", "Invoice emailed successfully!");

        request.getRequestDispatcher("/Views/billing.jsp").forward(request, response);
    }
}