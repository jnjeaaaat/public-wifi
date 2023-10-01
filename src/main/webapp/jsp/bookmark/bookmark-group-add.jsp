<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 100%;}
        th { height: 30px; background-color: #04AA6D; color: white;}
        td { padding-left: 10px; padding-right: 10px; height: 25px;}
        tr:nth-child(even) {background-color: #f2f2f2;}
        table, th, td { border: 1px solid lightgray; }
        div { margin-bottom: 10px; }

        .vertical-td { text-align:center; background-color: #04AA6D; color: white; }
        /*form { width: 10px; }*/
    </style>
    <script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
    <script type="text/javascript" src="../../js/test.js"></script>

</head>
<body>
<h1>
    북마크 그룹 수정
</h1>

<jsp:include page="../head.jsp"></jsp:include>

<%--<%--%>
<%--    String bmNum = request.getParameter("bookmarkNum");--%>
<%--    String bmName = request.getParameter("bookmarkName");--%>
<%--    int bmNumInt = 0;--%>
<%--    if (bmNum != null) {--%>
<%--        bmNumInt = Integer.parseInt(bmNum);--%>
<%--    }--%>


<%--    request.setCharacterEncoding("utf-8");--%>
<%--    Connection conn = null;--%>
<%--    PreparedStatement pstmt = null;--%>
<%--    ResultSet rsNum = null;--%>
<%--    ResultSet rsName = null;--%>

<%--    Class.forName("org.sqlite.JDBC");--%>

<%--    int isExistBookmarkNum = 0;--%>
<%--    int isExistBookmarkName = 0;--%>

<%--    try {--%>
<%--        conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");--%>

<%--        String isExistBookmarkNumQuery = "SELECT EXISTS (SELECT * FROM bookmark WHERE bmNum = ?)";--%>
<%--        pstmt = conn.prepareStatement(isExistBookmarkNumQuery);--%>
<%--        pstmt.setInt(1, bmNumInt);--%>
<%--        rsNum = pstmt.executeQuery();--%>
<%--        isExistBookmarkNum = Integer.parseInt(rsNum.getString(1));--%>
<%--        System.out.println("num : " + isExistBookmarkNum);--%>



<%--        String isExistBookmarkNameQuery = "SELECT EXISTS (SELECT * FROM bookmark WHERE bmName = ?)";--%>
<%--        pstmt = conn.prepareStatement(isExistBookmarkNameQuery);--%>
<%--        pstmt.setString(1, bmName);--%>
<%--        rsName = pstmt.executeQuery();--%>
<%--        isExistBookmarkName = Integer.parseInt(rsName.getString(1));--%>
<%--        System.out.println("name : " + isExistBookmarkName);--%>



<%--    } catch (Exception e) {--%>
<%--        e.printStackTrace();--%>

<%--    } finally {--%>
<%--        if (pstmt != null) try {--%>
<%--            pstmt.close();--%>
<%--        } catch (SQLException ex) {--%>
<%--        }--%>
<%--        if (conn != null) try {--%>
<%--            conn.close();--%>
<%--        } catch (SQLException ex) {--%>
<%--        }--%>
<%--        if (rsNum != null) try {--%>
<%--            rsNum.close();--%>
<%--        } catch (SQLException ex) {--%>
<%--        }--%>
<%--        if (rsName != null) try {--%>
<%--            rsName.close();--%>
<%--        } catch (SQLException ex) {--%>
<%--        }--%>
<%--    }--%>
<%--%>--%>

<%--<script>--%>
<%--    function isExsist() {--%>
<%--        console.log('hi');--%>
<%--        const isExistBookmarkNum = '<%= isExistBookmarkNum %>';--%>
<%--        const isExistBookmarkName = '<%= isExistBookmarkName %>';--%>
<%--        const bookmarkForm = document.addBookmark;--%>

<%--        if (isExistBookmarkName == 1) {--%>
<%--            alert("중복된 이름입니다.");--%>
<%--            bookmarkForm.bookmarkName.focus();--%>
<%--            return false;--%>
<%--        }--%>

<%--        if (isExistBookmarkNum == 1) {--%>
<%--            alert("이미 지정받은 순번입니다. 다른 순번을 입력해주세요.");--%>
<%--            bookmarkForm.bookmarkNum.focus();--%>
<%--            return false;--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>

<div style="overflow-x:auto;">
    <table>
        <form method="post" action="jsp/bookmark/bookmark-group-add-db.jsp" name="addBookmark">
        <tr>
            <td class="vertical-td"> 북마크 이름 </td>
            <td> <input type="text" name="bookmarkName"> </td>
        </tr>
        <tr>
            <td class="vertical-td"> 순서 </td>
            <td> <input type="text" name="bookmarkNum"> </td>
        </tr>
        <tr>
            <td colspan='2'>
                <input type="submit" value="추가" onclick="isExist()">
            </td>
        </tr>
        </form>
    </table>
</div>

</body>
</html>