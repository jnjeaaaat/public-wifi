<%@ page import="java.util.List" %>
<%@ page import="com.example.publicwifi.model.PublicWifi" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.publicwifi.Service.DataService" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.publicwifi.Service.WifiService" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 100%;}
        th { height: 50px; background-color: #04AA6D; color: white;}
        td { height: 35px; text-align: center; }
        tr:nth-child(odd) {background-color: #f2f2f2;}
        table, th, td { border: 1px solid lightgray; }
        div { margin-bottom: 10px; }
        /*form { width: 10px; }*/
    </style>
    <script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
    <script type="text/javascript" src="js/test.js"></script>
    <script type="text/javascript" src="js/location.js"></script>
</head>
<body>
<h1>
    와이파이 정보 구하기
</h1>

<jsp:include page="jsp/head.jsp"></jsp:include>

<div>
    <form method="get">
        LAT: <input name="lat" id="myLatitude" type="text" placeholder="0.0"> ,
        LNT: <input name="lnt" id="myLongitude" type="text" placeholder="0.0">
        <button type="button" onclick="getMyLocation()"> 내 위치 가져오기 </button>
        <input type="submit" value="근처 WIFI 정보 보기">
    </form>
</div>

<%
    WifiService wifiService = new WifiService();
    String latitude = request.getParameter("lat");
    String longitude = request.getParameter("lnt");

    double doubleLatitude = 0.0;
    double doubleLongitude = 0.0;

    List<PublicWifi> wifiList = new ArrayList<>();

    if (latitude != null && longitude != null) {
        doubleLatitude = Double.parseDouble(latitude);
        doubleLongitude = Double.parseDouble(longitude);
        wifiList = wifiService.getWifiList(doubleLatitude, doubleLongitude);
        wifiService.createHistory(latitude, longitude); // save history
    }
%>

<script type="text/javascript">
    document.getElementById("myLatitude").value = <%=doubleLatitude%>;
    document.getElementById("myLongitude").value = <%=doubleLongitude%>;
</script>

<div style="overflow-x:auto;">
    <table>
        <tr>
            <th> 거리(Km) </th>
            <th> 관리번호 </th>
            <th> 자치구 </th>
            <th> 와이파이명 </th>
            <th> 도로명주소 </th>
            <th> 상세주소 </th>
            <th> 설치위치</br>(층) </th>
            <th> 설치유형 </th>
            <th> 설치기관 </th>
            <th> 서비스구분 </th>
            <th> 망종류 </th>
            <th> 설치년도 </th>
            <th> 실내외구분 </th>
            <th> WIFI접속환경 </th>
            <th> X좌표 </th>
            <th> Y좌표 </th>
            <th> 작업일자 </th>
        </tr>
        <% if (wifiList.size() < 1) { %>
            <jsp:include page="jsp/initPage.jsp"></jsp:include>

        <%} else {

//            Connection conn = null;
//            PreparedStatement pstmt = null;
//            ResultSet rs = null;
//
//            Class.forName("org.sqlite.JDBC");
//
//            try {
//                conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");
//
//                if (conn != null) {
//                    System.out.println("Connect!");
//                } else {
//                    System.out.println("Disconnected..");
//                }
//
//                String getHistoryQuery = "SELECT * FROM history";
//                pstmt = conn.prepareStatement(getHistoryQuery);
//
//                rs = pstmt.executeQuery();
//
//                while (rs.next()) {
            for (PublicWifi pw : wifiList) { %>
        <tr>
            <td><%= pw.getDistance() %> </td>
            <td><%= pw.getManageNum() %> </td>
            <td><%= pw.getLocation() %> </td>
            <td><a href="#"><%= pw.getName() %></a></td>
            <td><%= pw.getRoadAddress() %> </td>
            <td><%= pw.getDetailAddress() %> </td>
            <td><%= pw.getLayer() %> </td>
            <td><%= pw.getCategory() %> </td>
            <td><%= pw.getAgency() %> </td>
            <td><%= pw.getDivision() %> </td>
            <td><%= pw.getWebType() %> </td>
            <td><%= pw.getInstallYear() %> </td>
            <td><%= pw.getInOut() %> </td>
            <td><%= pw.getEnvironment() %> </td>
            <td><%= pw.getLatitude() %> </td>
            <td><%= pw.getLongitude() %> </td>
            <td><%= pw.getCreatedAt() %> </td>
        </tr>
            <%}%>
        <%}%>

    </table>
</div>

<div>
    <input type="button" id="testButton" value="눌러봐!">
</div>
</body>
</html>