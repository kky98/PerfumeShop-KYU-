<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import= "java.text.DecimalFormat"%>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css">
<title>Perfume Info</title>
</head>
<body>
<%
	String userID =null;
	if(session.getAttribute("userID") != null){
		userID =(String)session.getAttribute("userID");
	}
	ArrayList perfumeList = (ArrayList)session.getAttribute("perfumeList");
	if (perfumeList==null) {
		perfumeList = new ArrayList<String>();
		session.setAttribute("perfumeList",perfumeList);
	}
	DecimalFormat deci = new DecimalFormat("###,###");

	request.setCharacterEncoding("UTF-8");
	
	String userName = request.getParameter("userName");
	String userTel = request.getParameter("userTel");
	String postcode  = request.getParameter("postcode");
	String address = request.getParameter("address");
	String detailAddress = request.getParameter("detailAddress");
	String extraAddress = request.getParameter("extraAddress");
	String userAddr=postcode + " " + address + " " + detailAddress + " " + extraAddress;
%>
<!-- 여기부터 메뉴 기본 디자인 틀 및 구성 기능 -->
	<nav class ="navbar navbar-default">
		<div class ="navbar-header">
			<button type ="button" class ="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-exmaple-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<h4>주문확인/주문정보</h4>
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
<!-- 여기까지 메뉴 기본 디자인 틀 및 구성 기능 -->
	<%@ include file="dbconn.jsp" %>
	<%
		String id;
		PreparedStatement pstmt = null;
		PreparedStatement pstmtDel = null;
		ResultSet rs = null;
		String sql =null;
		String sqlDel = null;
		int total=0;
		int prices=0;
		int num=0;
		int updateNum=0;
		String perfId = null;
		String perfNum = null;
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
		updateNum=rs.getInt("p_unitsInStock")-num;
		sqlDel = "Update perfume SET p_unitsInStock=? Where p_id=?"; //퍼퓸테이블에서 제고수 관리
		pstmtDel = conn.prepareStatement(sqlDel);
		prices=num*rs.getInt("p_unitPrice");
		total+=prices;
	%>	
					<tr>
						<td><img src="images/perfume/<%=rs.getString("p_fileName")%>" width = 100></td>
						<td>[<%=rs.getString("p_brand") %>]<br><%=rs.getString("p_unitName") %></td>
						<td><%=num %></td>
						<% 
							if (perfId==null){
								perfId=rs.getString("p_id");
							} else {
								perfId=perfId + ',' + rs.getString("p_id");
							}
							if (perfNum==null){
								perfNum=Integer.toString(num);
							} else {
								perfNum=perfNum + ',' + Integer.toString(num);
							}
							pstmtDel.setLong(1, Long.valueOf(updateNum));
							pstmtDel.setString(2, id);
							pstmtDel.executeUpdate();
						%>
						<td><%=deci.format(prices) %>원</td>
					</tr>
					<%}%>				
				</tbody>
				<%
					//주문확인용 테이블
					sql = "insert into orders(orderId, orderName, orderTel, orderAddress, orderPerfumes, orderPerfumeNum) values(?,?,?,?,?,?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userID);
					pstmt.setString(2, userName);
					pstmt.setString(3, userTel);
					pstmt.setString(4, userAddr);
					pstmt.setString(5, perfId);
					pstmt.setString(6, perfNum);
					pstmt.executeUpdate();
				%>
				</table>
			<div align="right"><p>총 구매금액 : <%=deci.format(total) %>원<p> KB국민 710402-00-110853 예금주 : 서정환</div>				
		<div class="form-group row">
			<label class="col-sm-2">이름</label>
			<div class="col-sm-3">
				<%=userName %>
			</div>	
		</div>
		<div class="form-group row">
			<label class="col-sm-2">전화</label>
			<div class="col-sm-3">
				<%=userTel %>
			</div>	
		</div>
		<div class="form-group row">
			<label class="col-sm-2">주소</label>
			<div class="col-sm-3">
				<%=userAddr %>
			</div>	
		</div>
		</div>
	</div>
	<%
		for(int i=0; i<perfumeList.size(); i++){
			id=(String)perfumeList.get(i);
			session.removeAttribute(id);
		}
		perfumeList.clear();
	
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (pstmtDel != null)
			pstmtDel.close();
		if ( conn != null)
			conn.close();
	%>
</body>
</html>