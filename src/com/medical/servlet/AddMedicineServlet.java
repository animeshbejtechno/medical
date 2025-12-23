package com.medical.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.*;
import javax.servlet.http.*;

import com.medical.dao.DBConnection;

public class AddMedicineServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String category = req.getParameter("category");
        double price = Double.parseDouble(req.getParameter("price"));
        int stock = Integer.parseInt(req.getParameter("stock"));
        String description = req.getParameter("description");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO medicines(name,price,stock,description) VALUES (?,?,?,?)"
            );

            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, stock);
            ps.setString(4, description);

            ps.executeUpdate();
            res.sendRedirect("admin.jsp?msg=Medicine Added Successfully");

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Medicine Add Failed");
        }
    }
}
