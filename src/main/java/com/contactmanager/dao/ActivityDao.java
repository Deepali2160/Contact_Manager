package com.contactmanager.dao;

import com.contactmanager.model.Activity;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.contactmanager.util.DatabaseConnection;

public class ActivityDao {
    public List<Activity> getRecentActivities(int userId, int limit) {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT * FROM activities WHERE user_id = ? ORDER BY activity_date DESC LIMIT ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, limit);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Activity activity = new Activity();
                activity.setId(rs.getInt("id"));
                activity.setUserId(rs.getInt("user_id"));
                activity.setActionType(rs.getString("action_type"));
                activity.setDescription(rs.getString("description"));
                activity.setActivityDate(rs.getTimestamp("activity_date"));
                activities.add(activity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activities;
    }
}