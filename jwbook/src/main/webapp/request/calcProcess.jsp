<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

    
<%
    String num = request.getParameter("num");
	String regex = "[0-9]+";	//숫자만
	String result = "";		//문자열 변수를 전역 변수로 선언
	
	/* Pattern.mached(정규표현식, 문자열) */
	if(num == "" || !Pattern.matches(regex, num)){	//빈 문자 처리, 문자 입력 시 오류 처리
		out.println("<script>");
		out.println("alert('숫자를 입력하세요')");
		out.println("history.back()");	//이전 페이지로 이동
		out.println("</script>");
	}else{
		int n = Integer.parseInt(num);	//문자를 숫자로 변환
		if(n % 2 == 0){
			result = "짝수";
		}else{
			result = "홀수";
		}
	}


%>
<h3>홀수/짝수를 판별하는 프로그램</h3>
<p>결과는 <%=result %>입니다.</p>