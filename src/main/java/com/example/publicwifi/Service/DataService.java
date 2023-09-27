package com.example.publicwifi.Service;

import com.example.publicwifi.DBConnection;
import com.example.publicwifi.JsonManager;
import com.example.publicwifi.model.PublicWifi;
import lombok.NoArgsConstructor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DataService {
    private Connection conn;
    private PreparedStatement ps;

    public DataService(Connection conn, PreparedStatement ps) {
        this.conn = conn;
        this.ps = ps;
    }

    public DataService(){
        conn = DBConnection.getConnection();
    }

    public void createWifiListTable() {
        System.out.println("test");
        String dropQuery = "DROP TABLE wifiList";
        String createTableQuery = "CREATE TABLE wifiList ("
                + "wifiId        INTEGER   PRIMARY KEY AUTOINCREMENT,"
                + "manageNum     TEXT,"
                + "location      TEXT,"
                + "name          TEXT,"
                + "roadAddress   TEXT,"
                + "detailAddress TEXT,"
                + "layer         TEXT,"
                + "category      TEXT,"
                + "agency        TEXT,"
                + "division      TEXT,"
                + "webType       TEXT,"
                + "installYear   TEXT,"
                + "inOut         TEXT,"
                + "environment   TEXT,"
                + "latitude      TEXT,"
                + "longitude     TEXT,"
                + "createdAt     TIMESTAMP DEFAULT (CURRENT_TIMESTAMP))";

        try {
            Statement statement = conn.createStatement();
            statement.executeUpdate(dropQuery);

            statement = conn.createStatement();
            statement.executeUpdate(createTableQuery);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addWifiData(PublicWifi publicWifi){

        String insertQuery = "INSERT INTO wifiList(manageNum, location, name, roadAddress, detailAddress, layer, category, agency, division, webType, installYear, inOut, environment, latitude, longitude) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            ps = conn.prepareStatement(insertQuery);
            ps.setString(1, publicWifi.getManageNum());
            ps.setString(2, publicWifi.getLocation());
            ps.setString(3, publicWifi.getName());
            ps.setString(4, publicWifi.getRoadAddress());
            ps.setString(5, publicWifi.getDetailAddress());
            ps.setString(6, publicWifi.getLayer());
            ps.setString(7, publicWifi.getCategory());
            ps.setString(8, publicWifi.getAgency());
            ps.setString(9, publicWifi.getDivision());
            ps.setString(10, publicWifi.getWebType());
            ps.setString(11, publicWifi.getInstallYear());
            ps.setString(12, publicWifi.getInOut());
            ps.setString(13, publicWifi.getEnvironment());
            ps.setString(14, publicWifi.getLatitude());
            ps.setString(15, publicWifi.getLongitude());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public List<PublicWifi> getWifiList(double latitude, double longitude) {
        System.out.println("hello");
        List<PublicWifi> wifiList = new ArrayList<>();
        String getWifiListQuery = "select * from wifiList";

        try {
            ps = conn.prepareStatement(getWifiListQuery);

            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()) {
                PublicWifi wifi = new PublicWifi();

                double distance =
                        getDistance(latitude, Double.parseDouble(resultSet.getString("latitude")),
                                longitude, Double.parseDouble(resultSet.getString("longitude")));

                distance = Math.round(distance * 10000.0) / 10000.0;

                wifi.setWifiId(resultSet.getInt("wifiId"));
                wifi.setDistance(distance);
                wifi.setManageNum(resultSet.getString("manageNum"));
                wifi.setLocation(resultSet.getString("location"));
                wifi.setName(resultSet.getString("name"));
                wifi.setRoadAddress(resultSet.getString("roadAddress"));
                wifi.setDetailAddress(resultSet.getString("detailAddress"));
                wifi.setLayer(resultSet.getString("layer"));
                wifi.setCategory(resultSet.getString("category"));
                wifi.setAgency(resultSet.getString("agency"));
                wifi.setDivision(resultSet.getString("division"));
                wifi.setWebType(resultSet.getString("webType"));
                wifi.setInstallYear(resultSet.getString("installYear"));
                wifi.setInOut(resultSet.getString("inOut"));
                wifi.setEnvironment(resultSet.getString("environment"));
                wifi.setLatitude(resultSet.getString("latitude"));
                wifi.setLongitude(resultSet.getString("longitude"));
                wifi.setCreatedAt(resultSet.getTimestamp("createdAt").toLocalDateTime());
                wifiList.add(wifi);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return wifiList;
    }

    public double getDistance(double lat1, double lat2, double lon1, double lon2) {

//        double theta = Math.abs(lon1 - lon2);
//        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
//
//        dist = Math.acos(dist);
//        dist = rad2deg(dist);
//        dist = dist * 60 * 1.1515;
//        dist = dist * 1.609344;

        double dist = 0.0;

        dist = Math.sqrt(Math.pow(lat1-lat2, 2) + Math.pow(lon1-lon2, 2));
        return (dist);
    }


    // This function converts decimal degrees to radians
    public double deg2rad(double deg) {
        return (deg * Math.PI / 180.0);
    }

    // This function converts radians to decimal degrees
    public double rad2deg(double rad) {
        return (rad * 180 / Math.PI);
    }
}
