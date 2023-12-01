<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세보기</title>
<script src="https://kit.fontawesome.com/69798321c6.js"></script>
<link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id = "container">
		<section id="boardview">
			<h2>글 상세보기</h2>
			<hr>
			<table>
				<tbody>
					<tr>
						<td><input type="text" name="title" value="${board.title }" readonly></td>
					</tr>
					<tr>
						<td><textarea rows="7" cols="100" name="content" readonly>${board.content }</textarea></td>
					</tr>
					<tr>
						<td id=writer>${board.id }</td>
					</tr>
					<tr>
						<td>
						<a href="/boardlist.do"><button type="button">목록</button></a>
						<c:if test="${sessionId eq board.id }">
							<a href="/deleteboard.do?bno=${board.bno }"
								onclick="return confirm('정말로 삭제하시겠습니까?')">
							<button type="button">삭제</button></a>
							<a href="/updateboardform.do?bno=${board.bno }"><button type="button">수정</button></a>
						</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- 댓글 영역 -->
			<h3><i class="fa-regular fa-pen-to-square"> 댓글</i></h3>
			<c:forEach items="${replyList }" var="reply">
			<div class="reply">
				<p>${reply.rcontent }</p>
				<p>작성자: ${reply.replyer } (작성일: <fmt:formatDate value="${reply.rdate }" pattern="yyyy-MM-dd HH:mm:ss"/> ) 
				<c:if test="${sessionId eq reply.replyer }">
				<a href="/deletereply.do?bno=${board.bno }&rno=${reply.rno }"
							onclick="return confirm('댓글을 삭제하시겠습니까?')">
				<button type="button" id=DR><i class="fa-solid fa-trash-can"></i></button></a>
				<a href="/updatereplyform.do?bno=${board.bno }&rno=${reply.rno }">
				<button type="button" id=DR><i class="fa-solid fa-pen"></i></button></a>
				</c:if>
				</p>
			</div>
			</c:forEach>
			
			<c:if test="${not empty sessionId}">
			<!-- 댓글 등록 -->
				<form action="/insertreply.do" method="post" id="replyform">
					<input type="hidden" name="bno" value="${board.bno }">
					<input type="hidden" name="replyer" value="${sessionId }">
					<p>
						<textarea rows="4" cols="50" name="rcontent"
							placeholder="댓글 작성란"></textarea>
					</p>
					<button type="submit">등록</button>
				</form>		
			</c:if>
			<!-- 로그인한 사용자만 댓글 등록 가능 -->
			<c:if test="${empty sessionId}">
				<div class="replylogin">
					<a href="/loginform.do"><i class="fa-solid fa-user"> 로그인한 사용자만 댓글 등록이 가능합니다.</i></a>
				</div>	
			</c:if>
			
		</section>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>