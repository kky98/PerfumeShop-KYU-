<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
 String path = request.getSession().getServletContext().getRealPath("fileUpload");
	out.println(path);
	String path2 = request.getRealPath("fileUpload");
	out.println(path2);


%>
</body>
</html>