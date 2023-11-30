<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id = "container">
		<section id="boardlist">
			<h2>게시글 목록</h2>
			<hr>
			<table>
				<thead>
					<tr>
						<th><label for="title">제목</label></th>
						<th>${board.title }</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><label for="content">내용</label></td>
						<td>${board.content }</td>
					</tr>
					<tr>
						<td><label for="id">아이디</label></td>
						<td>${board.id }</td>
					</tr>
				</tbody>
			</table>
			
		</section>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>