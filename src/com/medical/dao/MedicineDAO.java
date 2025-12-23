package com.medical.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.medical.model.Medicine;

public class MedicineDAO {
    private String lastError;

    public String getLastError() {
        return lastError;
    }

    // Add medicine (Admin)
    public boolean addMedicine(Medicine med) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO medicines(name,price,stock,description) VALUES (?,?,?,?)"
            );

            ps.setString(1, med.getName());
            ps.setDouble(2, med.getPrice());
            ps.setInt(3, med.getStock());
            ps.setString(4, med.getDescription());

            ps.executeUpdate();
            status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public Medicine getMedicineById(int id) {
        Medicine m = null;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM medicines WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                m = new Medicine();
                m.setId(rs.getInt("id"));
                m.setName(rs.getString("name"));
                m.setPrice(rs.getDouble("price"));
                m.setStock(rs.getInt("stock"));
                m.setDescription(rs.getString("description"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return m;
    }

    // View all medicines (User)
    public ArrayList<Medicine> getAllMedicines() {
        ArrayList<Medicine> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM medicines WHERE is_active = 1"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Medicine m = new Medicine();
                m.setId(rs.getInt("id"));
                m.setName(rs.getString("name"));
                m.setPrice(rs.getDouble("price"));
                m.setStock(rs.getInt("stock"));
                m.setDescription(rs.getString("description"));

                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delete medicine (Admin)
    public boolean deleteMedicine(int id) {
        System.out.println("MedicineDAO: Attempting to soft delete medicine ID: " + id);
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("MedicineDAO: DB Connection is NULL!");
                lastError = "Database connection failed";
                return false;
            }
            PreparedStatement ps = con.prepareStatement("UPDATE medicines SET is_active = 0 WHERE id = ?");
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            System.out.println("MedicineDAO: Rows affected: " + rows);
            status = (rows > 0);
            if (!status) {
                lastError = "No medicine found with ID: " + id;
            }
        } catch (Exception e) {
            System.out.println("MedicineDAO: Exception occurred: " + e.getMessage());
            lastError = e.getMessage();
            e.printStackTrace();
        }
        return status;
    }

    // Update medicine (Admin)
    public boolean updateMedicine(Medicine med) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE medicines SET name=?, price=?, stock=?, description=? WHERE id=?"
            );
            ps.setString(1, med.getName());
            ps.setDouble(2, med.getPrice());
            ps.setInt(3, med.getStock());
            ps.setString(4, med.getDescription());
            ps.setInt(5, med.getId());
            ps.executeUpdate();
            status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
