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

        String addBookmarkQuery = "INSERT INTO bookmark(bmName, bmNum) VALUES(?, ?)";
        pstmt = conn.prepareStatement(addBookmarkQuery);
        pstmt.setString(1, bmName);
        pstmt.setString(2, bmNum);
        if (isExistBookmarkNum == 1) {
%>

<script>
    alert("중복 순번");
    location.href='/bookmark-group-add';
</script>

<%
        } else if (isExistBookmarkName == 1){
%>

<script>
    alert("중복 이름");
    location.href='/bookmark-group-add';
</script>

<%
        } else {
            pstmt.executeUpdate();
        }

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
