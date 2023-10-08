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
    System.out.println(bmName);
    System.out.println(bmNum);

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
%>
<script>
    function isExist() {
        console.log('hi');
        const isExistBookmarkNum = '<%= isExistBookmarkNum %>';
        const isExistBookmarkName = '<%= isExistBookmarkName %>';
        const bookmarkForm = document.addBookmark;

        if (isExistBookmarkName == 1) {
            alert("중복된 이름입니다.");
            bookmarkForm.bookmarkName.focus();
            return false;
        }

        if (isExistBookmarkNum == 1) {
            alert("이미 지정받은 순번입니다. 다른 순번을 입력해주세요.");
            bookmarkForm.bookmarkNum.focus();
            return false;
        }
    }
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();

    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        if (rsNum != null) try {
            rsNum.close();
        } catch (SQLException ex) {
        }
        if (rsName != null) try {
            rsName.close();
        } catch (SQLException ex) {
        }
    }
%>


</body>
</html>
