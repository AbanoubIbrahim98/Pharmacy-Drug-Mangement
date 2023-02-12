<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title> تم الخروج</title>
</head>
<body>
	<%
		HttpSession httpsession = request.getSession();
		httpsession.invalidate();
		response.sendRedirect("Index.html");
	%>
</body>
</html>