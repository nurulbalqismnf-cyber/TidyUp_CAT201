package com.tidyup.models;

public class Booking {
    private String id;
    private String customerName;
    private String serviceName;
    private double price;
    private String status;
    private String date;
    private String time;
    private String address;

    // This constructor fixes the "required: no arguments" error
    public Booking(String customerName, String serviceName, double price) {
        this.customerName = customerName;
        this.serviceName = serviceName;
        this.price = price;
        this.status = "Pending";
        this.id = String.valueOf(System.currentTimeMillis());
    }

    public Booking(String customerName, String serviceName, String date, String time, String address, String status) {
        this.id = String.valueOf(System.currentTimeMillis());
        this.customerName = customerName;
        this.serviceName = serviceName;
        this.date = date;
        this.time = time;
        this.address = address;
        this.status = status;
        this.price = 0.0; // Customers don't set price
    }

    public String getId() { return id; }
    public String getCustomerName() { return customerName; }
    public String getServiceName() { return serviceName; }
    public double getPrice() { return price; }
    public String getStatus() { return status; }
    public String getDate() { return date; }
    public String getTime() { return time; }
    public String getAddress() { return address; }

    public void setStatus(String status) {
        this.status = status;
    }
}