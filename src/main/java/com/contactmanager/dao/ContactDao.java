package com.contactmanager.dao;

import com.contactmanager.model.Contact;
import com.contactmanager.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class ContactDao {

    private Connection conn;

    public ContactDao() {
        conn = DatabaseConnection.getConnection();
    }

    // 1️⃣ ADD CONTACT
    public boolean addContact(Contact contact) {
        String sql = "INSERT INTO contacts(user_id, name, email, phone, address, category, photo_path, notes, birthday, anniversary) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, contact.getUserId());
            ps.setString(2, contact.getName());
            ps.setString(3, contact.getEmail());
            ps.setString(4, contact.getPhone());
            ps.setString(5, contact.getAddress());
            ps.setString(6, contact.getCategory());
            ps.setString(7, contact.getPhotoPath());
            ps.setString(8, contact.getNotes());
            ps.setDate(9, contact.getBirthday() != null ? new java.sql.Date(contact.getBirthday().getTime()) : null);
            ps.setDate(10, contact.getAnniversary() != null ? new java.sql.Date(contact.getAnniversary().getTime()) : null);

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2️⃣ GET CONTACTS BY USER ID
    public List<Contact> getContactsByUserId(int userId) {
        List<Contact> contacts = new ArrayList<>();
        String sql = "SELECT * FROM contacts WHERE user_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                contacts.add(populateContactFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return contacts;
    }

    // 3️⃣ GET CONTACT BY ID
    public Contact getContactById(int contactId) {
        String sql = "SELECT * FROM contacts WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, contactId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return populateContactFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // 4️⃣ UPDATE CONTACT
    public boolean updateContact(Contact contact) {
        String sql = "UPDATE contacts SET name = ?, email = ?, phone = ?, address = ?, category = ?, photo_path = ?, notes = ?, birthday = ?, anniversary = ? WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, contact.getName());
            ps.setString(2, contact.getEmail());
            ps.setString(3, contact.getPhone());
            ps.setString(4, contact.getAddress());
            ps.setString(5, contact.getCategory());
            ps.setString(6, contact.getPhotoPath());
            ps.setString(7, contact.getNotes());
            ps.setDate(8, contact.getBirthday() != null ? new java.sql.Date(contact.getBirthday().getTime()) : null);
            ps.setDate(9, contact.getAnniversary() != null ? new java.sql.Date(contact.getAnniversary().getTime()) : null);
            ps.setInt(10, contact.getId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5️⃣ DELETE CONTACT
    public boolean deleteContact(int contactId) {
        String sql = "DELETE FROM contacts WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, contactId);
            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 6️⃣ UPCOMING REMINDERS (Birthday / Anniversary in next 7 days)
    public List<Contact> getUpcomingReminders(int userId) {
        List<Contact> reminders = new ArrayList<>();
        String sql = "SELECT * FROM contacts WHERE user_id = ? AND (" +
                "(birthday IS NOT NULL AND DATE_FORMAT(birthday, '%m-%d') BETWEEN DATE_FORMAT(CURDATE(), '%m-%d') AND DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL 7 DAY), '%m-%d'))" +
                " OR " +
                "(anniversary IS NOT NULL AND DATE_FORMAT(anniversary, '%m-%d') BETWEEN DATE_FORMAT(CURDATE(), '%m-%d') AND DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL 7 DAY), '%m-%d'))" +
                ")";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                reminders.add(populateContactFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reminders;
    }

    // ♻️ Reusable method to populate Contact from ResultSet
    private Contact populateContactFromResultSet(ResultSet rs) throws SQLException {
        Contact contact = new Contact();
        contact.setId(rs.getInt("id"));
        contact.setUserId(rs.getInt("user_id"));
        contact.setName(rs.getString("name"));
        contact.setEmail(rs.getString("email"));
        contact.setPhone(rs.getString("phone"));
        contact.setAddress(rs.getString("address"));
        contact.setCategory(rs.getString("category"));
        contact.setPhotoPath(rs.getString("photo_path"));
        contact.setNotes(rs.getString("notes"));
        contact.setBirthday(rs.getDate("birthday"));
        contact.setAnniversary(rs.getDate("anniversary"));
        return contact;
    }
    // 7️⃣ DELETE MULTIPLE CONTACTS
    public boolean deleteMultipleContacts(List<Integer> contactIds) {
        if (contactIds == null || contactIds.isEmpty()) {
            return false;
        }

        // Create comma-separated list of IDs for IN clause
        String ids = contactIds.stream()
                .map(String::valueOf)
                .reduce((a, b) -> a + "," + b)
                .orElse("");

        String sql = "DELETE FROM contacts WHERE id IN (" + ids + ")";

        try (Statement stmt = conn.createStatement()) {
            int rowsDeleted = stmt.executeUpdate(sql);
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 8️⃣ GET MULTIPLE CONTACTS BY IDS
    public List<Contact> getContactsByIds(List<Integer> contactIds) {
        List<Contact> contacts = new ArrayList<>();
        if (contactIds == null || contactIds.isEmpty()) {
            return contacts;
        }

        // Create comma-separated list of IDs for IN clause
        String ids = contactIds.stream()
                .map(String::valueOf)
                .reduce((a, b) -> a + "," + b)
                .orElse("");

        String sql = "SELECT * FROM contacts WHERE id IN (" + ids + ")";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                contacts.add(populateContactFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return contacts;
    }
    // Add this method to your ContactDao class
    public List<Contact> getContactsByUserIdSorted(int userId, String sortBy, String sortOrder) {
        List<Contact> contacts = new ArrayList<>();

        // Base query
        String sql = "SELECT * FROM contacts WHERE user_id = ?";

        // Add sorting
        switch(sortBy) {
            case "name":
                sql += " ORDER BY name " + sortOrder;
                break;
            case "added":
                sql += " ORDER BY created_at " + sortOrder;
                break;
            case "modified":
                // Need to add updated_at column first
                sql += " ORDER BY created_at " + sortOrder; // Temporary until we add updated_at
                break;
            case "birthday":
                sql += " ORDER BY birthday " + sortOrder;
                break;
            default:
                sql += " ORDER BY name ASC";
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                contacts.add(populateContactFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contacts;
    }
    // Add these methods to your ContactDao class
    public int getContactCountByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM contacts WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getFavoriteCountByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM contacts WHERE user_id = ? AND is_favorite = TRUE";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Contact> getRecentContacts(int userId, int limit) {
        List<Contact> contacts = new ArrayList<>();
        String sql = "SELECT * FROM contacts WHERE user_id = ? ORDER BY created_at DESC LIMIT ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, limit);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Contact contact = new Contact();
                contact.setId(rs.getInt("id"));
                contact.setUserId(rs.getInt("user_id"));
                contact.setName(rs.getString("name"));
                contact.setEmail(rs.getString("email"));
                contact.setPhone(rs.getString("phone"));
                contact.setAddress(rs.getString("address"));
                contact.setCategory(rs.getString("category"));
                contact.setPhotoPath(rs.getString("photo_path"));
                contact.setNotes(rs.getString("notes"));
                contact.setBirthday(rs.getDate("birthday"));
                contact.setAnniversary(rs.getDate("anniversary"));
                contact.setCreatedAt(rs.getTimestamp("created_at"));
                contact.setFavorite(rs.getBoolean("is_favorite"));
                contacts.add(contact);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contacts;
    }

}