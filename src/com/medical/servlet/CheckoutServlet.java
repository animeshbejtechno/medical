package com.medical.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.medical.dao.OrderDAO;
import com.medical.model.CartItem;
import com.medical.model.Order;
import com.medical.model.User;

public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect("login.html");
            return;
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("home.jsp?msg=Cart is empty");
            return;
        }

        OrderDAO dao = new OrderDAO();
        List<Integer> orderIds = new ArrayList<>();
        double totalAmount = 0;

        for (CartItem item : cart) {
            Order order = new Order();
            order.setUserId(user.getId());
            order.setMedicineId(item.getMedicineId());
            order.setQuantity(item.getQuantity());
            order.setTotalPrice(item.getTotalPrice());
            
            int id = dao.placeOrderAndGetId(order);
            if (id > 0) {
                orderIds.add(id);
                totalAmount += item.getTotalPrice();
            }
        }

        // Clear cart after checkout
        session.removeAttribute("cart");

        // Join order IDs into a comma-separated string
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < orderIds.size(); i++) {
            sb.append(orderIds.get(i));
            if (i < orderIds.size() - 1) sb.append(",");
        }

        response.sendRedirect("payment.jsp?orderIds=" + sb.toString() + "&amount=" + totalAmount);
    }
}
