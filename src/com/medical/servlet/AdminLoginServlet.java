package com.medical.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Hardcoded admin credentials
        if(username.equals("admin") && password.equals("admin123")) {

            HttpSession session = req.getSession();
            session.setAttribute("admin", username);

            res.sendRedirect(req.getContextPath() + "/admin.jsp");

        } else {
            res.getWriter().println("Invalid Admin Credentials");
        }
    }
}
