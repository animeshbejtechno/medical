package com.medical.model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private int medicineId;
    private int quantity;
    private double totalPrice;
    private Timestamp orderDate;
    private String status;
    private String paymentStatus;
    private Timestamp estimatedDelivery;
    
    // Additional fields for display
    private String medicineName;
    private String userName;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getMedicineId() { return medicineId; }
    public void setMedicineId(int medicineId) { this.medicineId = medicineId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public Timestamp getEstimatedDelivery() { return estimatedDelivery; }
    public void setEstimatedDelivery(Timestamp estimatedDelivery) { this.estimatedDelivery = estimatedDelivery; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
}
