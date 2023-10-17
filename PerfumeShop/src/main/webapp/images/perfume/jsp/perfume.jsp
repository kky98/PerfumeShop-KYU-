<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Perfume Info</title>
</head>
<body>
	<div class ="jumbotron">
		<div class ="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%@ include file="dbconn.jsp" %>
	<%
		String id = request.getParameter("id");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "Select * from perfume where p_id='" + id + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="c:/upload/<%=rs.getString("p_fileName")%>" width = 300>
			</div>
			<div class="col-md-6">
				<h3><b>[<%=rs.getString("p_brand") %>]</b></h3>
				<h3><%=rs.getString("p_unitName") %></h3>
				<p> <b>용량 : </b> <%=rs.getString("p_unitVolume") %>ml
				<p> <b>판매가격 : </b> <%=rs.getString("p_unitPrice") %>원
				<p> <b>성별 : </b> <%=rs.getString("p_gender") %>용
				<p> <b>재고 : </b> <%=rs.getString("p_unitsInStock") %>			
				<p> <a href="#" class="btn btn-info"> 상품 주문 &raquo;</a>
					<a href="./perfumes.jsp" class="btn btn-secondary"> 상품 목록 &raquo;</a>
					<a href="./updatePerfume.jsp?id=<%=rs.getString("p_id") %>"
						class="btn btn-secondary" role="button">상품 수정&raquo;></a>
			</div>
		</div>
		<hr>
	</div>
	<div class="container">
		<div class="row-md-3" align="center">
			<h3><b>Concept</b></h3>			
			<h3><%=rs.getString("p_concept") %></h3>
		</div>
		<div class="row-md-4" align="center">
			<h3><b><%=rs.getString("p_note") %> 계열</b></h3>	
			<h4><b>Top Note : </b><%=rs.getString("p_topNote") %></h4>
			<h4><b>Middle Note : </b><%=rs.getString("p_middleNote") %></h4>
			<h4><b>Base Note : </b><%=rs.getString("p_baseNote") %></h4>	
		</div>
	</div>
	<%
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if ( conn != null)
					conn.close();
	%>
</body>
</html>