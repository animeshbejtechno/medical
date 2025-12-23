package com.medical.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.medical.dao.MedicineDAO;

public class DeleteMedicineServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        System.out.println("DeleteMedicineServlet: Received ID string: " + idStr);
        int id = Integer.parseInt(idStr);
        
        MedicineDAO dao = new MedicineDAO();
        if (dao.deleteMedicine(id)) {
            System.out.println("DeleteMedicineServlet: Deletion successful for ID: " + id);
            response.sendRedirect("admin.jsp?msg=Medicine Deleted Successfully");
        } else {
            System.out.println("DeleteMedicineServlet: Deletion failed for ID: " + id + ". Error: " + dao.getLastError());
            response.sendRedirect("admin.jsp?msg=Delete Failed: " + dao.getLastError());
        }
    }
}
