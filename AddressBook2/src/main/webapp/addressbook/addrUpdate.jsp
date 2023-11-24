<%@page import="addressbook.AddrBook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 정보</title>
<link rel="stylesheet" href="../resources/css/style.css">
</head>
<body>
	<jsp:useBean id="abDAO" class="addressbook.AddrBookDAO" scope="application"/>
	<%
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		AddrBook addrBook = abDAO.getAddrBook(bnum);
	%>
	<div id="container">
		<h2>주소 수정</h2>
		<hr>
		<form action="addrUpdateProcess.jsp" method="post">
			<table id="tbl_view">
				<tr>
					<td>번호</td>
					<td><input type="text" name="bnum" value=<%=addrBook.getBnum() %> readonly></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="username" value=<%=addrBook.getUsername() %> required></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="tel" value=<%=addrBook.getTel() %> required></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value=<%=addrBook.getEmail() %> required></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<%if(addrBook.getGender().equals("남")){ %>
							<input type="radio" name="gender" value="남" checked>남
							<input type="radio" name="gender" value="여">여
						<%}else{%>
							<input type="radio" name="gender" value="남">남
							<input type="radio" name="gender" value="여" checked>여
						<%}%>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="저장">
						<input type="reset" value="취소">
						<a href="addrList.jsp">
							<button type="button">목록</button>
						</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>