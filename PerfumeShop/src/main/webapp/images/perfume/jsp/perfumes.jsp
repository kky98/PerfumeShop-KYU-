<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Perfume List</title>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	<div class="container">
		<div class="row" align="center">
			<%@ include file="dbconn.jsp" %>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "Select * from perfume";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {	
			%>
			<div class="col-md-4">
				<img src="c:/upload/<%=rs.getString("p_fileName")%>" width = 200>
				<h3>[<%=rs.getString("p_brand") %>]<%=rs.getString("p_unitName") %></h3>
				<p><%=rs.getString("p_gender") %>용
				<p><%=rs.getString("p_note") %> 계열
				<p><%=rs.getString("p_unitPrice") %>원
				<p>
					<a href="./perfume.jsp?id=<%=rs.getString("p_id") %>"
						class="btn btn-secondary" role="button">상세 정보&raquo;></a>
			</div>
	
			<%
				}
		
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if ( conn != null)
					conn.close();
			%>
			</div>
			<hr>
	</div>
</body>
</html>