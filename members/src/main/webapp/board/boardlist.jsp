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
<script src="https://kit.fontawesome.com/69798321c6.js"></script>

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
						<th>글번호</th><th id=btitle>글제목</th><th>작성일</th><th>조회수</th><th>아이디</th><th>좋아요</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${boardList }" var="b">
				<tr>
					<td>${b.bno }</td>
					<td id="btitle"><a href="/boardview.do?bno=${b.bno }">${b.title }
					<c:if test="${b.reply_count ne 0}">
						<small>[&nbsp;<c:out value="${b.reply_count}"/>&nbsp;]</small>
					</c:if>
					</a></td>
					
					<!-- 수정일이 있을 경우 수정 날짜값이 표시되도록 함 -->
					<td>
						<c:choose>
							<c:when test="${not empty b.modifyDate }">
								<fmt:formatDate value="${b.modifyDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${b.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:otherwise>
						</c:choose>
						<!-- 
						<c:if test="${not empty b.modifyDate }">
							<fmt:formatDate value="${b.modifyDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
						</c:if>
						<c:if test="${empty b.modifyDate }">
							<fmt:formatDate value="${b.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
						</c:if>
						 -->
					</td>
					<td>${b.hit }</td>
					<td>${b.id }</td>
					<td>${b.like_count }</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
			<!-- 글쓰기 버튼 -->
			<div>
				<a href="writeform.do"><button type="button" class="btn">글쓰기</button></a>
				<!-- 페이지 내비게이터 -->
				<a href=""><i class="fa-solid fa-forward fa-rotate-180"></i></a>
				<a href=""><i class="fa-solid fa-play fa-rotate-180"></i></a>
				<a href="">0</a>
				<a href=""><i class="fa-solid fa-play"></i></a>
				<a href=""><i class="fa-solid fa-forward"></i></a>
			</div>
			<!-- 검색 -->
			<form action="/search.do" method="post">
				<div id="search">
					<input type="text" id="query" name="query">
					<button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
				</div>
			</form>
		</section>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>