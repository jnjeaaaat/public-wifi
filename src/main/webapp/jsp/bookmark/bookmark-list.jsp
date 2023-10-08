<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 35%;}
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
    북마크 그룹
</h1>

<jsp:include page="../head.jsp"></jsp:include>

<div style="overflow-x:auto;">
    <table>
        <tr>
            <th> ID </th>
            <th> 북마크 이름 </th>
            <th> 와이파이명 </th>
            <th> 등록일자 </th>
            <th> 비고 </th>
        </tr>
        <%
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

                String getBookmarkListQuery =
                        "SELECT bw.bmWifiId, b.bmName, w.name, bw.createdAt " +
                        "FROM bookmarkWifi bw " +
                        "LEFT JOIN bookmark b on bw.bmId = b.bmId " +
                        "lEFT JOIN wifiList w on bw.wifiId = w.wifiId";

                pstmt = conn.prepareStatement(getBookmarkListQuery);

                rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("bmWifiId") %></td>
            <td><%= rs.getString("bmName") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("createdAt") %></td>
            <td style="text-align: center">
                삭제

            </td>

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
        %>
    </table>
</div>
</body>
</html>