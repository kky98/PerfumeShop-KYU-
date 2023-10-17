<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import= "java.text.DecimalFormat"%>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css">
<title>Perfume Info</title>
<script type="text/javascript">
	function addToCart() {
		if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
			document.addForm.submit();
			if(confirm("카트로 이동하시겠습니까?")){
				location.href="cart.jsp"
			}
		} else {
			document.addForm.reset();
		}
	}
</script>
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
			<h4>상품정보</h4>
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
				<img src="images/perfume/<%=rs.getString("p_fileName")%>" width = 300>
			</div>
			<div class="col-md-6">
				<h3><b>[<%=rs.getString("p_brand") %>]</b></h3>
				<h3><%=rs.getString("p_unitName") %></h3>
				<p> <b>용량 : </b> <%=rs.getString("p_unitVolume") %>ml
				<p> <b>판매가격 : </b> <%=deci.format(rs.getInt("p_unitPrice"))%>원
				<p> <b>성별 : </b> <%=rs.getString("p_gender") %>용
				<p> <b>재고 : </b> <%=rs.getString("p_unitsInStock") %>			
				<p> <form name="addForm" action="./addCart.jsp?id=<%=rs.getString("p_id") %>" method="post">
						<%
						if (rs.getInt("p_unitsInStock") != 0){ 
						%>
						<a href="#" class="btn btn-info" onclick="addToCart()"> 장바구니 &raquo;</a>
						<%} %>
					</form>
					<a href="./perfumes.jsp" class="btn btn-success"> 상품 목록 &raquo;</a>
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
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>