package model;

import java.util.Date;

public class CheckInHistory {

    private int checkinId;
    private int memberId;
    private Date checkinTime;

    public CheckInHistory() {
    }

    public CheckInHistory(int checkinId, int memberId, Date checkinTime) {
        this.checkinId = checkinId;
        this.memberId = memberId;
        this.checkinTime = checkinTime;
    }

    public int getCheckinId() {
        return checkinId;
    }

    public void setCheckinId(int checkinId) {
        this.checkinId = checkinId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public Date getCheckinTime() {
        return checkinTime;
    }

    public void setCheckinTime(Date checkinTime) {
        this.checkinTime = checkinTime;
    }
}
