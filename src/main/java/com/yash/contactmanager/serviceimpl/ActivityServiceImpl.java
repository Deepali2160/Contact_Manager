package com.yash.contactmanager.serviceimpl;

import com.yash.contactmanager.dao.ActivityDao;
import com.yash.contactmanager.daoimpl.ActivityDaoImpl;
import com.yash.contactmanager.model.Activity;
import com.yash.contactmanager.service.ActivityService;

import java.util.List;

public class ActivityServiceImpl implements ActivityService {

    private ActivityDao activityDao;
    public ActivityServiceImpl()
    {
        this.activityDao = new ActivityDaoImpl();
    }
    @Override
    public List<Activity> getRecentActivities(int userId, int limit) {
        return activityDao.getRecentActivities(userId, limit);
    }
}
