package com.medical.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.medical.dao.DBConnection;

public class UpdateServiceStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String status = request.getParameter("status");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE service_bookings SET status = ? WHERE id = ?");
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
            response.sendRedirect("admin.jsp?msg=Service Status Updated Successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?msg=Update Failed");
        }
    }
}
