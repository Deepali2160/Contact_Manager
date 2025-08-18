package com.yash.contactmanager.daoimpl;

import com.yash.contactmanager.dao.ActivityDao;
import com.yash.contactmanager.model.Activity;
import com.yash.contactmanager.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ActivityDaoImpl implements ActivityDao {

    @Override
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
