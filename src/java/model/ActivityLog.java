package model;

import java.util.Date;

public class ActivityLog {
    private int logId;
    private int userId;
    private String username;
    private String role;
    private String action;
    private String targetUrl;
    private Date logTime;

    public ActivityLog() {}

    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public String getTargetUrl() { return targetUrl; }
    public void setTargetUrl(String targetUrl) { this.targetUrl = targetUrl; }

    public Date getLogTime() { return logTime; }
    public void setLogTime(Date logTime) { this.logTime = logTime; }
}
