package com.tidyup.models;

public class Booking {
    private String id;
    private String customerName;
    private String serviceName;
    private double price;
    private String status;

    // This constructor fixes the "required: no arguments" error
    public Booking(String customerName, String serviceName, double price) {
        this.customerName = customerName;
        this.serviceName = serviceName;
        this.price = price;
        this.status = "Pending";
        this.id = String.valueOf(System.currentTimeMillis());
    }

    public String getId() { return id; }
    public String getCustomerName() { return customerName; }
    public String getServiceName() { return serviceName; }
    public double getPrice() { return price; }
    public String getStatus() { return status; }

    public void setStatus(String status) {
        this.status = status;
    }
}