package com.yash.contactmanager.service;

import com.yash.contactmanager.model.Reminder;

import java.util.List;

public interface ReminderService {
    public List<Reminder> getUpcomingReminders(int userId, int limit);
}
