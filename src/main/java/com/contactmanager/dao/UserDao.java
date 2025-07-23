package com.contactmanager.dao;

import com.contactmanager.model.User;
import com.contactmanager.util.DatabaseConnection;
import com.contactmanager.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

    private Connection conn;

    public UserDao() {
        conn = DatabaseConnection.getConnection();
    }

    // REGISTER USER (password hashed here)
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users(name, email, password, phone, profile_pic, about) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());

            // Hash password before storing
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
            ps.setString(3, hashedPassword);

            ps.setString(4, user.getPhone());
            ps.setString(5, user.getProfilePic());
            ps.setString(6, user.getAbout());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // LOGIN USER (compare hashed password)
    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");
                String enteredHashedPassword = PasswordUtil.hashPassword(password);

                System.out.println("Stored Hash: " + storedHashedPassword);
                System.out.println("Entered Hash: " + enteredHashedPassword);

                if (storedHashedPassword.equals(enteredHashedPassword)) {
                    // Password matched
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setProfilePic(rs.getString("profile_pic"));
                    user.setAbout(rs.getString("about"));

                    return user;
                } else {
                    System.out.println("Password mismatch.");
                }
            } else {
                System.out.println("No user found with email: " + email);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;  // Login failed
    }


    // CHECK IF EMAIL EXISTS
    public boolean isEmailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}