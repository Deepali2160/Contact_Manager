package com.yash.contactmanager.model;

import java.util.Date;

public class Activity {
    private int id;
    private int userId;
    private String actionType;
    private String description;
    private Date activityDate;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getActionType() { return actionType; }
    public void setActionType(String actionType) { this.actionType = actionType; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getActivityDate() { return activityDate; }
    public void setActivityDate(Date activityDate) { this.activityDate = activityDate; }
}