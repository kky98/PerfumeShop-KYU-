<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Perfume Register</title>
</head>
<body>
<body>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 수정</h1>
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
			<div class="col-md-5">
				<img src="c:/upload/<%=rs.getString("p_fileName")%>" width = 300>
			</div>
<form name="renewPerfum" action="./processUpdatePerfume.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
		<div class="form-group row">
			<label class="col-sm-2">향수코드</label>
			<div class="col-sm-3">
				<input type="text" id="p_id" name="p_id" class="form-control" value="<%=rs.getString("p_id")%>">
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
				<p> 현재 파일 : [c:/upload/<%=rs.getString("p_fileName")%>]
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10 ">
				<input type="submit" class="btn btn-primary" value="등록" >
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