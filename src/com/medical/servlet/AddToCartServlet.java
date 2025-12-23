package com.medical.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.medical.model.CartItem;
import com.medical.model.Medicine;
import com.medical.dao.MedicineDAO;

public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int medicineId = Integer.parseInt(request.getParameter("medicineId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        boolean exists = false;
        for (CartItem item : cart) {
            if (item.getMedicineId() == medicineId) {
                item.setQuantity(item.getQuantity() + quantity);
                exists = true;
                break;
            }
        }

        if (!exists) {
            MedicineDAO dao = new MedicineDAO();
            Medicine med = dao.getMedicineById(medicineId);
            if (med != null) {
                cart.add(new CartItem(medicineId, med.getName(), med.getPrice(), quantity));
            }
        }

        response.sendRedirect("home.jsp?msg=Item added to cart");
    }
}
