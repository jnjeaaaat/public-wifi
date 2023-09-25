package com.example.publicwifi.Service;

import com.example.publicwifi.DBConnection;
import com.example.publicwifi.JsonManager;
import com.example.publicwifi.model.PublicWifi;
import lombok.NoArgsConstructor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

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
}
