<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KHmarket...</title>
</head>
<body>
	<%-- <%@ include file="header.jsp" %> --%>
	<jsp:include page="header.jsp" />
	<div class="container my-5">
		<h1 class="text-center">웹 마켓에 오신 것을 환영합니다.</h1>
		<div class="text-center my-4">
			<img src="resources/images/mal3.jpg" style="width:500px"
					alt="이미지" class="rounded">
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>