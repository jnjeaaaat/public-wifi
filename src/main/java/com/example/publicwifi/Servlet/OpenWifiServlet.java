package com.example.publicwifi.Servlet;

import com.example.publicwifi.DBConnection;
import com.example.publicwifi.JsonManager;
import com.example.publicwifi.Service.DataService;
import com.example.publicwifi.Service.WifiService;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.example.publicwifi.secret.Secret.WIFI_KEY;

@WebServlet("/load-wifi")
public class OpenWifiServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
    private WifiService wifiService;
    private JsonManager jsonManager;
    private DataService dataService;

    public OpenWifiServlet(WifiService wifiService, JsonManager jsonManager, DataService dataService) {
        this.wifiService = wifiService;
        this.jsonManager = jsonManager;
        this.dataService = dataService;
    }

    public OpenWifiServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /*URL*/
        urlBuilder.append("/" +  URLEncoder.encode(WIFI_KEY,"UTF-8") ); /*인증키 (sample사용시에는 호출시 제한됩니다.)*/
        urlBuilder.append("/" +  URLEncoder.encode("json","UTF-8") ); /*요청파일타입 (xml,xmlf,xls,json) */
        urlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo","UTF-8")); /*서비스명 (대소문자 구분 필수입니다.)*/
        urlBuilder.append("/" + URLEncoder.encode("1","UTF-8")); /*요청시작위치 (sample인증키 사용시 5이내 숫자)*/
        urlBuilder.append("/" + URLEncoder.encode("2","UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
        // 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.


        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        conn.setDoOutput(true);
        System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다.*/
        BufferedReader rd;

        // 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        System.out.println(rd);
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }

        // 전체 WIFI 개수 추출
        jsonManager = new JsonManager();
        int totalCount = jsonManager.getTotalWifiCount(sb.toString());

        System.out.println(totalCount);
        int idx = 0;

        wifiService = new WifiService();
        dataService = new DataService();

        dataService.createWifiListTable();

        while (idx <= totalCount) {
            System.out.println("start : " + idx + ", " + "end : " + (idx+999 <= totalCount ? idx + 999 : totalCount));
            StringBuilder newUrlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /*URL*/
            newUrlBuilder.append("/" +  URLEncoder.encode(WIFI_KEY,"UTF-8") ); /*인증키 (sample사용시에는 호출시 제한됩니다.)*/
            newUrlBuilder.append("/" +  URLEncoder.encode("json","UTF-8") ); /*요청파일타입 (xml,xmlf,xls,json) */
            newUrlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo","UTF-8")); /*서비스명 (대소문자 구분 필수입니다.)*/
            newUrlBuilder.append("/" + URLEncoder.encode(String.valueOf(idx),"UTF-8")); /*요청시작위치 (sample인증키 사용시 5이내 숫자)*/
            if (idx+999 <= totalCount) {
                newUrlBuilder.append("/" + URLEncoder.encode(String.valueOf(idx+999),"UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
            } else {
                newUrlBuilder.append("/" + URLEncoder.encode(String.valueOf(totalCount),"UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
            }

//            System.out.println("worked");
            url = new URL(newUrlBuilder.toString());
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            conn.setDoOutput(true);

            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

//            System.out.println("worked2");
            StringBuilder sb2 = new StringBuilder();
            String newline;
            while ((newline = rd.readLine()) != null) {
                sb2.append(newline);
            }

            wifiService.addWifiData(sb2.toString());
            idx += 1000;
        }

        System.out.println(totalCount);

        rd.close();
        conn.disconnect();

        // Hello
//        PrintWriter out = response.getWriter();
//        out.println("<html><body>");
//        out.println("<p>" + jsonManager.convertToJson(sb.toString()) + "</p>");
//        out.println("</body></html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}