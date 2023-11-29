<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id = "container">
		<section id="join">
			<h2>회원 가입</h2>
			<hr>
				<form action="/insertmember.do" method="post">
					<fieldset>
						<ul>
							<li>
								<label for="id">아이디</label>
								<input type="text" id="id" name="id" required>
							</li>
							<li>
								<label for="passwd">비밀번호</label>
								<input type="password" id="passwd" name="passwd" required>
							</li>
							<li>
								<label for="passwd2">비밀번호 확인</label>
								<input type="password" id="passwd2" name="passwd2" required>
							</li>
							<li>
								<label for="name">이름</label>
								<input type="text" id="name" name="name" required>
							</li>
							<li>
								<label for="email">이메일</label>
								<input type="text" id="email" name="email" required>
							</li>
							<li>
								<label for="gender">성별</label>
								<input type="radio" id="gender" 
									name="gender" value="남" checked>남
								<input type="radio" id="gender" 
									name="gender" value="여">여
														
							</li>
						</ul>
					</fieldset>
					<div>
						<button type="submit">가입</button>
						<button type="reset">취소</button>
					</div>
				</form>
		</section>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>