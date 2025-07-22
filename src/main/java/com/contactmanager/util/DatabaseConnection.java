package com.contactmanager.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/contactdb";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";

    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection != null) {
            return connection;
        }


        try {
            System.out.println("Attempting database connection to: " + URL);

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            System.out.println("Database connection successful!");

        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
            throw new RuntimeException("Driver loading failed!");
        } catch (SQLException e) {
            System.out.println("Database connection failed.");
            e.printStackTrace();
            throw new RuntimeException("Database connection failed!");
        }

        return connection;
    }

}
