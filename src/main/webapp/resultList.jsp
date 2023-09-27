<%@ page import="com.example.publicwifi.model.PublicWifi" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
    <script type="text/javascript" src="js/test.js"></script>
    <script type="text/javascript" src="js/location.js"></script>
</head>
<body>

<%
//    String[] temp = request.getParameterValues("wifiList");
//    System.out.println(temp[0]);
    List<PublicWifi> wifiList = <c:out value="${wifiList}"></c:out> ;%>
<%--    System.out.println(wifiList.get(0));--%>
<%--%>--%>

<tr style="height: 60px">
    <td colspan='17'>
        이건 다른 페이지
    </td>
</tr>

</body>
</html>