<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import= "java.text.DecimalFormat"%>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css">
<title>Perfume Info</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 다음 API -->
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
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
			<h4>주문작성</h4>
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
						<td><%=deci.format(prices) %>원</td>
						
					</tr>
					<%}%>				
				</tbody>
			</table>
			<div align="right"><p>총 구매금액 : <%=deci.format(total) %>원</div>						
		</div>
		<%
			sql = "Select * from user where userID='" + userID + "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
		%>
		<form name="oder" action="./processOrder.jsp" class="form-horizontal" method="post">
		<div class="form-group row">
			<label class="col-sm-2">이름 : </label>
			<div class="col-sm-3">
				<input type="text" id="userName" name="userName" class="form-control" value="<%=rs.getString("userName")%>">
			</div>	
		</div>
		<div class="form-group row">
			<label class="col-sm-2">전화 : </label>
			<div class="col-sm-3">
				<input type="text" id="userTel" name="userTel" class="form-control" value="<%=rs.getString("userTel")%>">
			</div>	
		</div>
		<div class="form-group row">
			<label class="col-sm-2">주소 : </label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="postcode" name="postcode" placeholder="우편번호"> <br>
				<input type="button" class="btn btn-success" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br><br>
				<input type="text" class="form-control" id="address" name="address" placeholder="주소"><br>
				<input type="text" class="form-control" id="detailAddress" name="detailAddress" placeholder="상세주소"> <br>
				<input type="text" class="form-control" id="extraAddress" name="extraAddress" placeholder="참고항목">
			</div>	
		</div>
		<div align="left" ><a href="./cart.jsp" class="btn btn-success">주문취소 &raquo;</a> <input type="submit" class="btn btn-primary" value="주문확정 &raquo" ></div>
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