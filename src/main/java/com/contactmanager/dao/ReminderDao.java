package com.contactmanager.dao;

import com.contactmanager.model.Reminder;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.contactmanager.util.DatabaseConnection;

public class ReminderDao {
    public List<Reminder> getUpcomingReminders(int userId, int limit) {
        List<Reminder> reminders = new ArrayList<>();
        String sql = "SELECT * FROM reminders WHERE user_id = ? AND reminder_date > NOW() ORDER BY reminder_date ASC LIMIT ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, limit);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Reminder reminder = new Reminder();
                reminder.setId(rs.getInt("id"));
                reminder.setUserId(rs.getInt("user_id"));
                reminder.setTitle(rs.getString("title"));
                reminder.setDescription(rs.getString("description"));
                reminder.setReminderDate(rs.getTimestamp("reminder_date"));
                reminder.setPriority(rs.getString("priority"));
                reminder.setType(rs.getString("type"));
                reminders.add(reminder);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reminders;
    }

}