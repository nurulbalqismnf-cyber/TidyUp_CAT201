package com.tidyup.models;

public class Review {
    private String customerName;
    private int rating; // 1 to 5 stars
    private String message;
    private String date;

    public Review(String name, int rating, String comment, String date) {
        this.customerName = name;
        this.rating = rating;
        this.message = comment;
        this.date = date;
    }

    // Getters
    public String getCustomerName() { return customerName; }
    public int getRating() { return rating; }
    public String getMessage() { return message; }
    public String getDate() { return date; }
}