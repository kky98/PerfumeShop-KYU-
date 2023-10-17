<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<a class="navbar-brand" href="main.jsp">PerfumeShop</a>
		</div>
		<div class ="collapse navbar-collapse" id ="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				
				<li><a href="perfumes.jsp">상품</a></li>
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
					<li><a href="review.jsp">리뷰</a></li>
					<li><a href="cart.jsp">장바구니</a></li>
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
					<li><a href="review.jsp">리뷰</a></li>
					<li><a href="cart.jsp">장바구니</a></li>
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