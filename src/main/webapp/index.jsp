<%@ page import="java.util.List" %>
<%@ page import="com.example.publicwifi.model.PublicWifi" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.publicwifi.Service.DataService" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.publicwifi.Service.WifiService" %>
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

<div class="home">
    <a href="/"> 홈 </a> |
    <a href="/history"> 히스토리 목록 </a> |
    <a href="/load-wifi"> Open API 와이파이 정보 가져오기 </a>
</div>

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
    }

    for (PublicWifi pw : wifiList) {
        System.out.println(pw.getDistance());
    }
    System.out.println(doubleLatitude);
    System.out.println(doubleLongitude);
%>

<%
    wifiService.
%>

<%--<% for (int i = 0; i < wifiList.size(); i++) { %>--%>
<%--    <p> <%=Math.round(wifiList.get(i).getDistance() * 10000.0) / 10000.0%> </p>--%>
<%--<%}%>--%>

<script type="text/javascript">
    document.getElementById("myLatitude").value = <%=doubleLatitude%>;
    document.getElementById("myLongitude").value = <%=doubleLongitude%>;
</script>

<div style="overflow-x:auto;">
    <table>
<%--        <tr>--%>
<%--            <th style="width: 5%;"> 거리</br>(Km) </th>--%>
<%--            <th> 관리번호 </th>--%>
<%--            <th style="width: 2%;"> 자치구 </th>--%>
<%--            <th> 와이파이명 </th>--%>
<%--            <th style="width: 10%;"> 도로명주소 </th>--%>
<%--            <th style="width: 20%;"> 상세주소 </th>--%>
<%--            <th> 설치위치</br>(층) </th>--%>
<%--            <th> 설치유형 </th>--%>
<%--            <th style="width: 4%;"> 설치기관 </th>--%>
<%--            <th style="width: 3.5%;"> 서비스구분 </th>--%>
<%--            <th> 망종류 </th>--%>
<%--            <th style="width: 3%;"> 설치년도 </th>--%>
<%--            <th style="width: 3%;"> 실내외구분 </th>--%>
<%--            <th style="width: 4%;"> WIFI접속환경 </th>--%>
<%--            <th> X좌표 </th>--%>
<%--            <th> Y좌표 </th>--%>
<%--            <th style="width: 8%;"> 작업일자 </th>--%>
<%--        </tr>--%>
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
            <jsp:include page="initPage.jsp"></jsp:include>

        <%} else {
            for (PublicWifi pw : wifiList) { %>
        <tr>
            <td><%= pw.getDistance() %> </td>
            <td><%= pw.getManageNum() %> </td>
            <td><%= pw.getLocation() %> </td>
            <td><%= pw.getName() %> </td>
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


<%--<button id="button1" onclick="buttonClick()"> 버튼입니다. 누르면 alert </button>--%>

</body>
</html>