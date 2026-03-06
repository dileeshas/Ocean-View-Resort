package com.OceanViewResort.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.OceanViewResort.Dao.ReservationDAO;
import com.OceanViewResort.Dao.RoomDAO;


@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoomDAO roomDAO = new RoomDAO();
        ReservationDAO reservationDAO = new ReservationDAO();

        request.setAttribute("totalRooms", roomDAO.totalRooms());
        request.setAttribute("availableRooms", roomDAO.countByStatus("Available"));
        request.setAttribute("occupiedRooms", roomDAO.countByStatus("Occupied"));
        request.setAttribute("activeReservations", reservationDAO.countActiveReservations());

        request.getRequestDispatcher("/Views/dashboard.jsp").forward(request, response);
    }
}