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
<link rel="stylesheet" href="../resources/css/style.css">
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
						
					</tr>
					<tr>
						<td>
							<div>
							<c:if test="${not empty board.filename }">
								<img src="../upload/${board.filename }" alt="" style="width:100%">
							</c:if>
							</div>
							${board.content }
						</td>
					</tr>
					<tr>
						<td class = "left">
							<c:choose>
								<c:when test="${not empty board.filename}">
									<c:if test="${not empty sessionId}">
										첨부파일: ${board.filename }<a href="/filedown.do?filename=${board.filename }">&nbsp;[다운로드]</a>
									</c:if>
									<c:if test="${empty sessionId}">
										<c:out value="첨부파일은 로그인 후 확인 가능합니다. "/>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:out value="첨부파일: - "/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td id=writer>${board.id }
						<%--<c:if test="${not empty sessionId}">
							<div id="likeSection">
								 <form action="/like.do?bno=${board.bno }&id=${sessionId}" method="post">
								    <c:choose>
										<c:when test= "${ n eq true}">
											<button type="submit" id="DR"><i class="fa-solid fa-heart" style="color: #ff0000;"></i></button>
										</c:when>
										<c:otherwise>
											<button type="submit" id="DR"><i class="fa-regular fa-heart" style="color: #ff0000;"></i></button>
										</c:otherwise>
									</c:choose> 
								</form> 
								<!-- 좋아요 개수를 표시하는 부분 -->
								<div id="likeCount">좋아요: ${like_count }개</div>
							</div>
						</c:if>--%>
						</td>
					</tr>
					<tr>
						<td>
							조회수 : ${board.hit}&nbsp;&nbsp;&nbsp;&nbsp;
							<!-- 좋아요 영역 -->
							<c:choose>
								<c:when test = "${empty sessionId }">
									<span><i class="fa-solid fa-heart" style="color: #000000;"></i></span>
									<span>${voteCount }</span>
									<a href="#" onclick="location.href = '/loginform.do' ">(좋아요는 로그인이 필요합니다.)</a>
								</c:when>
								<c:otherwise>
									<!-- 하트 상태 바꾸기 -->
									<c:choose>
										<c:when test="${sw eq true }">
											<span>
												<a href="/like.do?bno=${board.bno }&id=${sessionId}"><i class="fa-regular fa-heart" style="color: #ff0000;"></i></a>
											</span>
										</c:when>
										<c:otherwise>
											<span>
												<a href="/like.do?bno=${board.bno }&id=${sessionId}"><i class="fa-solid fa-heart" style="color: #ff0000;"></i></a>
											</span>
										</c:otherwise>
									</c:choose>
									<span>${voteCount }</span>
								</c:otherwise>							
							</c:choose>
						</td>
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
			<div id="re">
			<h3><i class="fa-regular fa-pen-to-square"> 댓글</i></h3>
			<c:forEach items="${replyList }" var="reply">
			<div class="reply">
				<p>${reply.rcontent }</p>
				<p>작성자: ${reply.replyer } (작성일: 
					<c:choose>
							<c:when test="${not empty reply.rupdate }">
								<fmt:formatDate value="${reply.rupdate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${reply.rdate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:otherwise>
					</c:choose> 
				) 
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
			
			<!-- 댓글 등록 -->
			<c:if test="${not empty sessionId}">
				<form action="/insertreply.do" method="post" id="replyform">
					<input type="hidden" name="bno" value="${board.bno }">
					<input type="hidden" name="replyer" value="${sessionId }">
					<p>
						<textarea rows="4" cols="100" name="rcontent"
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
			</div>
		</section>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>