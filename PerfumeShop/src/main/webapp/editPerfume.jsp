<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import= "java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css">
<script type="text/javascript">
	function deleteConfirm(id) {
		if (confirm("해당 상품을 삭제합니다") == true)
			location.href = "./deletePerfume.jsp?id=" + id;
		else
			return;
	} 
</script>
<meta charset="UTF-8">
<title>Perfume Editor</title>
<%
	String edit = request.getParameter("edit");
%>
</head>
<body>
<%
String userID =null;
if(session.getAttribute("userID") != null){
	userID =(String)session.getAttribute("userID");
}

DecimalFormat deci = new DecimalFormat("###,###");
%>
<nav class ="navbar navbar-default">
		<div class ="navbar-header">
			<button type ="button" class ="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-exmaple-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<h4>상품편집</h4>
		</div>
		<div class ="collapse navbar-collapse" id ="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a class="navbar-brand" href="main.jsp">PerfumeShop</a></li>
				<li><a href="perfumes.jsp">상품</a></li>
				<li><a href="cart.jsp">장바구니</a></li>
				<li><a href="viewOrders.jsp">주문확인</a>
				<li><a href="review.jsp">리뷰</a></li>
			</ul>
			<%
			if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class ="dropdown">
					<a href="#" class ="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">메뉴<span class ="caret"></span></a>
					<ul class ="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%} else{%>
			<ul class="nav navbar-nav navbar-right">
				<li class ="dropdown">
					<a href="#" class ="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">메뉴<span class ="caret"></span></a>
					<ul class ="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃</a></li>
					<%if (userID.equals("admin")){ %>
					<li><a href="addPerfume.jsp">상품등록</a>
					<li><a href="editPerfume.jsp">상품편집</a>
					
					<%} %>
					</ul>
				</li>
			</ul>
			<%} %>
		</div>
	</nav>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<!-- 여기까지 페이지 기본 디자인 틀 및 구성 기능 -->
	<div class="container" >
		<div class="row">
			<%@ include file="dbconn.jsp" %>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "Select * from perfume";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
			%>			
			<div class="col-md-6">
				<img src="images/perfume/<%=rs.getString("p_fileName")%>" width = 200>
				<h3>[<%=rs.getString("p_brand") %>]<%=rs.getString("p_unitName") %></h3>
				<p><%=rs.getString("p_gender") %>용
				<p><%=rs.getString("p_note") %> 계열
				<p><%=deci.format(rs.getInt("p_unitPrice")) %>원
				<p>
					<a href="./updatePerfume.jsp?id=<%=rs.getString("p_id") %>"
						class="btn btn-success" role="button"> 수정&raquo;></a>
					<a href="#"
						onclick="deleteConfirm('<%=rs.getString("p_id") %>')"
						class="btn btn-info" role="button"> 삭제&raquo;></a>
					
			</div>	
		</div>
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
</body>
</html>