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
    <script type="text/javascript" src="../../js/bookmark.js"></script>
    <script>
        function bookmarkCheck() {
            if(document.bookmarkForm.bookmarkName.value == "" || document.bookmarkForm.bookmarkName.value.length < 0){
                alert("이름을 입력해주세요.")
                return false;
            }

            if(document.bookmarkForm.bookmarkNum.value == "" || document.bookmarkForm.bookmarkNum.value.length < 0){
                alert("순번을 입력해주세요.")
                return false;
            }
        }
    </script>
</head>
<body>
<h1>
    북마크 그룹 추가
</h1>

<jsp:include page="../head.jsp"></jsp:include>

<%--action="jsp/bookmark/bookmark-group-add-db.jsp"--%>
<p> <button onclick="test()"> testButton </button></p>
<div style="overflow-x:auto;">
    <table>
        <form method="post" action="jsp/bookmark/bookmark-group-add-db.jsp" onsubmit="return bookmarkCheck();" id="bookmarkForm" name="bookmarkForm" accept-charset="utf-8">
            <tr>
                <td class="vertical-td"> 북마크 이름 </td>
                <td> <input type="text" name="bookmarkName" style="ime-mode: active"> </td>
            </tr>
            <tr>
                <td class="vertical-td"> 순서 </td>
                <td> <input type="text" name="bookmarkNum"> </td>
            </tr>
            <tr style="height: 35px">
                <td style="text-align: center;" colspan='2'>
                    <input type="submit" value="추가">
                </td>
            </tr>
        </form>
    </table>
</div>



</body>
</html>