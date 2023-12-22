<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<div class="container my-3">
	  <h2>주문 완료</h2>
	  <h3>주문해주셔서 감사합니다.</h3>
	<p>주문은 ${shipping_shippingdate }에 배송될 예정입니다.
	<p>주문 번호: ${shipping_cartId }
	<p><a href="/productlist.do">상품 목록</a>
	 </div>
	<jsp:include page="../footer.jsp" />
</body>
</html>