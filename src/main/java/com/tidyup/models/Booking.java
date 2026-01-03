package com.tidyup.models;

import java.util.UUID;

public class Booking {
    private String id;
    private String customerName;
    private String serviceName;
    private double price;
    private String status;

    public Booking(String customerName, String serviceName, double price) {
        this.id = UUID.randomUUID().toString();
        this.customerName = customerName;
        this.serviceName = serviceName;
        this.price = price;
        this.status = "Pending";
    }

    public String getId() { return id; }
    public String getCustomerName() { return customerName; }
    public String getServiceName() { return serviceName; }
    public double getPrice() { return price; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}