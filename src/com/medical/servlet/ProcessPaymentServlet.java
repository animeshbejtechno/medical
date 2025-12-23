package com.medical.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.medical.dao.DBConnection;

public class ProcessPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdsStr = request.getParameter("orderIds");
        String paymentMethod = request.getParameter("paymentMethod");
        String paymentStatus = "Paid";
        
        if ("COD".equalsIgnoreCase(paymentMethod)) {
            paymentStatus = "Pending";
        }

        try {
            Connection con = DBConnection.getConnection();
            
            // Simulate delivery time (3 days from now)
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, 3);
            Timestamp estimatedDelivery = new Timestamp(cal.getTimeInMillis());

            String[] ids = orderIdsStr.split(",");
            PreparedStatement ps = con.prepareStatement(
                "UPDATE orders SET payment_status = ?, status = 'Processing', estimated_delivery = ? WHERE id = ?"
            );
            
            for (String id : ids) {
                ps.setString(1, paymentStatus);
                ps.setTimestamp(2, estimatedDelivery);
                ps.setInt(3, Integer.parseInt(id.trim()));
                ps.addBatch();
            }
            
            ps.executeBatch();
            
            String successMsg = "Payment Successful! Your orders are being processed.";
            if ("COD".equalsIgnoreCase(paymentMethod)) {
                successMsg = "Order Confirmed! Please pay on delivery.";
            }
            
            response.sendRedirect("orders.jsp?msg=" + successMsg);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("orders.jsp?msg=Payment Failed. Please try again.");
        }
    }
}
