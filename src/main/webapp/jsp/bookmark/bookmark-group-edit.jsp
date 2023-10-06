<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 30%;}
        th { height: 30px; background-color: #04AA6D; color: white;}
        td { padding-left: 10px; padding-right: 10px; height: 25px;}
        tr { height: 50px; }
        tr:nth-child(even) {background-color: #f2f2f2;}
        table, th, td { border: 1px solid lightgray; }
        div { margin-bottom: 10px; }

        .vertical-td { text-align:center; background-color: #04AA6D; color: white; font-weight: bolder}
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

<%
    request.setCharacterEncoding("UTF-8");

    String bmId = request.getParameter("bmId");
    System.out.println(bmId);

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    Class.forName("org.sqlite.JDBC");

    try {
        conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");

        String getNameAndNumQuery = "SELECT bmId, bmName, bmNum FROM bookmark WHERE bmId=?";
        pstmt = conn.prepareStatement(getNameAndNumQuery);
        pstmt.setString(1, bmId);
        rs = pstmt.executeQuery();
%>

<div style="overflow-x:auto;">
    <table>
        <form method="post" action="jsp/bookmark/bookmark-group-edit-db.jsp">
            <input type="hidden" name="bmId" value="<%=rs.getString("bmId")%>">
            <tr>
                <td class="vertical-td"> 북마크 이름 </td>
                <td> <input type="text" name="bookmark-name" value="<%=rs.getString("bmName")%>"> </td>
            </tr>
            <tr>
                <td class="vertical-td"> 순서 </td>
                <td> <input type="text" name="bookmark-num" value="<%=rs.getString("bmNum")%>"> </td>
            </tr>
            <tr style="height: 35px">
                <td style="text-align: center;" colspan='2'>
                    <a href="/bookmark-group">돌아가기</a> |
                    <input type="submit" value="수정">
                </td>
            </tr>
        </form>
    </table>
</div>

<%

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
    }
%>

</body>
</html>