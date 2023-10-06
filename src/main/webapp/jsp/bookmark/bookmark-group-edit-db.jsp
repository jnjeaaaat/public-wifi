<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");

    String bmId = request.getParameter("bmId");
    String bmName = request.getParameter("bookmark-name");
    String bmNum = request.getParameter("bookmark-num");
    System.out.println("bmID : " + bmId);
    System.out.println(bmName);
    System.out.println("bmNum : " + bmNum);

    Connection conn = null;
    PreparedStatement pstmt = null;

    Class.forName("org.sqlite.JDBC");

    try {
        conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");

        String modifyBookmarkGroupQuery = "UPDATE bookmark SET (bmName, bmNum)=(?, ?) WHERE bmId=?";
        pstmt = conn.prepareStatement(modifyBookmarkGroupQuery);
        pstmt.setString(1, bmName);
        pstmt.setString(2, bmNum);
        pstmt.setString(3, bmId);
        pstmt.executeUpdate();

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