<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<h1 class="display-3">상품 등록</h1>
		</div>
	</div>
	<div class="container">
<form name="newBook" action="./processAddPerfume.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
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
				<input type="submit" class="btn btn-primary" value="등록" >
			</div>
		</div>
		
	</form>
	</div>
</body>
</html>