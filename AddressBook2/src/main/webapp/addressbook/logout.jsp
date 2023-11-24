<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	out.println("<script>");
	out.println("alert('로그아웃 되었습니다.')");
 	out.println("location.href='../index.jsp'");
	out.println("</script>");
	//모든 세션 삭제
	session.invalidate();
	//로그아웃 후 인덱스로 이동
	//response.sendRedirect("../index.jsp");	//스크립트보다 우선 처리?
%>