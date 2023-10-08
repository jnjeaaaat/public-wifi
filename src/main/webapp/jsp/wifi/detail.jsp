<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 100%;}
        th { height: 30px; background-color: #04AA6D; color: white;}
        td { padding-left: 10px; padding-right: 10px; height: 25px;}
        tr:nth-child(odd) {background-color: #f2f2f2;}
        table, th, td { border: 1px solid lightgray; }
        div { margin-bottom: 10px; }
        /*form { width: 10px; }*/
    </style>
    <script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
    <script type="text/javascript" src="../../js/test.js"></script>
</head>
<body>
<h1>
    와이파이 정보 구하기
</h1>

<jsp:include page="../head.jsp"></jsp:include>

<%--<form method="post" action="../bookmark/bookmark-add.jsp">--%>
<div style="overflow-x:auto;">
<%
        request.setCharacterEncoding("utf-8");

        String mgrNo = request.getParameter("mgrNo");
        String distance = request.getParameter("distance-point");
        String group_id = request.getParameter("group-id");
        System.out.println(distance);

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rsOption = null;
        ResultSet rsWifi = null;

        Class.forName("org.sqlite.JDBC");

        try {
            conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");

            if (conn != null) {
                System.out.println("Connect!");
            } else {
                System.out.println("Disconnected..");
            }

            String getBmNameListQuery = "SELECT bmId, bmName FROM bookmark ORDER BY bmNum ASC";
            pstmt = conn.prepareStatement(getBmNameListQuery);
            rsOption = pstmt.executeQuery();

            String getWifiByName = "SELECT * FROM wifiList WHERE manageNum=?";
            pstmt = conn.prepareStatement(getWifiByName);
            pstmt.setString(1, mgrNo);
            rsWifi = pstmt.executeQuery();
%>
    <form method="post" action="../../jsp/bookmark/bookmark-add.jsp">
        <input type="hidden" name="mgrNo" value="<%=rsWifi.getString("manageNum")%>">
        <select id="group-id" name="group-id">
            <option value="" <%=group_id==null?"selected":""%>>북마크 그룹 이름 선택</option>
            <%
                while (rsOption.next()) {
                    String bmId = rsOption.getString("bmId");
                    String bmName = rsOption.getString("bmName");
            %>
            <option value="<%=bmId%>" <%=bmId.equals(group_id)?"selected":""%>> <%=bmName%> </option>
            <%
                }
            %>
        </select>
        <input type="hidden" name="wifiId" value="<%=rsWifi.getString("wifiId")%>">
        <input type="submit" value="북마크 추가하기">

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
                <tr>
                    <td><%= distance %></td>
                    <td><%= rsWifi.getString("manageNum") %></td>
                    <td><%= rsWifi.getString("location") %></td>
                    <td>
                        <form method="get">
                            <input type="hidden" name="distance-point" value="<%=distance%>">
                            <a href="?mgrNo=<%=rsWifi.getString("manageNum")%>">
                                <%= rsWifi.getString("name") %>
                            </a>
                        </form>
                    </td>
                    <td><%= rsWifi.getString("roadAddress") %></td>
                    <td><%= rsWifi.getString("detailAddress") %></td>
                    <td><%= rsWifi.getString("layer") %></td>
                    <td><%= rsWifi.getString("category") %></td>
                    <td><%= rsWifi.getString("agency") %></td>
                    <td><%= rsWifi.getString("division") %></td>
                    <td><%= rsWifi.getString("webType") %></td>
                    <td><%= rsWifi.getString("installYear") %></td>
                    <td><%= rsWifi.getString("inOut") %></td>
                    <td><%= rsWifi.getString("environment") %></td>
                    <td><%= rsWifi.getString("latitude") %></td>
                    <td><%= rsWifi.getString("longitude") %></td>
                    <td><%= rsWifi.getString("createdAt") %></td>
                </tr>
    </table>

    </form>
</div>
<%--</form>--%>

<%
    } catch (Exception e) {
        e.printStackTrace();

    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        if (rsOption != null) try { rsOption.close(); } catch (SQLException ex) {}
        if (rsWifi != null) try { rsOption.close(); } catch (SQLException ex) {}
    }

%>

</body>
</html>