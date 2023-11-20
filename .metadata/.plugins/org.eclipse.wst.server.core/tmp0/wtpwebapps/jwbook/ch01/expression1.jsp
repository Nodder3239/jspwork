<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 짝수/홀수를 판변하는 프로그램 -->
	<%
		int num = 31;
		String result;
		
		if(num%2==0) result = "짝수";
		else result="홀수";
	%>
	<p>결과는 <%=result %> 입니다.</p>
</body>
</html>