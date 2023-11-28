<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function check(){
		//alert("test");
		let form = document.form1;
		let score = form.score.value;
		
		//값이 입력되지 않았을 때, 문자가 입력됐을 때 처리
		if(score==""){
			alert("숫자를 입력해주세요.");
			score.focus();
			return false;
		}else{
			form.submit();
		}
	}
</script>
</head>
<body>
	<h3>점수를 입력해 주세요</h3>
	<form action ="core02.jsp" method="post" name="form1">
		<p>
			점수: <input type="text" name="score">
			<input type="submit" value="전송" onclick="check()">
		</p>
	</form>
</body>
</html>