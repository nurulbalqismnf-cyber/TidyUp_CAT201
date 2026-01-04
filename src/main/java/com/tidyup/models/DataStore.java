package com.tidyup.models;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class DataStore {
    private static DataStore instance;
    private List<Service> services;
    private List<Booking> bookings;

    // Admin Credentials
    private String adminUsername;
    private String adminPassword;

    // File path to save the password (e.g., C:\Users\You\tidyup_config.txt)
    private final String FILE_PATH = System.getProperty("user.home") + File.separator + "tidyup_config.txt";

    private DataStore() {
        services = new ArrayList<>();
        bookings = new ArrayList<>();

        // 1. Try to load saved password from file
        if (!loadCredentials()) {
            // 2. If no file exists, use default
            this.adminUsername = "admin";
            this.adminPassword = "admin123";
        }

        // Dummy Data
        services.add(new Service("1", "Standard Cleaning", 100.0, "Basic cleaning package"));
        services.add(new Service("2", "Deep Cleaning", 250.0, "Thorough cleaning package"));
    }

    public static synchronized DataStore getInstance() {
        if (instance == null) {
            instance = new DataStore();
        }
        return instance;
    }

    // --- FILE SAVING METHODS (The Magic Part) ---

    // Saves username/password to a text file
    private void saveCredentials() {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH))) {
            out.println(adminUsername);
            out.println(adminPassword);
            System.out.println("Password saved to: " + FILE_PATH);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Loads username/password from text file
    private boolean loadCredentials() {
        File file = new File(FILE_PATH);
        if (!file.exists()) return false; // File doesn't exist yet

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            this.adminUsername = br.readLine();
            this.adminPassword = br.readLine();
            return true; // Success
        } catch (IOException e) {
            return false; // Failed
        }
    }

    // --- AUTHENTICATION METHODS ---

    public boolean validateLogin(String user, String pass) {
        return adminUsername.equals(user) && adminPassword.equals(pass);
    }

    public boolean changePassword(String oldPass, String newPass) {
        if (adminPassword.equals(oldPass)) {
            this.adminPassword = newPass;
            saveCredentials(); // <--- NEW: Save to file immediately!
            return true;
        }
        return false;
    }

    // --- SERVICE & BOOKING METHODS (Unchanged) ---
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

    public List<Booking> getBookings() { return bookings; }
    public void addBooking(Booking b) { bookings.add(b); }
    public void updateBookingStatus(String id, String s) {
        for (Booking b : bookings) if (b.getId().equals(id)) b.setStatus(s);
    }
}