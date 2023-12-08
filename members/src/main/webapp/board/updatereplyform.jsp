<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정 폼</title>
<link rel="stylesheet" href="../resources/css/style.css">
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id = "container">
		<section id="writeform">
			<h2>댓글 수정</h2>
			<hr>
			<form action="/updatereply.do?bno=${reply.bno }&rno=${reply.rno }" method="post">
				<!-- 'hidden'은 ui를 만들지 않고 데이터 숨겨서 보낼때 사용 -->
				<input type="hidden" name="rno" value="${reply.rno}">
				<input type="hidden" name="bno" value="${reply.bno }">
				<table>
					<tbody>
					<tr>
						<td><textarea rows="7" cols="100" name="rcontent">${reply.rcontent }</textarea></td>
					</tr>
					<tr>
						<td>${reply.replyer }</td>
					</tr>
						<tr>
							<td>
								<button type="submit">저장</button>
								<button type="reset">취소</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</section>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>