package com.medical.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.medical.dao.ServiceBookingDAO;
import com.medical.model.ServiceBooking;
import com.medical.model.User;

public class BookServiceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.html");
            return;
        }

        int serviceId = Integer.parseInt(request.getParameter("serviceId"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        ServiceBooking booking = new ServiceBooking();
        booking.setUserId(user.getId());
        booking.setServiceId(serviceId);
        booking.setAddress(address);
        booking.setPhone(phone);

        ServiceBookingDAO dao = new ServiceBookingDAO();
        if (dao.bookService(booking)) {
            response.sendRedirect("services.jsp?msg=Service Booked Successfully");
        } else {
            response.sendRedirect("services.jsp?msg=Booking Failed");
        }
    }
}
