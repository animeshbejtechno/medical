package com.medical.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.medical.model.Order;

public class OrderDAO {

    public int placeOrderAndGetId(Order order) {
        int generatedId = -1;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO orders(user_id, medicine_id, quantity, total_price) VALUES (?,?,?,?)",
                java.sql.Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getMedicineId());
            ps.setInt(3, order.getQuantity());
            ps.setDouble(4, order.getTotalPrice());

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }
            
            // Update stock
            PreparedStatement ps2 = con.prepareStatement(
                "UPDATE medicines SET stock = stock - ? WHERE id = ?"
            );
            ps2.setInt(1, order.getQuantity());
            ps2.setInt(2, order.getMedicineId());
            ps2.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    public boolean placeOrder(Order order) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO orders(user_id, medicine_id, quantity, total_price) VALUES (?,?,?,?)"
            );
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getMedicineId());
            ps.setInt(3, order.getQuantity());
            ps.setDouble(4, order.getTotalPrice());

            ps.executeUpdate();
            
            // Update stock
            PreparedStatement ps2 = con.prepareStatement(
                "UPDATE medicines SET stock = stock - ? WHERE id = ?"
            );
            ps2.setInt(1, order.getQuantity());
            ps2.setInt(2, order.getMedicineId());
            ps2.executeUpdate();
            
            status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public ArrayList<Order> getAllOrders() {
        ArrayList<Order> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT o.*, m.name as medicine_name FROM orders o JOIN medicines m ON o.medicine_id = m.id ORDER BY o.order_date DESC"
            );
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setMedicineId(rs.getInt("medicine_id"));
                o.setQuantity(rs.getInt("quantity"));
                o.setTotalPrice(rs.getDouble("total_price"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setMedicineName(rs.getString("medicine_name"));
                o.setStatus(rs.getString("status"));
                o.setPaymentStatus(rs.getString("payment_status"));
                o.setEstimatedDelivery(rs.getTimestamp("estimated_delivery"));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Order> getOrdersByUser(int userId) {
        ArrayList<Order> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT o.*, m.name as medicine_name FROM orders o JOIN medicines m ON o.medicine_id = m.id WHERE o.user_id = ? ORDER BY o.order_date DESC"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setMedicineId(rs.getInt("medicine_id"));
                o.setQuantity(rs.getInt("quantity"));
                o.setTotalPrice(rs.getDouble("total_price"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setMedicineName(rs.getString("medicine_name"));
                o.setStatus(rs.getString("status"));
                o.setPaymentStatus(rs.getString("payment_status"));
                o.setEstimatedDelivery(rs.getTimestamp("estimated_delivery"));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
