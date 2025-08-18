package com.yash.contactmanager.service;

import com.yash.contactmanager.model.Activity;

import java.util.List;

public interface ActivityService {
    public List<Activity> getRecentActivities(int userId, int limit);
}
