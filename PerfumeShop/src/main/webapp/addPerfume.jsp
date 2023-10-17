<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Perfume Register</title>
<script type="text/javascript">
	function Check() {
		var form = document.addPer;
		if (form.p_id.value == ""){
			alert("상품코드(ID) 값을 입력해주세요!");
			return false;
		} else {
				form.submit();
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
%>
<!-- 메뉴항몽 userID를 통해 상품관리 메뉴 표시 -->
<nav class ="navbar navbar-default">
		<div class ="navbar-header">
			<button type ="button" class ="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-exmaple-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<h4>상품등록</h4>
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
	<div class="container">
	<h2>상품등록</h2><br>
<form name="addPer" action="./processAddPerfume.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
		<div class="form-group row">
			<label class="col-sm-2">향수코드</label>
			<div class="col-sm-3">
				<input type="text" id="p_id" name="p_id" class="form-control" >
			</div>	
		</div>
		<div class="form-group row">
			<label class="col-sm-2">브랜드</label>
			<div class="col-sm-3">
				<input type="text" id="p_brand" name="p_brand" class="form-control" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상품명</label>
			<div class="col-sm-3">
				<input type="text" id="p_unitName" name="p_unitName" class="form-control" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상품가격</label>
			<div class="col-sm-3">
				<input type="text" id="p_unitPrice" name="p_unitPrice" class="form-control" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">상품용량</label>
			<div class="col-sm-3">
				<input type="text" id="p_unitVolume" name="p_unitVolume" class="form-control" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">재고수</label>
			<div class="col-sm-3">
				<input type="text" id="p_unitsInStock" name="p_unitsInStock" class="form-control" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">계열</label>
			<div class="col-sm-3">
				<input type="text" name="p_note" class="form-control" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">Top Note</label>
			<div class="col-sm-3">
				<input type="text" name="p_topNote" class="form-control" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">Middle Note</label>
			<div class="col-sm-3">
				<input type="text" name="p_middleNote" class="form-control" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">Base Note</label>
			<div class="col-sm-3">
				<input type="text" name="p_baseNote" class="form-control" >
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">성별</label>
			<div class="col-sm-5">
				<input type="radio" name="p_gender"  value="남성"> 남성용
				<input type="radio" name="p_gender"  value="여성"> 여성용
				<input type="radio" name="p_gender"  value="공"> 공용
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">컨셉</label>
			<div class="col-sm-5">
				<textarea name="p_concept" cols="50" rows="2" class="form-control"></textarea>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">이미지</label>
			<div class="col-sm-5">
				<input type="file" name="p_image"  class="form-control">
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10 ">
				<input type="button" class="btn btn-primary" value="등록" onclick="Check()">
				<a href="./perfumes.jsp" class="btn btn-success">취소</a>
			</div>
		</div>
		
	</form>
	</div>
</body>
</html>