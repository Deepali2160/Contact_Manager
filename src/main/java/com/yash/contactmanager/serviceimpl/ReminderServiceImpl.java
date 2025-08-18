package com.yash.contactmanager.serviceimpl;

import com.yash.contactmanager.dao.ReminderDao;
import com.yash.contactmanager.daoimpl.ReminderDaoImpl;
import com.yash.contactmanager.model.Reminder;
import com.yash.contactmanager.service.ReminderService;

import java.util.List;

public class ReminderServiceImpl implements ReminderService {
private ReminderDao reminderDao;
public ReminderServiceImpl()
{
    this.reminderDao=new ReminderDaoImpl();
}
    @Override
    public List<Reminder> getUpcomingReminders(int userId, int limit) {
        return reminderDao.getUpcomingReminders(userId, limit);
    }
}
