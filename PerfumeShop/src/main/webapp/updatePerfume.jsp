<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Perfume Register</title>
</head>
<body>
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
			<h4>상품수정</h4>
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
		String id = request.getParameter("id");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "Select * from perfume where p_id='" + id + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
	%>
	<div class="container">
		<div class="form-group row">
			<div class="col-md-5">
				<img src="images/perfume/<%=rs.getString("p_fileName")%>" width = 300>
			</div>
		</div>
<form name="renewPerfum" action="./processUpdatePerfume.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
		<div class="form-group row">
			<label class="col-sm-2">향수코드</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" value="<%=rs.getString("p_id")%>" disabled >
				<input type="hidden" id="p_id" name="p_id" class="form-control" value="<%=rs.getString("p_id")%>" >
			</div>	
		</div>
		<div class="form-group row">
			<label class="col-sm-2">브랜드</label>
			<div class="col-sm-3">
				<input type="text" id="p_brand" name="p_brand" class="form-control" value="<%=rs.getString("p_brand")%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상품명</label>
			<div class="col-sm-3">
				<input type="text" id="p_unitName" name="p_unitName" class="form-control" value="<%=rs.getString("p_unitName")%>" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상품가격</label>
			<div class="col-sm-3">
				<input type="text" id="p_unitPrice" name="p_unitPrice" class="form-control" value="<%=rs.getString("p_unitPrice")%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상품용량</label>
			<div class="col-sm-3">
				<input type="text" id="p_unitVolume" name="p_unitVolume" class="form-control" value="<%=rs.getString("p_unitVolume")%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">재고수</label>
			<div class="col-sm-3">
				<input type="text" id="p_unitsInStock" name="p_unitsInStock" class="form-control" value="<%=rs.getString("p_unitsInStock")%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">계열</label>
			<div class="col-sm-3">
				<input type="text" name="p_note" class="form-control" value="<%=rs.getString("p_note")%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">Top Note</label>
			<div class="col-sm-3">
				<input type="text" name="p_topNote" class="form-control" value="<%=rs.getString("p_topNote")%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">Middle Note</label>
			<div class="col-sm-3">
				<input type="text" name="p_middleNote" class="form-control" value="<%=rs.getString("p_middleNote")%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">Base Note</label>
			<div class="col-sm-3">
				<input type="text" name="p_baseNote" class="form-control" value="<%=rs.getString("p_baseNote")%>">
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">성별</label>
			<div class="col-sm-5">
				<% 
				if (rs.getString("p_gender").equals("남성")) { %>
					<input type="radio" name="p_gender"  value="남성" checked> 남성용
					<input type="radio" name="p_gender"  value="여성"> 여성용
					<input type="radio" name="p_gender"  value="공" > 공용
				<% }else if (rs.getString("p_gender").equals("여성")) { %>
					<input type="radio" name="p_gender"  value="남성" > 남성용
					<input type="radio" name="p_gender"  value="여성" checked> 여성용
					<input type="radio" name="p_gender"  value="공" > 공용
				<% }else if (rs.getString("p_gender").equals("공")) {%>
					<input type="radio" name="p_gender"  value="남성" > 남성용
					<input type="radio" name="p_gender"  value="여성"> 여성용
					<input type="radio" name="p_gender"  value="공" checked> 공용
				<% }else {%>	
					<input type="radio" name="p_gender"  value="남성" > 남성용
					<input type="radio" name="p_gender"  value="여성"> 여성용
					<input type="radio" name="p_gender"  value="공" > 공용
				<%} %>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">컨셉</label>
			<div class="col-sm-5">
				<textarea name="p_concept" cols="50" rows="2" class="form-control"><%=rs.getString("p_concept")%></textarea>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">이미지</label>
			<div class="col-sm-5">
				<input type="file" name="p_image" class="form-control">
				<p> 현재 파일 : [images/perfume/<%=rs.getString("p_fileName")%>]
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10 ">
				<input type="submit" class="btn btn-primary" value="등록" >
				<a href="./perfumes.jsp" class="btn btn-success"> 취소</a>
			</div>
		</div>
		
	</form>
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