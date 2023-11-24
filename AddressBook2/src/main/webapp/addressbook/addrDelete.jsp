<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="abDAO" class="addressbook.AddrBookDAO" scope="application"/>
<% 
	//선택한 번호를 받음
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	//삭제 처리 메서드 호출
	abDAO.deleteAddrBook(bnum);
	
	//삭제 후 페이지 이동(redirect - 리다이렉트)
	//response.sendRedirect("addrList.jsp");
	out.println("<script>");
	out.println("alert('삭제 되었습니다.')");
	out.println("location.href='addrList.jsp'");
	out.println("</script>");
%>