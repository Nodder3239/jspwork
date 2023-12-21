<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<link rel="stylesheet" href="../resources/css/style.css">
<script src="https://kit.fontawesome.com/69798321c6.js"></script>

</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id = "container">
		<section id="boardlist">
			<h2>게시판 시안</h2>
			<p>게시판에 맞는 정보를 공유해주세요.</p>
			<hr>
			<table>
				<thead>
					<tr>
						<th>번호</th><th id=btitle>제목</th><th>작성자</th><th>작성일</th><th>조회수</th><th>좋아요</th>
					</tr>
				</thead>
				<tbody>
				<tr class="medal">
					<td><i class="fa-solid fa-medal" style="color: #ffd500;"></i></td>
					<td id="btitle"><a href="/boardview.do?bno=${l1.bno }">${l1.title }
					<c:if test="${l1.reply_count ne 0}">
						<small>[&nbsp;<c:out value="${l1.reply_count}"/>&nbsp;]</small>
					</c:if>
					</a></td>
					<td>${l1.id }</td>
					<td>
						<c:choose>
							<c:when test="${not empty l1.modifyDate }">
								<fmt:formatDate value="${l1.modifyDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${l1.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td>${l1.hit }</td>
					<td>${l1.like_count }</td>
				</tr>
				<tr class="medal">
					<td><i class="fa-solid fa-medal" style="color: #dedede;"></i></td>
					<td id="btitle"><a href="/boardview.do?bno=${l2.bno }">${l2.title }
					<c:if test="${l2.reply_count ne 0}">
						<small>[&nbsp;<c:out value="${l2.reply_count}"/>&nbsp;]</small>
					</c:if>
					</a></td>
					<td>${l2.id }</td>
					<td>
						<c:choose>
							<c:when test="${not empty l2.modifyDate }">
								<fmt:formatDate value="${l2.modifyDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${l2.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td>${l2.hit }</td>
					<td>${l2.like_count }</td>
				</tr>
				<tr class="medal">
					<td><i class="fa-solid fa-medal" style="color: #a85a00;"></i></td>
					<td id="btitle"><a href="/boardview.do?bno=${l3.bno }">${l3.title }
					<c:if test="${l3.reply_count ne 0}">
						<small>[&nbsp;<c:out value="${l3.reply_count}"/>&nbsp;]</small>
					</c:if>
					</a></td>
					<td>${l3.id }</td>
					<td>
						<c:choose>
							<c:when test="${not empty l3.modifyDate }">
								<fmt:formatDate value="${l3.modifyDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${l3.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td>${l3.hit }</td>
					<td>${l3.like_count }</td>
				</tr>
				<c:forEach items="${boardList }" var="b">
				<tr>
					<td>${b.bno }</td>
					<td id="btitle"><a href="/boardview.do?bno=${b.bno }">${b.title }
					<c:if test="${b.reply_count ne 0}">
						<small>[&nbsp;<c:out value="${b.reply_count}"/>&nbsp;]</small>
					</c:if>
					</a></td>
					<td>${b.id }</td>
					
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
					<td>${b.like_count }</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</section>
		<section id="bottomlist">
			<div>
				<!-- 페이지 처리 영역 -->
				<div class = "pagination">
					<a href="/boardlist.do?pageNum=1"><i class="fa-solid fa-forward fa-rotate-180"></i></a>
					<c:choose>
					<c:when test="${startPage > 1 }">
					<a href="/boardlist.do?pageNum=${startPage-1}"><i class="fa-solid fa-play fa-rotate-180"></i></a>
					</c:when>
					<c:otherwise>
					<a href=""><i class="fa-solid fa-play fa-rotate-180"></i></a>
					</c:otherwise>
					</c:choose>
					<!-- 페이지 리스트 -->
					<c:forEach var = "i" begin = "1" end = "${endPage}">
						<c:if test="${page == i}">
							<a href="/boardlist.do?pageNum=${i}"><b>${i}</b></a>
						</c:if>
						<c:if test="${page != i}">
							<a href="/boardlist.do?pageNum=${i}">${i}</a>
						</c:if>
					</c:forEach>
					<!-- 다음페이지 -->
					<c:choose>
					<c:when test="${endPage > startPage }">
					<a href="/boardlist.do?pageNum=${startPage+1}"><i class="fa-solid fa-play"></i></a>
					</c:when>
					<c:otherwise>
					<a href=""><i class="fa-solid fa-play"></i></a>
					</c:otherwise>
					</c:choose>
					<a href="/boardlist.do?pageNum=${endPage}"><i class="fa-solid fa-forward"></i></a>	
				</div>
				<form action="" method="get">
					<div id="search">
						<select name="field">
							<option value="title" ${(field eq "title") ? "selected" : "" }>제목</option>
							<option value="content" ${(field eq "content") ? "selected" : "" }>내용</option>
							<option value="id" ${(field eq "id") ? "selected" : "" }>작성자</option>
						</select>
						<input type="text" id="kw" name="kw" value="${kw }">
						<button type="submit" class="searchBtn"><i class="fa-solid fa-magnifying-glass"></i></button>
						<a href="writeform.do"><button type="button" class="writeBtn">글 작성</button></a>
					</div>
				</form>
			</div>						
		</section>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>