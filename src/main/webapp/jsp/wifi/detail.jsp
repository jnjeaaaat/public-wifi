<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 100%;}
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
    와이파이 정보 구하기
</h1>

<jsp:include page="../head.jsp"></jsp:include>

<form method="post"></form>
<div style="overflow-x:auto;">
<%
        request.setCharacterEncoding("utf-8");

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

            String getBmNameListQuery = "SELECT bmName FROM bookmark ORDER BY bmNum ASC";
            pstmt = conn.prepareStatement(getBmNameListQuery);

            rs = pstmt.executeQuery();
%>
    <select>
        <%
            while (rs.next()) {
        %>
            <option><%=rs.getString("bmName")%></option>
        <%
            }
        %>
    </select>
    <%
        } catch (Exception e) {
        e.printStackTrace();

    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
    }

    %>
    <input type="submit" onclick="location.href='bookmark-group-add.jsp'" value="북마크 추가하기">

    <table>
        <tr>
            <th> 거리(Km) </th>
            <th> 관리번호 </th>
            <th> 자치구 </th>
            <th> 와이파이명 </th>
            <th> 도로명주소 </th>
            <th> 상세주소 </th>
            <th> 설치위치</br>(층) </th>
            <th> 설치유형 </th>
            <th> 설치기관 </th>
            <th> 서비스구분 </th>
            <th> 망종류 </th>
            <th> 설치년도 </th>
            <th> 실내외구분 </th>
            <th> WIFI접속환경 </th>
            <th> X좌표 </th>
            <th> Y좌표 </th>
            <th> 작업일자 </th>
        </tr>
        <%
            String mgrNo = request.getParameter("mgrNo");
            String distance = request.getParameter("distance-point");
            System.out.println(distance);
            request.setCharacterEncoding("utf-8");

            Class.forName("org.sqlite.JDBC");

            try {
                conn = DriverManager.getConnection("jdbc:sqlite:" + "/Users/parktj/Documents/sqlite-studio-db/public-wifi.db");

                if (conn != null) {
                    System.out.println("Connect!");
                } else {
                    System.out.println("Disconnected..");
                }

                String getWifiByName = "SELECT * FROM wifiList WHERE manageNum=?";
                pstmt = conn.prepareStatement(getWifiByName);
                pstmt.setString(1, mgrNo);

                rs = pstmt.executeQuery();

        %>
                <tr>
<%--                    <td>3</td>--%>
                    <td><%= distance %></td>
                    <td><%= rs.getString("manageNum") %></td>
                    <td><%= rs.getString("location") %></td>
                    <td>

                        <form method="get">
                            <input type="hidden" name="distance-point" value=<%=distance%>>
                            <a href="?mgrNo=<%=rs.getString("manageNum")%>">
                                <%= rs.getString("name") %>
                            </a>
                        </form>

                    </td>
                    <td><%= rs.getString("roadAddress") %></td>
                    <td><%= rs.getString("detailAddress") %></td>
                    <td><%= rs.getString("layer") %></td>
                    <td><%= rs.getString("category") %></td>
                    <td><%= rs.getString("agency") %></td>
                    <td><%= rs.getString("division") %></td>
                    <td><%= rs.getString("webType") %></td>
                    <td><%= rs.getString("installYear") %></td>
                    <td><%= rs.getString("inOut") %></td>
                    <td><%= rs.getString("environment") %></td>
                    <td><%= rs.getString("latitude") %></td>
                    <td><%= rs.getString("longitude") %></td>
                    <td><%= rs.getString("createdAt") %></td>
                </tr>
        <%
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