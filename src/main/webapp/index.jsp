<%@ page import="java.util.List" %>
<%@ page import="com.example.publicwifi.model.PublicWifi" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.publicwifi.Service.DataService" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.publicwifi.Service.WifiService" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Iterator" %>
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
        <%
            if (wifiList.size() < 1) {
        %>
            <jsp:include page="jsp/initPage.jsp"></jsp:include>
        <%
            } else {

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                Class.forName("org.sqlite.JDBC");

                try {
                    conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");

                    if (conn != null) {
                        System.out.println("Connect!");
                    } else {
                        System.out.println("Disconnected..");
                    }

                    String getWifiListQuery = "SELECT * FROM wifiList w LIMIT 20 OFFSET 1";
                    pstmt = conn.prepareStatement(getWifiListQuery);

                    rs = pstmt.executeQuery();

                    Iterator<PublicWifi> iterator = wifiList.iterator();

                    while (iterator.hasNext()) {
                        PublicWifi tmpPW = iterator.next();
        %>
<%--            <tr>--%>
<%--                <td>3</td>--%>
<%--                <td><%= rs.getString("manageNum") %></td>--%>
<%--                <td><%= rs.getString("location") %></td>--%>
<%--                <td>--%>
<%--                    <form method="get" action="jsp/wifi/detail.jsp">--%>
<%--                        <a href="jsp/wifi/detail.jsp?mgrNo=<%=rs.getString("manageNum")%>">--%>
<%--                            <%= rs.getString("name") %>--%>
<%--                        </a>--%>
<%--                    </form>--%>
<%--                </td>--%>
<%--                <td><%= rs.getString("roadAddress") %></td>--%>
<%--                <td><%= rs.getString("detailAddress") %></td>--%>
<%--                <td><%= rs.getString("layer") %></td>--%>
<%--                <td><%= rs.getString("category") %></td>--%>
<%--                <td><%= rs.getString("agency") %></td>--%>
<%--                <td><%= rs.getString("division") %></td>--%>
<%--                <td><%= rs.getString("webType") %></td>--%>
<%--                <td><%= rs.getString("installYear") %></td>--%>
<%--                <td><%= rs.getString("inOut") %></td>--%>
<%--                <td><%= rs.getString("environment") %></td>--%>
<%--                <td><%= rs.getString("latitude") %></td>--%>
<%--                <td><%= rs.getString("longitude") %></td>--%>
<%--                <td><%= rs.getString("createdAt") %></td>--%>
<%--            </tr>--%>
        <tr>
            <td><%= tmpPW.getDistance() %></td>
            <td><%= tmpPW.getManageNum() %></td>
            <td><%= tmpPW.getLocation() %></td>
            <td>
                <form method="get" action="/detail">
                    <input type="hidden" name="distance-point" value="<%=tmpPW.getDistance()%>">
                    <a href="/detail?mgrNo=<%=tmpPW.getManageNum()%>">
                        <%= tmpPW.getName() %>
                    </a>
                </form>
            </td>
            <td><%= tmpPW.getRoadAddress() %></td>
            <td><%= tmpPW.getDetailAddress() %></td>
            <td><%= tmpPW.getLayer() %></td>
            <td><%= tmpPW.getCategory() %></td>
            <td><%= tmpPW.getAgency() %></td>
            <td><%= tmpPW.getDivision() %></td>
            <td><%= tmpPW.getWebType() %></td>
            <td><%= tmpPW.getInstallYear() %></td>
            <td><%= tmpPW.getInOut() %></td>
            <td><%= tmpPW.getEnvironment() %></td>
            <td><%= tmpPW.getLatitude() %></td>
            <td><%= tmpPW.getLongitude() %></td>
            <td><%= tmpPW.getCreatedAt() %></td>
        </tr>
        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ex) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ex) {}
                }
            }
        %>

    </table>
</div>

</body>
</html>