<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
    <script type="text/javascript" src="js/test.js"></script>
    <script type="text/javascript" src="js/location.js"></script>

    <style>
        tr:nth-child(odd) {background-color: #f2f2f2;}
    </style>
</head>
<body>
<%
    String historyId = request.getParameter("historyId");
    System.out.println(historyId);

    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;

    Class.forName("org.sqlite.JDBC");

    try {
        conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");

        String deleteHistory = "DELETE FROM history WHERE historyId=?";
        pstmt = conn.prepareStatement(deleteHistory);
        pstmt.setString(1, historyId);
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
    }

    response.sendRedirect("/history");
%>

</body>
</html>