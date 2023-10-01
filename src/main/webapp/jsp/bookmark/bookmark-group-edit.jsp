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
    북마크 그룹 수정
</h1>

<jsp:include page="../head.jsp"></jsp:include>

<div style="overflow-x:auto;">
    <table>
        <tr>
            <td> 북마크 이름 </td>
            <td> <input type="text" name="bookmark-name"> </td>
        </tr>
        <tr>
            <td> 순서 </td>
            <td> <input type="text" name="bookmark-num"> </td>
        </tr>
        <tr>
            <td colspan='2'></td>
        </tr>
    </table>
</div>
</body>
</html>