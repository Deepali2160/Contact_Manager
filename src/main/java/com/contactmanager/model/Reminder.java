package com.contactmanager.model;

import java.util.Date;

public class Reminder {
    private int id;
    private int userId;
    private String title;
    private String description;
    private Date reminderDate;
    private String priority;
    private String type;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getReminderDate() { return reminderDate; }
    public void setReminderDate(Date reminderDate) { this.reminderDate = reminderDate; }
    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
}