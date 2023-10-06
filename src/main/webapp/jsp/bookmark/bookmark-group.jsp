<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 50%;}
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
    <input type="button" onclick="location.href='bookmark-group-add'" value="북마크 그룹 이름 추가">
    <table>
        <tr>
            <th> ID </th>
            <th> 북마크 이름 </th>
            <th> 순서 </th>
            <th> 등록일자 </th>
            <th> 수정일자 </th>
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

                String getBookmarkGroupQuery = "SELECT * FROM bookmark ORDER BY bmNum asc";
                pstmt = conn.prepareStatement(getBookmarkGroupQuery);

                rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("bmId") %></td>
                <td><%= rs.getString("bmName") %></td>
                <td><%= rs.getString("bmNum") %></td>
                <td><%= rs.getString("createdAt") %></td>
                <td> <%
                    if (rs.getString("updatedAt") != null) {
                %><%= rs.getString("updatedAt") %>
                <%} %></td>
                <td style="text-align: center">
                    <a href="/bookmark-group-edit"> 수정 </a> &ensp;
                    <a href="/#"> 삭제 </a>
<%--                    <input type="button" onclick="location.href='deleteHistory.jsp?historyId=<%= rs.getInt("historyId") %>'" value="삭제">--%>
<%--                    <input type=""--%>
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