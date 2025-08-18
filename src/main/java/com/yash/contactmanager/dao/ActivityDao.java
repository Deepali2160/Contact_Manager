package com.yash.contactmanager.dao;

import com.yash.contactmanager.model.Activity;
import java.util.List;


public interface ActivityDao {
    public List<Activity> getRecentActivities(int userId, int limit);
}

