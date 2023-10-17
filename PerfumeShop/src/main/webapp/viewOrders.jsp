<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import= "java.text.DecimalFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<title>주문목록</title>
</head>
<body>
<%
String userID =null;
if(session.getAttribute("userID") != null){
	userID =(String)session.getAttribute("userID");
}
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
			<h4>주문확인</h4>
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
	<%@ include file="dbconn.jsp" %>
	<%
		DecimalFormat decFormat = new DecimalFormat("###,###");
		String id;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql =null;
		int prices=0;
		int num=0;
		sql = "Select * from orders where orderId='" + userID + "' order by 1 desc";
		if (userID != null && userID.equals("admin")){
			sql = "select * from orders order by 1 desc";
		}
		pstmt = conn.prepareStatement(sql);
		rs =pstmt.executeQuery();
		PreparedStatement pstmtPerf = null;
		ResultSet rsPerf = null;
		String sqlPerf =null;
	%>
	<div class="container">
		<div class="row">
			<h2>주문확인/주문정보</h2>
			<%
				while(rs.next()){
					int total=0;
					String[] orderList=rs.getString("orderPerfumes").split(",");
					String[] orderListNum=rs.getString("orderPerfumeNum").split(",");
			%>
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<caption>
				주문일 : <%=rs.getString("birth") %> / 받는사람 : <%=rs.getString("orderName") %> / 연락처 : <%=rs.getString("orderTel") %> / 주소 : <%=rs.getString("orderAddress") %> <%if (userID.equals("admin")) {%>/ 아이디 : <%=rs.getString("orderId") %><%} %>
				</caption>
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">사진</th>
						<th style="background-color: #eeeeee; text-align: center;">상품명</th>
						<th style="background-color: #eeeeee; text-align: center;">수량</th>
						<th style="background-color: #eeeeee; text-align: center;">가격</th>
					</tr>
				</thead>
				<tbody>	
	<%
	for(int i=0;i<orderList.length; i++) {
		id = orderList[i];
    	sqlPerf = "Select * from perfume where p_id='" + id + "'";
		pstmtPerf = conn.prepareStatement(sqlPerf);
		rsPerf = pstmtPerf.executeQuery();
		rsPerf.next();
		num=Integer.parseInt(orderListNum[i]);
		prices=num*rsPerf.getInt("p_unitPrice");
		total+=prices;
	%>	
					<tr>
						<td><img src="images/perfume/<%=rsPerf.getString("p_fileName")%>" width = 100></td>
						<td>[<%=rsPerf.getString("p_brand") %>]<br><%=rsPerf.getString("p_unitName") %></td>
						<td><%=num %></td>
						<td><%=decFormat.format(prices) %>원
					</tr>
					<%}%>				
				</tbody>
			</table>
			<div align="right"><p>총 구매금액 : <%=decFormat.format(total) %>원</div>
			<%} %>
</div>
</div>
<%
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if ( conn != null)
			conn.close();
		if (rsPerf != null)
			rsPerf.close();
		if (pstmtPerf != null)
			pstmtPerf.close();
	%>
</body>
</html>