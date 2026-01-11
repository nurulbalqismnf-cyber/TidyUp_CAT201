package com.tidyup.models;

public class Service {
    private String id;
    private String name;
    private double price;
    private String description;

    public Service(String id, String name, double price, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
    }

    public String getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public String getDescription() { return description; }
    public void setName(String name) {this.name = name;}
    public void setPrice(double price) {this.price = price;}
    public void setDescription(String description) {this.description = description;}
}
