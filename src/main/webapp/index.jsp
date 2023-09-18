<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1>
    <%= "Hello World!"
%>
</h1>

<form method="get" action="hello-servlet">
    <input type="submit" value="get 방식으로 호출하기">
</form>

<br/>
<a href="hello-servlet">Hello Servlet</a>
</body>
</html>