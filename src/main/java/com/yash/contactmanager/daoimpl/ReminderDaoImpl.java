package com.yash.contactmanager.daoimpl;

import com.yash.contactmanager.dao.ReminderDao;
import com.yash.contactmanager.model.Reminder;
import com.yash.contactmanager.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReminderDaoImpl implements ReminderDao {
    @Override
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
