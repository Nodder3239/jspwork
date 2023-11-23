<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="addrBook" class="addressbook.AddrBook"/>
<jsp:setProperty property="*" name="addrBook"/>
<jsp:useBean id="abDAO" class="addressbook.AddrBookDAO" scope="application"/>


<% 
	abDAO.updateAddrBook(addrBook);
	
%>