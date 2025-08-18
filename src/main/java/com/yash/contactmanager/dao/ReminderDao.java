package com.yash.contactmanager.dao;

import com.yash.contactmanager.model.Reminder;
import java.util.List;

public interface ReminderDao {
    public List<Reminder> getUpcomingReminders(int userId, int limit);
}

