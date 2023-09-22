package com.example.publicwifi.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Setter
@Getter
public class PublicWifi {
    private long wifiId;
    private String manageNum;
    private String location;
    private String name;
    private String roadAddress;
    private String detailAddress;
    private String layer;
    private String category;
    private String agency;
    private String division;
    private String webType;
    private String installYear;
    private String inOut;
    private String environment;
    private String latitude;
    private String longitude;
    private LocalDateTime createdAt;

    public void setManageNum(String manageNum) {
        this.manageNum = manageNum;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setRoadAddress(String roadAddress) {
        this.roadAddress = roadAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
    }

    public void setLayer(String layer) {
        this.layer = layer;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setAgency(String agency) {
        this.agency = agency;
    }

    public void setDivision(String division) {
        this.division = division;
    }

    public void setWebType(String webType) {
        this.webType = webType;
    }

    public void setInstallYear(String installYear) {
        this.installYear = installYear;
    }

    public void setInOut(String inOut) {
        this.inOut = inOut;
    }

    public void setEnvironment(String environment) {
        this.environment = environment;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public long getWifiId() {
        return wifiId;
    }

    public String getManageNum() {
        return manageNum;
    }

    public String getLocation() {
        return location;
    }

    public String getName() {
        return name;
    }

    public String getRoadAddress() {
        return roadAddress;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public String getLayer() {
        return layer;
    }

    public String getCategory() {
        return category;
    }

    public String getAgency() {
        return agency;
    }

    public String getDivision() {
        return division;
    }

    public String getWebType() {
        return webType;
    }

    public String getInstallYear() {
        return installYear;
    }

    public String getInOut() {
        return inOut;
    }

    public String getEnvironment() {
        return environment;
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
