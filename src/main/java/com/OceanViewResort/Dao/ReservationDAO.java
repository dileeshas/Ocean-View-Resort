package com.OceanViewResort.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;

import com.OceanViewResort.Model.Reservation;

public class ReservationDAO {

    // Create reservation and return generated ID
    public int addReservation(Reservation reservation) {
        String sql = "INSERT INTO reservations (guest_id, room_id, check_in_date, check_out_date, total_amount, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, reservation.getGuestId());
            ps.setInt(2, reservation.getRoomId());
            ps.setDate(3, reservation.getCheckInDate());
            ps.setDate(4, reservation.getCheckOutDate());
            ps.setDouble(5, reservation.getTotalAmount());
            ps.setString(6, reservation.getStatus());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Get all reservations with guest and room info
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT r.*, g.name AS guest_name, rm.room_number, rm.room_type " +
                     "FROM reservations r " +
                     "JOIN guests g ON r.guest_id = g.guest_id " +
                     "JOIN rooms rm ON r.room_id = rm.room_id " +
                     "ORDER BY r.reservation_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(extractReservation(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get reservation by ID with details
    public Reservation getReservationById(int reservationId) {
        Reservation reservation = null;
        String sql = "SELECT r.*, g.name AS guest_name, rm.room_number, rm.room_type " +
                     "FROM reservations r " +
                     "JOIN guests g ON r.guest_id = g.guest_id " +
                     "JOIN rooms rm ON r.room_id = rm.room_id " +
                     "WHERE r.reservation_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reservationId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                reservation = extractReservation(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reservation;
    }

    // Search reservations by guest name
    public List<Reservation> searchByGuestName(String name) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT r.*, g.name AS guest_name, rm.room_number, rm.room_type " +
                     "FROM reservations r " +
                     "JOIN guests g ON r.guest_id = g.guest_id " +
                     "JOIN rooms rm ON r.room_id = rm.room_id " +
                     "WHERE g.name LIKE ? " +
                     "ORDER BY r.reservation_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(extractReservation(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Update reservation status
    public boolean updateStatus(int reservationId, String status) {
        String sql = "UPDATE reservations SET status = ? WHERE reservation_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, reservationId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Count active reservations
    public int countActiveReservations() {
        String sql = "SELECT COUNT(*) FROM reservations WHERE status = 'Active'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Reservation extractReservation(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setReservationId(rs.getInt("reservation_id"));
        r.setGuestId(rs.getInt("guest_id"));
        r.setRoomId(rs.getInt("room_id"));
        r.setCheckInDate(rs.getDate("check_in_date"));
        r.setCheckOutDate(rs.getDate("check_out_date"));
        r.setTotalAmount(rs.getDouble("total_amount"));
        r.setStatus(rs.getString("status"));
        r.setGuestName(rs.getString("guest_name"));
        r.setRoomNumber(rs.getString("room_number"));
        r.setRoomType(rs.getString("room_type"));
        return r;
    }
}
