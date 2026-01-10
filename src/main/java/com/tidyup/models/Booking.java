package com.tidyup.models;

import java.util.UUID;

public class Booking {
    private String id;
    private String customerName;
    private String serviceName;
    private String status;
    private double price;
    private String date;
    private String time;
    private String address;

    // --- NEW FIELD ADDED HERE ---
    private boolean reviewed = false;

    // CONSTRUCTOR 1: For Admin (Price based)
    public Booking(String customerName, String serviceName, double price) {
        this.id = UUID.randomUUID().toString();
        this.customerName = customerName;
        this.serviceName = serviceName;
        this.price = price;
        this.status = "Pending";
        this.date = "-";
        this.time = "-";
        this.address = "-";
        this.reviewed = false; // Default is false
    }

    // CONSTRUCTOR 2: For Customers (Date/Time based)
    public Booking(String customerName, String serviceName, String date, String time, String address, String status) {
        this.id = UUID.randomUUID().toString();
        this.customerName = customerName;
        this.serviceName = serviceName;
        this.date = date;
        this.time = time;
        this.address = address;
        this.status = status;
        this.price = 0.0;
        this.reviewed = false; // Default is false
    }

    // --- GETTERS & SETTERS ---
    public String getId() { return id; }
    public String getCustomerName() { return customerName; }
    public String getServiceName() { return serviceName; }
    public String getStatus() { return status; }
    public double getPrice() { return price; }
    public String getDate() { return date; }
    public String getTime() { return time; }
    public String getAddress() { return address; }

    public void setStatus(String status) { this.status = status; }

    // --- NEW METHODS ADDED HERE ---
    public boolean isReviewed() { return reviewed; }
    public void setReviewed(boolean reviewed) { this.reviewed = reviewed; }
}