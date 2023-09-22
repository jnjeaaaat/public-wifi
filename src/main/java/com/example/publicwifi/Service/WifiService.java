package com.example.publicwifi.Service;

import com.example.publicwifi.JsonManager;
import com.example.publicwifi.model.PublicWifi;
import lombok.NoArgsConstructor;
import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.*;

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
//        System.out.println(row.length());
        dataService = new DataService();
//        publicWifi.setManageNum(row.getJSONObject(1).getString("X_SWIFI_MGR_NO"));
//        publicWifi.setLocation(row.getJSONObject(1).getString("X_SWIFI_WRDOFC"));
//        publicWifi.setName(row.getJSONObject(1).getString("X_SWIFI_MAIN_NM"));//v
//        publicWifi.setRoadAddress(row.getJSONObject(1).getString("X_SWIFI_ADRES1"));//v
//        publicWifi.setDetailAddress(row.getJSONObject(1).getString("X_SWIFI_ADRES2"));//v
//        publicWifi.setLayer(row.getJSONObject(1).getString("X_SWIFI_INSTL_FLOOR"));//v
//        publicWifi.setCategory(row.getJSONObject(1).getString("X_SWIFI_INSTL_TY"));//v
//        publicWifi.setAgency(row.getJSONObject(1).getString("X_SWIFI_INSTL_MBY"));//v
//        publicWifi.setDivision(row.getJSONObject(1).getString("X_SWIFI_SVC_SE"));//v
//        publicWifi.setWebType(row.getJSONObject(1).getString("X_SWIFI_CMCWR"));//v
//        publicWifi.setInstallYear(row.getJSONObject(1).getString("X_SWIFI_CNSTC_YEAR"));//v
//        publicWifi.setInOut(row.getJSONObject(1).getString("X_SWIFI_INOUT_DOOR"));//v
//        publicWifi.setEnvironment(row.getJSONObject(1).getString("X_SWIFI_REMARS3"));//v
//        publicWifi.setLatitude(row.getJSONObject(1).getString("LAT"));//v
//        publicWifi.setLongitude(row.getJSONObject(1).getString("LNT"));//v
//
//        dataService.addWifiData(publicWifi);
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

}
