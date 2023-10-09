<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 50%;}
        th { height: 30px; background-color: #04AA6D; color: white;}
        td {padding-left: 10px; padding-right: 10px; height: 25px;}
        tr { height: 50px; }
        tr:nth-child(even) {background-color: #f2f2f2;}
        table, th, td { border: 1px solid lightgray; }
        div { margin-bottom: 10px; }

        .vertical-td { width: 55%; text-align:center; background-color: #04AA6D; color: white; font-weight: bolder}
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

    String distance = request.getParameter("distance");
    String mgrNo = request.getParameter("mgrNo");
    String group_id = request.getParameter("group-id");

    System.out.println("distance : " + distance);

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

//        double distance = dataService.getDistance();
%>
    <form method="post" action="../../jsp/bookmark/bookmark-add.jsp">
        <input type="hidden" name="mgrNo" value="<%=rsWifi.getString("manageNum")%>">
        <input type="hidden" name="distance" value="<%=distance%>">
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
            <td class="vertical-td"> 거리(Km) </td>
            <td><%= distance %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 관리번호 </td>
            <td><%= rsWifi.getString("manageNum") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 자치구 </td>
            <td><%= rsWifi.getString("location") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 와이파이명 </td>
            <td>
                <form method="get">
                    <a href="?mgrNo=<%=rsWifi.getString("manageNum")%>&distance=<%=distance%>">
                        <%= rsWifi.getString("name") %>
                    </a>
                </form>
            </td>
        </tr>
        <tr>
            <td class="vertical-td"> 도로명주소 </td>
            <td><%= rsWifi.getString("roadAddress") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 상세주소 </td>
            <td><%= rsWifi.getString("detailAddress") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 설치위치(층) </td>
            <td><%= rsWifi.getString("layer") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 설치유형 </td>
            <td><%= rsWifi.getString("category") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 설치기관 </td>
            <td><%= rsWifi.getString("agency") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 서비스구분 </td>
            <td><%= rsWifi.getString("division") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 망종류 </td>
            <td><%= rsWifi.getString("webType") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 설치년도 </td>
            <td><%= rsWifi.getString("installYear") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 실내외구분 </td>
            <td><%= rsWifi.getString("inOut") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> WIFI접속환경 </td>
            <td><%= rsWifi.getString("environment") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> X좌표 </td>
            <td><%= rsWifi.getString("latitude") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> Y좌표 </td>
            <td><%= rsWifi.getString("longitude") %></td>
        </tr>
        <tr>
            <td class="vertical-td"> 작업일자 </td>
            <td><%= rsWifi.getString("createdAt") %></td>
        </tr>
    </table>

    </form>
</div>

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