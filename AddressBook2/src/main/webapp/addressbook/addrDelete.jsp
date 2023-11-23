<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="abDAO" class="addressbook.AddrBookDAO" scope="application"/>
<% 
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	abDAO.deleteAddrBook(bnum);
	
	//삭제 후 페이지 이동(redirect - 리다이렉트)
	response.sendRedirect("addrList.jsp");
%>