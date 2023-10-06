<%@ page import="com.example.publicwifi.Service.WifiService" %>
<%@ page import="com.example.publicwifi.model.History" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
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
    <script type="text/javascript" src="../../js/location.js"></script>
    <script type="text/javascript" src="../../js/history.js"></script>
</head>
<body>
<h1>
    위치 히스토리 목록
</h1>

<jsp:include page="../head.jsp"></jsp:include>

<div style="overflow-x:auto;">
    <table>
        <tr>
            <th> ID </th>
            <th> X좌표 </th>
            <th> Y좌표 </th>
            <th> 조회일자 </th>
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

                String getHistoryQuery = "SELECT * FROM history ORDER BY historyId desc";
                pstmt = conn.prepareStatement(getHistoryQuery);

                rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("historyId") %></td>
                <td><%= rs.getString("latitude") %></td>
                <td><%= rs.getString("longitude") %></td>
                <td><%= rs.getString("createdAt") %></td>
                <td style="text-align: center">
                    <input type="button" onclick="location.href='jsp/history/deleteHistory.jsp?historyId=<%= rs.getInt("historyId") %>'" value="삭제">
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