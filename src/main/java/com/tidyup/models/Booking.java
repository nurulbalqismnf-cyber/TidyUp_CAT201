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
    private String phoneNumber;
    private String paymentMethod;

    private boolean reviewed = false;

    // CONSTRUCTOR 1: For Admin
    public Booking(String customerName, String serviceName, double price) {
        this.id = UUID.randomUUID().toString();
        this.customerName = customerName;
        this.serviceName = serviceName;
        this.price = price;
        this.status = "Pending";
        this.date = "-";
        this.time = "-";
        this.address = "-";
        this.reviewed = false;
    }

    // CONSTRUCTOR 2: For Customers
    public Booking(String customerName, String phoneNumber, String serviceName, String date, String time, String address, String paymentMethod, String status) {
        this.id = java.util.UUID.randomUUID().toString();
        this.customerName = customerName;
        this.phoneNumber = phoneNumber;
        this.serviceName = serviceName;
        this.date = date;
        this.time = time;
        this.address = address;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.price = 0.0;
        this.reviewed = false;
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
    public String getPhoneNumber() { return phoneNumber; }
    public String getPaymentMethod() { return paymentMethod; }

    public void setStatus(String status) { this.status = status; }
    public void setPrice(double price) {this.price = price;}
    public boolean isReviewed() { return reviewed; }
    public void setReviewed(boolean reviewed) { this.reviewed = reviewed; }
}