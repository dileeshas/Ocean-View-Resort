package com.OceanViewResort.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.OceanViewResort.Model.Room;

public class RoomDAO {

    // Get all rooms
    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms ORDER BY room_number";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                rooms.add(extractRoom(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }

    // Get available rooms by type and date range
    public List<Room> getAvailableRooms(String roomType, String checkIn, String checkOut) {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE status = 'Available' AND room_type = ? " +
                     "AND room_id NOT IN (" +
                     "  SELECT room_id FROM reservations " +
                     "  WHERE status = 'Active' " +
                     "  AND check_in_date < ? AND check_out_date > ?" +
                     ") ORDER BY room_number";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, roomType);
            ps.setString(2, checkOut);
            ps.setString(3, checkIn);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                rooms.add(extractRoom(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }

    // Get room by ID
    public Room getRoomById(int roomId) {
        Room room = null;
        String sql = "SELECT * FROM rooms WHERE room_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                room = extractRoom(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return room;
    }

    // Add room
    public boolean addRoom(Room room) {
        String sql = "INSERT INTO rooms (room_number, room_type, price_per_night, status) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getRoomType());
            ps.setDouble(3, room.getPricePerNight());
            ps.setString(4, room.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update room
    public boolean updateRoom(Room room) {
        String sql = "UPDATE rooms SET room_number = ?, room_type = ?, price_per_night = ?, status = ? WHERE room_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getRoomType());
            ps.setDouble(3, room.getPricePerNight());
            ps.setString(4, room.getStatus());
            ps.setInt(5, room.getRoomId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete room
    public boolean deleteRoom(int roomId) {
        String sql = "DELETE FROM rooms WHERE room_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update room status
    public boolean updateRoomStatus(int roomId, String status) {
        String sql = "UPDATE rooms SET status = ? WHERE room_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, roomId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Count rooms by status
    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM rooms WHERE status = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Total rooms
    public int totalRooms() {
        String sql = "SELECT COUNT(*) FROM rooms";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get distinct room types
    public List<String> getRoomTypes() {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT room_type FROM rooms ORDER BY room_type";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                types.add(rs.getString("room_type"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return types;
    }

    private Room extractRoom(ResultSet rs) throws SQLException {
        Room room = new Room();
        room.setRoomId(rs.getInt("room_id"));
        room.setRoomNumber(rs.getString("room_number"));
        room.setRoomType(rs.getString("room_type"));
        room.setPricePerNight(rs.getDouble("price_per_night"));
        room.setStatus(rs.getString("status"));
        return room;
    }
}