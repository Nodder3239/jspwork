<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<div id = "container">
		<section id="memberlist">
			<h2>회원 목록</h2>
			<hr>
			<table>
				<thead>
					<tr>
						<th>번호</th><th>제목</th><th>아이디</th><th>작성일</th><th>작성시간</th>
					</tr>
				</thead>
				<c:forEach items="${boardlist }" var="b">
				<tr>
				<!-- m.mno - m.getMno()와 같음 -->
					<td>${b.bno }</td>
					<!-- 타이틀을 클릭하면 상세보기로 이동함 -->
					<td><a href="/boardview.jsp?bno=${b.bno }">${b.bTitle }</a></td>
					<td>${b.id }</td>
					<td><fmt:formatDate value="${m.joinDate }" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${m.joinDate }" pattern="HH:mm:ss"/></td>
				</tr>
				</c:forEach>
			</table>
		</section>
	</div>
</body>
</html>