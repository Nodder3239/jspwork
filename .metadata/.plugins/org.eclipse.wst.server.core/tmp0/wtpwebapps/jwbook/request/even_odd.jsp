<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>짝수/홀수 판정 프로그램</title>
<style type="text/css">
	ul li{list-style: none; margin: 10px;}
</style>
</head>
<body>
	<form action="calcProcess.jsp" method="post">
		<ul>
			<li>
				<label for="num">숫자 </label>
				<input type="text" id="num" name="num">
				<button type="submit">계산</button>
			</li>
		</ul>
	</form>
</body>
</html>