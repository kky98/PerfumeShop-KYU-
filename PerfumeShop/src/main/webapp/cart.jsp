<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import= "java.text.DecimalFormat"%>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css">
<title>Perfume Info</title>
<!-- 장바구니, 로그인검사 -->
<script type="text/javascript">
	function Check() {
		var form = document.toorder;
		if (form.userID.value == "null"){
			alert("주문을 위해 로그인 해주세요!");
			return false;
		} else {
			if (form.total.value =="0"){
				alert("장바구니가 비어있습니다!");
				return false;
			} else{
				form.submit();
			}
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

ArrayList perfumeList = (ArrayList)session.getAttribute("perfumeList"); //상품들을 불러오기 위한 배열 세션
if (perfumeList==null) {
	perfumeList = new ArrayList<String>();
	session.setAttribute("perfumeList",perfumeList);
}

DecimalFormat deci = new DecimalFormat("###,###"); //금액 표시를 위한 포멧
%>	
<!-- 메뉴항목 userID를 통해 상품관리 메뉴 표시 -->
<nav class ="navbar navbar-default">
		<div class ="navbar-header">
			<button type ="button" class ="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-exmaple-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<h4>장바구니</h4>
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
					<!-- 관리자일 경우만 메뉴 표시 -->
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
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<%@ include file="dbconn.jsp" %>
	<%
		String id;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql =null;
		int total=0;
		int prices=0;
		int num=1;
	%>
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">사진</th>
						<th style="background-color: #eeeeee; text-align: center;">상품명</th>
						<th style="background-color: #eeeeee; text-align: center;">수량</th>
						<th style="background-color: #eeeeee; text-align: center;">수정</th>
						<th style="background-color: #eeeeee; text-align: center;">가격</th>
					</tr>
				</thead>
				<tbody>	
	<%
	for(int i=0;i<perfumeList.size(); i++) {
		id = (String)perfumeList.get(i);
    	sql = "Select * from perfume where p_id='" + id + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
		num=(Integer)session.getAttribute(id);
		prices=num*rs.getInt("p_unitPrice");
		total+=prices;
	%>	
					<tr>
						<td><img src="images/perfume/<%=rs.getString("p_fileName")%>" width = 100></td>
						<td>[<%=rs.getString("p_brand") %>]<br><%=rs.getString("p_unitName") %></td>
						<td><%=num %></td>
						<td><form name="updateNum" action="./updateCart.jsp?id" class="form-horizontal" method="get">
						<select name = "changeNum">
						<option value="del">삭제</option>
						<% for(int j=1; j<=rs.getInt("p_unitsInStock"); j++) { %>
						<option value="<%=j %>"><%=j %></option>
						<% } %> 												
						</select> <br>
						<input type="hidden" name="id" value="<%=id %>">
						<input type="submit" value="수정">
						</form></td>
						<td><%=deci.format(prices) %>원</td>
					</tr>
					<%}%>				
				</tbody>
			</table>
			<div align="right"><p>총 구매금액 : <%=deci.format(total) %>원</div>
			<div align="left" class="col-sm-2" ><a href="./delCart.jsp" class="btn btn-success"> 비우기 &raquo;</a> <form name="toorder" action="order.jsp" method="post">
			<input type="hidden" id="userID" value="<%=userID %>"><br>
			<input type="hidden" id="total" value="<%=total %>">
			<input type="button" class="btn btn-primary" value="주문하기&raquo" onclick="Check()"></form></div>
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