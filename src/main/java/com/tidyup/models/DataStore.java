package com.tidyup.models;

import java.util.ArrayList;
import java.util.List;

public class DataStore {
    private static DataStore instance;
    private List<Service> services;
    private List<Booking> bookings; // List to store orders

    private DataStore() {
        services = new ArrayList<>();
        bookings = new ArrayList<>(); // Initialize bookings list

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

    // --- SERVICE METHODS ---
    public List<Service> getServices() {
        return services;
    }

    public void addService(Service service) {
        services.add(service);
    }

    public void deleteService(String id) {
        services.removeIf(s -> s.getId().equals(id));
    }

    public Service getServiceById(String id) {
        for (Service s : services) {
            if (s.getId().equals(id)) {
                return s;
            }
        }
        return null;
    }

    public void updateService(Service updatedService) {
        for (int i = 0; i < services.size(); i++) {
            if (services.get(i).getId().equals(updatedService.getId())) {
                services.set(i, updatedService);
                return;
            }
        }
    }

    // --- BOOKING METHODS (The Bridge) ---
    public List<Booking> getBookings() {
        return bookings;
    }

    public void addBooking(Booking booking) {
        bookings.add(booking);
    }

    // THIS IS THE METHOD YOU WERE TRYING TO ADD
    public void updateBookingStatus(String id, String newStatus) {
        for (Booking b : bookings) {
            if (b.getId().equals(id)) {
                b.setStatus(newStatus);
                return;
            }
        }
    }
}
