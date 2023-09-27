package com.example.publicwifi.Service;

import com.example.publicwifi.JsonManager;
import com.example.publicwifi.model.PublicWifi;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class WifiService{

    private JsonManager jsonManager;
    private DataService dataService;
    private Connection conn;
    private PreparedStatement ps;

    public WifiService(JsonManager jsonManager, DataService dataService, Connection conn, PreparedStatement ps) {
        this.jsonManager = jsonManager;
        this.dataService = dataService;
        this.conn = conn;
        this.ps = ps;
    }

    public WifiService(){}

    public void addWifiData(String jsonString) {
        jsonManager = new JsonManager();
        JSONObject jsonObject = jsonManager.convertToJson(jsonString);
        JSONObject TbPublicWifiInfo = jsonObject.getJSONObject("TbPublicWifiInfo");
        JSONArray row = TbPublicWifiInfo.getJSONArray("row");

        PublicWifi publicWifi = new PublicWifi();
        dataService = new DataService();
        for (int i = 0; i < row.length(); i++) {
            publicWifi.setManageNum(row.getJSONObject(i).getString("X_SWIFI_MGR_NO"));
            publicWifi.setLocation(row.getJSONObject(i).getString("X_SWIFI_WRDOFC"));
            publicWifi.setName(row.getJSONObject(i).getString("X_SWIFI_MAIN_NM"));//v
            publicWifi.setRoadAddress(row.getJSONObject(i).getString("X_SWIFI_ADRES1"));//v
            publicWifi.setDetailAddress(row.getJSONObject(i).getString("X_SWIFI_ADRES2"));//v
            publicWifi.setLayer(row.getJSONObject(i).getString("X_SWIFI_INSTL_FLOOR"));//v
            publicWifi.setCategory(row.getJSONObject(i).getString("X_SWIFI_INSTL_TY"));//v
            publicWifi.setAgency(row.getJSONObject(i).getString("X_SWIFI_INSTL_MBY"));//v
            publicWifi.setDivision(row.getJSONObject(i).getString("X_SWIFI_SVC_SE"));//v
            publicWifi.setWebType(row.getJSONObject(i).getString("X_SWIFI_CMCWR"));//v
            publicWifi.setInstallYear(row.getJSONObject(i).getString("X_SWIFI_CNSTC_YEAR"));//v
            publicWifi.setInOut(row.getJSONObject(i).getString("X_SWIFI_INOUT_DOOR"));//v
            publicWifi.setEnvironment(row.getJSONObject(i).getString("X_SWIFI_REMARS3"));//v
            publicWifi.setLatitude(row.getJSONObject(i).getString("LAT"));//v
            publicWifi.setLongitude(row.getJSONObject(i).getString("LNT"));//v

            dataService.addWifiData(publicWifi);
        }
    }

    public List<PublicWifi> getWifiList(double latitude, double longitude) {
        dataService = new DataService();
        List<PublicWifi> allWifiList = dataService.getWifiList(latitude, longitude);
        List<PublicWifi> twentyWifiList = new ArrayList<>();
        System.out.println("총 개수: " + allWifiList.size());
        allWifiList.sort(new Comparator<PublicWifi>() {
            @Override
            public int compare(PublicWifi o1, PublicWifi o2) {
                double distance1 = o1.getDistance();
                double distance2 = o2.getDistance();

                return Double.compare(distance1, distance2);
            }
        });

        for (int i = 0; i < 20; i++) {
            twentyWifiList.add(allWifiList.get(i));
        }

        return twentyWifiList;
    }

}
