package com.example.publicwifi.model;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class History {
    private int historyId;
    private String latitude;
    private String longitude;
    private LocalDateTime createdAt;

    public void setHistoryId(int historyId) {
        this.historyId = historyId;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public int getHistoryId() {
        return historyId;
    }

    public String getLatitude() {
        return latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
}
