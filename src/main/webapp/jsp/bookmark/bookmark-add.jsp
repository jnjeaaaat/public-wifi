<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    String nowStr = sdf.format(now);

    String bmId = request.getParameter("group-id");
    String wifiId = request.getParameter("wifiId");
    String mgrNo = request.getParameter("mgrNo");
    System.out.println(mgrNo);
    System.out.println("add bookmark bmId : " + bmId);
    System.out.println("add bookmark wifiId : " + wifiId);

    Connection conn = null;
    PreparedStatement pstmt1 = null;
    PreparedStatement pstmt2 = null;
    PreparedStatement pstmt3 = null;
    ResultSet rs = null;
    int checkExist = 0;

    Class.forName("org.sqlite.JDBC");

    try {
        conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");

        String isExistBookmarkQuery = "SELECT EXISTS (SELECT * FROM bookmarkWifi WHERE bmId=?)";
        pstmt1 = conn.prepareStatement(isExistBookmarkQuery);
        pstmt1.setString(1, bmId);
        rs = pstmt1.executeQuery();
        checkExist = rs.getInt(1);

        String addBookmarkListQuery = "INSERT INTO bookmarkWifi (bmId, wifiId) values (?, ?)";
        pstmt2 = conn.prepareStatement(addBookmarkListQuery);
        pstmt2.setString(1, bmId);
        pstmt2.setString(2, wifiId);

        String modifyBookmarkListQuery = "UPDATE bookmarkWifi SET (wifiId, createdAt)=(?, ?) WHERE bmId=?";
        pstmt3 = conn.prepareStatement(modifyBookmarkListQuery);
        pstmt3.setString(1, wifiId);
        pstmt3.setString(2, nowStr);
        pstmt3.setString(3, bmId);

        if (bmId != null && !bmId.equals("") && wifiId != null) {
            if (checkExist == 1) {
                pstmt3.executeUpdate();
            } else {
                pstmt2.executeUpdate();
            }
        }
//        pstmt = conn.prepareStatement(deleteHistory);
//        pstmt.setString(1, historyId);
//        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt1 != null) try { pstmt1.close(); } catch (SQLException ex) {}
        if (pstmt2 != null) try { pstmt2.close(); } catch (SQLException ex) {}
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
    }

    response.sendRedirect("/detail?mgrNo="+mgrNo);
%>

</body>
</html>