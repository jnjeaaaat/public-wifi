<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date now =new Date();

    String bmId = request.getParameter("bmId");
    String bmName = request.getParameter("bookmark-name");
    String bmNum = request.getParameter("bookmark-num");
    String nowStr = sdf.format(now);

    System.out.println("bmID : " + bmId);
    System.out.println("bmName : " + bmName);
    System.out.println("bmNum : " + bmNum);
    System.out.println("now Time : " + nowStr);

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rsNum = null;
    ResultSet rsName = null;

    Class.forName("org.sqlite.JDBC");

    int isExistBookmarkNum = 0;
    int isExistBookmarkName = 0;
    try {
        conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");

        String isExistBookmarkNumQuery = "SELECT EXISTS (SELECT * FROM bookmark WHERE bmNum = ?)";
        pstmt = conn.prepareStatement(isExistBookmarkNumQuery);
        pstmt.setString(1, bmNum);
        rsNum = pstmt.executeQuery();
        isExistBookmarkNum = Integer.parseInt(rsNum.getString(1));
        System.out.println("num : " + isExistBookmarkNum);

        String isExistBookmarkNameQuery = "SELECT EXISTS (SELECT * FROM bookmark WHERE bmName = ?)";
        pstmt = conn.prepareStatement(isExistBookmarkNameQuery);
        pstmt.setString(1, bmName);
        rsName = pstmt.executeQuery();
        isExistBookmarkName = Integer.parseInt(rsName.getString(1));
        System.out.println("name : " + isExistBookmarkName);

        String modifyBookmarkGroupQuery = "UPDATE bookmark SET (bmName, bmNum, updatedAt)=(?, ?, ?) WHERE bmId=?";
        pstmt = conn.prepareStatement(modifyBookmarkGroupQuery);
        pstmt.setString(1, bmName);
        pstmt.setString(2, bmNum);
        pstmt.setString(3, nowStr);
        pstmt.setString(4, bmId);
        pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();

    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        if (rsName != null) try { rsName.close(); } catch (SQLException ex) {}
        if (rsNum != null) try { rsNum.close(); } catch (SQLException ex) {}
    }

    response.sendRedirect("/bookmark-group");
%>

</body>
</html>