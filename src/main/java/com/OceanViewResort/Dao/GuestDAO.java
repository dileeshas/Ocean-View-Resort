package com.OceanViewResort.Dao;

import java.sql.*;

import com.OceanViewResort.Model.Guest;

public class GuestDAO {

    // Add guest and return generated ID
    public int addGuest(Guest guest) {
        String sql = "INSERT INTO guests (name, address, contact_number, email) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, guest.getName());
            ps.setString(2, guest.getAddress());
            ps.setString(3, guest.getContactNumber());
            ps.setString(4, guest.getEmail());
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

    // Get guest by ID
    public Guest getGuestById(int guestId) {
        Guest guest = null;
        String sql = "SELECT * FROM guests WHERE guest_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, guestId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                guest = new Guest();
                guest.setGuestId(rs.getInt("guest_id"));
                guest.setName(rs.getString("name"));
                guest.setAddress(rs.getString("address"));
                guest.setContactNumber(rs.getString("contact_number"));
                guest.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return guest;
    }
}
