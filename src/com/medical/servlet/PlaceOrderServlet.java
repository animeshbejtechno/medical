package com.medical.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.medical.dao.OrderDAO;
import com.medical.model.Order;
import com.medical.model.User;

public class PlaceOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.html");
            return;
        }

        int medicineId = Integer.parseInt(request.getParameter("medicineId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));
        double totalPrice = price * quantity;

        Order order = new Order();
        order.setUserId(user.getId());
        order.setMedicineId(medicineId);
        order.setQuantity(quantity);
        order.setTotalPrice(totalPrice);

        OrderDAO dao = new OrderDAO();
        int generatedId = dao.placeOrderAndGetId(order);
        if (generatedId > 0) {
            response.sendRedirect("payment.jsp?orderId=" + generatedId + "&amount=" + totalPrice);
        } else {
            response.sendRedirect("home.jsp?msg=Order Failed");
        }
    }
}
