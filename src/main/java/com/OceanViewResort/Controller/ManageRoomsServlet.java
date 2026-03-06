package com.OceanViewResort.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.OceanViewResort.Dao.RoomDAO;
import com.OceanViewResort.Model.Room;


@WebServlet("/manageRooms")
public class ManageRoomsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoomDAO roomDAO = new RoomDAO();
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Room room = roomDAO.getRoomById(id);
            request.setAttribute("editRoom", room);
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            roomDAO.deleteRoom(id);
            request.setAttribute("message", "Room deleted successfully.");
        }

        request.setAttribute("rooms", roomDAO.getAllRooms());
        request.getRequestDispatcher("/Views/manage_rooms.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoomDAO roomDAO = new RoomDAO();
        String roomIdStr = request.getParameter("roomId");

        Room room = new Room();
        room.setRoomNumber(request.getParameter("roomNumber"));
        room.setRoomType(request.getParameter("roomType"));
        room.setPricePerNight(Double.parseDouble(request.getParameter("pricePerNight")));
        room.setStatus(request.getParameter("status"));

        if (roomIdStr != null && !roomIdStr.isEmpty()) {
            // Update
            room.setRoomId(Integer.parseInt(roomIdStr));
            roomDAO.updateRoom(room);
            request.setAttribute("message", "Room updated successfully.");
        } else {
            // Add
            roomDAO.addRoom(room);
            request.setAttribute("message", "Room added successfully.");
        }

        request.setAttribute("rooms", roomDAO.getAllRooms());
        request.getRequestDispatcher("/Views/manage_rooms.jsp").forward(request, response);
    }
}