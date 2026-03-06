package com.OceanViewResort.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.OceanViewResort.Dao.RoomDAO;
import com.OceanViewResort.Model.Room;


@WebServlet("/checkAvailability")
public class CheckAvailabilityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoomDAO roomDAO = new RoomDAO();
        request.setAttribute("roomTypes", roomDAO.getRoomTypes());
        request.getRequestDispatcher("/Views/check_availability.jsp").forward(request, response);
        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String roomType = request.getParameter("roomType");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        RoomDAO roomDAO = new RoomDAO();
        List<Room> availableRooms = roomDAO.getAvailableRooms(roomType, checkIn, checkOut);

        request.setAttribute("roomTypes", roomDAO.getRoomTypes());
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("selectedType", roomType);
        request.setAttribute("checkIn", checkIn);
        request.setAttribute("checkOut", checkOut);

        request.getRequestDispatcher("/Views/check_availability.jsp").forward(request, response);
    }
}
