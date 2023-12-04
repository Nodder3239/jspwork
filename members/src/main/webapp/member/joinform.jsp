<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="/resources/css/style.css">
<script>
	function checkMember(){
		//alert("test...");
		//input name 속성을 변수에 할당
		let form = document.member;	//폼 이름
		let id = form.id.value;
		let pw1 = form.passwd.value;
		let pw2 = form.passwd2.value;
		let name = form.name.value;
		
		//정규 표현식
		//비밀번호
		let legexPw1 = /[0-9]+/;	//숫자
		let legexPw2 = /[a-zA-Z]+/;	//영문자
		let legexPw3 = /[~!@#$%^&*()`0-=\_+|]+/;	//특수문자
		
		//이름
		let legexName =/^[가-힣]+$/	//한글만
		
		if(id.length < 4 || id.length > 15){
			alert("아이디는 4~15자까지 입력 가능합니다.");
			id.select();
			return false;
		}else if(pw1.length < 8 || !regexPw1.test(pw1) || !regexPw2.test(pw2) || !regexPw3.test(pw3)){
			alert("비밀번호는 영문자, 숫자, 특수문자 포함해서 8자 이상 입력 가능합니다.");
			pw1.select();
			return false;
		}else if(pw1 != pw2){	//pw1과 pw2 문자열이 일치하지 않으면
			alert("비밀번호가 일치하지 않습니다.");
			pw2.select();
		}else if(!regexName(name)){
			alert("이름은 한글만 가능합니다.");
			name.select();
		}else{
			form.submit();	//오류가 없으면 폼을 메인컨트롤러로 전송
		}	
	}
</script>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id = "container">
		<section id="join">
			<h2>회원 가입</h2>
			<hr>
				<form action="/insertmember.do" method="post" name="member">
					<fieldset>
						<ul>
							<li>
								<label for="id">아이디</label>
								<input type="text" id="id" name="id" placeholder="4~15까지 입력 가능">
							</li>
							<li>
								<label for="passwd">비밀번호</label>
								<input type="password" id="passwd" name="passwd" placeholder="8자 이상 입력 가능">
							</li>
							<li>
								<label for="passwd2">비밀번호 확인</label>
								<input type="password" id="passwd2" name="passwd2" placeholder="비밀번호 재입력">
							</li>
							<li>
								<label for="name">이름</label>
								<input type="text" id="name" name="name" placeholder="한글 입력" >
							</li>
							<li>
								<label for="email">이메일</label>
								<input type="text" id="email" name="email" placeholder="@" >
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
						<button type="button" onclick="checkMember()">가입</button>
						<button type="reset">취소</button>
					</div>
				</form>
		</section>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>