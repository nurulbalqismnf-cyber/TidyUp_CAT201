package com.tidyup.models;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class DataStore {
    private static DataStore instance;
    private List<Service> services;
    private List<Booking> bookings;
    private List<Review> reviews; // Declared at the top with other lists
    private List<User> users;

    // Admin Credentials
    private String adminUsername;
    private String adminPassword;

    // File path to save the password
    private final String FILE_PATH = System.getProperty("user.home") + File.separator + "tidyup_config.txt";

    private DataStore() {
        services = new ArrayList<>();
        bookings = new ArrayList<>();
        reviews = new ArrayList<>(); // Initialize the review list
        users = new ArrayList<>();

        // 1. Try to load saved password from file
        if (!loadCredentials()) {
            // 2. If no file exists, use default
            this.adminUsername = "admin";
            this.adminPassword = "admin123";
        }

        // Dummy Service Data
        services.add(new Service("1", "Standard Cleaning", 100.0, "Basic cleaning package"));
        services.add(new Service("2", "Deep Cleaning", 250.0, "Thorough cleaning package"));

        // Dummy Review Data - Placed inside the main constructor to avoid duplicates
        reviews.add(new Review("Farah Ummairah", 5, "Amazing service!", "2026-01-04"));
        reviews.add(new Review("Shakira Insyirah", 4, "Good, but slightly late.", "2026-01-03"));

        //test data
        users.add(new User("Farah123", "123", "customer"));
        users.add(new User("Shakira123", "122", "customer"));
        users.add(new User("Rabiatul123", "123", "customer"));
    }

    public static synchronized DataStore getInstance() {
        if (instance == null) {
            instance = new DataStore();
        }
        return instance;
    }

    // --- UNIFIED LOGIN METHOD ---
    // This tells LoginServlet if it's the Admin or a Customer
    public String checkLogin(String user, String pass) {
        // 1. Check Admin
        if (adminUsername.equals(user) && adminPassword.equals(pass)) {
            return "admin";
        }
        // 2. Check Customers
        for (User u : users) {
            if (u.getUsername().equals(user) && u.getPassword().equals(pass)) {
                return "customer";
            }
        }
        return null; // Failed
    }


    // --- FILE SAVING METHODS ---

    private void saveCredentials() {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH))) {
            out.println(adminUsername);
            out.println(adminPassword);
            System.out.println("Password saved to: " + FILE_PATH);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private boolean loadCredentials() {
        File file = new File(FILE_PATH);
        if (!file.exists()) return false;

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            this.adminUsername = br.readLine();
            this.adminPassword = br.readLine();
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    // --- AUTHENTICATION METHODS ---

    public boolean validateLogin(String user, String pass) {
        return adminUsername.equals(user) && adminPassword.equals(pass);
    }

    public boolean changePassword(String oldPass, String newPass) {
        if (adminPassword.equals(oldPass)) {
            this.adminPassword = newPass;
            saveCredentials();
            return true;
        }
        return false;
    }

    // --- SERVICE METHODS ---
    public List<Service> getServices() { return services; }
    public void addService(Service s) { services.add(s); }
    public void deleteService(String id) { services.removeIf(s -> s.getId().equals(id)); }
    public Service getServiceById(String id) {
        for (Service s : services) if (s.getId().equals(id)) return s;
        return null;
    }
    public void updateService(Service u) {
        for (int i=0; i<services.size(); i++)
            if (services.get(i).getId().equals(u.getId())) services.set(i, u);
    }

    // --- BOOKING METHODS ---
    public List<Booking> getBookings() { return bookings; }
    public void addBooking(Booking b) { bookings.add(b); }
    public void updateBookingStatus(String id, String s) {
        for (Booking b : bookings) if (b.getId().equals(id)) b.setStatus(s);
    }

    // --- NEW: Allow signing up ---
    public void addUser(User u) {
        this.users.add(u);
    }

    // --- REVIEW METHODS ---
    public List<Review> getReviews() { return reviews; }
    public void addReview(Review review) { reviews.add(review); }
}