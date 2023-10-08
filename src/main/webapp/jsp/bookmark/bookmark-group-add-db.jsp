<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: parktj
  Date: 2023/09/29
  Time: 10:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
</head>
<body>
<%
    String bmName = request.getParameter("bookmarkName");
    String bmNum = request.getParameter("bookmarkNum");
    System.out.println("add-db : " + bmName);
    System.out.println("add-db : " + bmNum);

    Connection conn = null;
    PreparedStatement pstmt = null;

    Class.forName("org.sqlite.JDBC");

    try {
        conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");
        String addBookmarkQuery = "INSERT INTO bookmark(bmName, bmNum) VALUES(?, ?)";
        pstmt = conn.prepareStatement(addBookmarkQuery);
        pstmt.setString(1, bmName);
        pstmt.setString(2, bmNum);

    } catch (Exception e) {
        e.printStackTrace();

    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
    }

    response.sendRedirect("/bookmark-group");
%>



</body>
</html>
