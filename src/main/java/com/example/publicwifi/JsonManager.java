package com.example.publicwifi;

import org.json.JSONObject;

public class JsonManager {

    public JSONObject convertToJson(String jsonString) {
        JSONObject jsonObject = new JSONObject(jsonString);
        return jsonObject;
    }

    public int getTotalWifiCount(String jsonString) {
        JSONObject jsonObject = new JSONObject(jsonString);
        JSONObject TbPublicWifiInfo = jsonObject.getJSONObject("TbPublicWifiInfo");
        int totalCount = TbPublicWifiInfo.getInt("list_total_count");

        return totalCount;
    }
}
