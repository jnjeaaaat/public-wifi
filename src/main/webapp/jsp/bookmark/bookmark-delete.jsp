<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 30%;}
        th { height: 30px; background-color: #04AA6D; color: white;}
        td { padding-left: 10px; padding-right: 10px; height: 25px;}
        tr { height: 50px; }
        tr:nth-child(even) {background-color: #f2f2f2;}
        table, th, td { border: 1px solid lightgray; }
        div { margin-bottom: 10px; }

        .vertical-td { text-align:center; background-color: #04AA6D; color: white; font-weight: bolder}
        /*form { width: 10px; }*/
    </style>
    <script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
    <script type="text/javascript" src="../../js/bookmark.js"></script>

</head>
<body>
<h1>
    북마크 삭제
</h1>

<jsp:include page="../head.jsp"></jsp:include>

<div>
    북마크를 삭제하시겠습니까?
</div>

<%
    String bmWifiId = request.getParameter("id");

    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    Class.forName("org.sqlite.JDBC");

    try {
        conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");

        String getBookmarkByIdQuery =
                "SELECT bw.bmWifiId, b.bmName, w.name as wifiName, bw.createdAt " +
                "FROM bookmarkWifi bw " +
                "LEFT JOIN bookmark b on bw.bmId = b.bmId " +
                "lEFT JOIN wifiList w on bw.wifiId = w.wifiId " +
                "WHERE bw.bmWifiId=?";

        pstmt = conn.prepareStatement(getBookmarkByIdQuery);
        pstmt.setString(1, bmWifiId);
        rs = pstmt.executeQuery();

%>

<div style="overflow-x:auto;">
    <table>
        <form method="post" action="jsp/bookmark/bookmark-delete-db.jsp">
            <input type="hidden" name="bmWifiId" value="<%=rs.getString("bmWifiId")%>">
            <tr>
                <td class="vertical-td"> 북마크 이름 </td>
                <td> <%= rs.getString("bmName") %> </td>
            </tr>
            <tr>
                <td class="vertical-td"> 와이파이명 </td>
                <td> <%= rs.getString("wifiName") %> </td>
            </tr>
            <tr>
                <td class="vertical-td"> 등록일자 </td>
                <td> <%= rs.getString("createdAt") %> </td>
            </tr>
            <tr style="height: 35px">
                <td style="text-align: center;" colspan='2'>
                    <a href="/bookmark-list">돌아가기</a> |
                    <input type="submit" value="삭제">
                </td>
            </tr>
        </form>
    </table>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
    }
%>

</body>
</html>