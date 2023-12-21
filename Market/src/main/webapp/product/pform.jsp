</a><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script src="../resources/js/validation.js"></script>
</head>
<body>
<jsp:include page="../header.jsp"/>
	<div class="container my-3">
	<h2>상품 등록</h2>
	<div class = "row">
	<form action="/insertproduct.do" method="post"
				enctype="multipart/form-data" name="newProduct">
		<div class="form-group row my-3">
			<label class="col-2">상품코드</label>
			<div class="col-3">
				<input type="text" id="pid" name="pid" class="form-control">
			</div>
		</div>
		<div class="form-group row my-3">
			<label class="col-2">상품명</label>
			<div class="col-3">
				<input type="text" id="pname" name="pname" class="form-control">
			</div>
		</div>
		<div class="form-group row my-3">
			<label class="col-2">가격</label>
			<div class="col-3">
				<input type="text" id="price" name="price" class="form-control">
			</div>
		</div>
		<div class="form-group row my-3">
			<label class="col-2">상품설명</label>
			<div class="col-4">
				<textarea rows="3" cols="40" 
					name="description" class="form-control"></textarea>
			</div>
		</div>
		<div class="form-group row my-3">
			<label class="col-2">카테고리</label>
			<div class="col-3">
				<input type="text" name="category" class="form-control">
			</div>
		</div>
		<div class="form-group row my-3">
			<label class="col-2">재고 수</label>
			<div class="col-3">
				<input type="text" name="pstock" class="form-control">
			</div>
		</div>
		<div class="form-group row my-3">
			<label class="col-2">상태</label>
			<div class="col-3">
				<label><input type="radio" name="condition" value="New" checked>신상품</label>
				<label><input type="radio" name="condition" value="Old">중고품</label>
			</div>
		</div>
		<div class="form-group row my-3">
			<label class="col-2">상품이미지</label>
			<div class="col-3">
				<input type="file" name="pimage" class="form-control">
			</div>
		</div>
		<div class="form-group row my-3">
			<div class="col-3">
				<input type="button" value="등록" class="btn btn-success" 
						onclick="checkProduct()">
			</div>
		</div>
	</form>
	</div>
	</div>
<jsp:include page="../footer.jsp"/>
</body>
</html>