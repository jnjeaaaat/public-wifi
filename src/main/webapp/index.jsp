<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        table { border-collapse: collapse; width: 100%;}
        th { height: 50px; background-color: #04AA6D; color: white;}
        td { height: 35px; text-align: center; }
        tr:nth-child(odd) {background-color: #f2f2f2;}
        table, th, td { border: 1px solid lightgray; }
        div { margin-bottom: 10px; }
    </style>
    <script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
    <script type="text/javascript" src="js/test.js"></script>
    <script type="text/javascript" src="js/location.js"></script>
</head>
<body>
<h1>
    와이파이 정보 구하기
</h1>

<div class="home">
    <a href="/"> 홈 </a> |
    <a href="/history"> 히스토리 목록 </a> |
    <a href="/load-wifi"> Open API 와이파이 정보 가져오기 </a>
</div>

<div>
    LAT: <input id="myLatitude" type="text" placeholder="0.0"> ,
    LNT: <input id="myLongitude" type="text" placeholder="0.0">
    <button onclick="getMyLocation()"> 내 위치 가져오기 </button>
    <button> 근처 WIFI 정보 보기 </button>
</div>

<div style="overflow-x:auto;">
    <table>
        <tr>
            <th style="width: 5%;"> 거리</br>(Km) </th>
            <th> 관리번호 </th>
            <th style="width: 2%;"> 자치구 </th>
            <th> 와이파이명 </th>
            <th style="width: 10%;"> 도로명주소 </th>
            <th style="width: 20%;"> 상세주소 </th>
            <th> 설치위치</br>(층) </th>
            <th> 설치유형 </th>
            <th style="width: 4%;"> 설치기관 </th>
            <th style="width: 3.5%;"> 서비스구분 </th>
            <th> 망종류 </th>
            <th style="width: 3%;"> 설치년도 </th>
            <th style="width: 3%;"> 실내외구분 </th>
            <th style="width: 4%;"> WIFI접속환경 </th>
            <th> X좌표 </th>
            <th> Y좌표 </th>
            <th style="width: 8%;"> 작업일자 </th>
        </tr>
        <% if (request.getRequestURI().equals("/")) { %>
        <tr style="height: 60px">
            <td colspan='17'>
                위치 정보를 입력한 후에 조회해 주세요.
            </td>

        </tr>
        <% } else { %>
        <tr>
            <td>

            </td>
        </tr>
        <% } %>
    </table>
</div>

<%--<form method="get" action="/">--%>
<%--    <input type="submit" value="get 방식으로 호출하기">--%>
<%--</form>--%>

<%--<br/>--%>
<button id="button1" onclick="buttonClick()"> 버튼입니다. 누르면 alert </button>
<%--<script>--%>
<%--    const buttonClick = function () {--%>
<%--        alert("clicked")--%>
<%--    }--%>
<%--</script>--%>
<%--<p></p>--%>
<%--<a href="load-wifi">Hello Servlet</a>--%>
</body>
</html>