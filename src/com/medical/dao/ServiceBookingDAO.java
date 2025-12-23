package com.medical.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import com.medical.model.ServiceBooking;

public class ServiceBookingDAO {
    public boolean bookService(ServiceBooking booking) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO service_bookings(user_id, service_id, address, phone) VALUES (?,?,?,?)"
            );
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getServiceId());
            ps.setString(3, booking.getAddress());
            ps.setString(4, booking.getPhone());
            ps.executeUpdate();
            status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public ArrayList<ServiceBooking> getAllBookings() {
        ArrayList<ServiceBooking> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT b.*, s.name as service_name FROM service_bookings b JOIN services s ON b.service_id = s.id ORDER BY b.booking_date DESC"
            );
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ServiceBooking b = new ServiceBooking();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setServiceId(rs.getInt("service_id"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setStatus(rs.getString("status"));
                b.setAddress(rs.getString("address"));
                b.setPhone(rs.getString("phone"));
                b.setServiceName(rs.getString("service_name"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<ServiceBooking> getBookingsByUser(int userId) {
        ArrayList<ServiceBooking> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT b.*, s.name as service_name FROM service_bookings b JOIN services s ON b.service_id = s.id WHERE b.user_id = ? ORDER BY b.booking_date DESC"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ServiceBooking b = new ServiceBooking();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setServiceId(rs.getInt("service_id"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setStatus(rs.getString("status"));
                b.setAddress(rs.getString("address"));
                b.setPhone(rs.getString("phone"));
                b.setServiceName(rs.getString("service_name"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
