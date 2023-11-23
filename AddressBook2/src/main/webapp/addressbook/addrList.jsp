<%@ page import="addressbook.AddrBook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록 목록</title>
<link rel="stylesheet" href="../resources/css/style.css">
</head>
<body>
	<jsp:useBean id="abDAO" class="addressbook.AddrBookDAO" scope="application"/>
	<div id="container">
		<h2>주소 목록</h2>
		<hr>
		<p>
			<a href="addrForm.jsp">[주소추가]</a>&nbsp;&nbsp;
			<a href="logout.jsp">[로그아웃]</a>
		</p>
		
		<table id="tbl_list">
			<thead>
				<tr>
					<th>번호</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>성별</th>
					<th>등록일</th>
					<th>보기</th>			
				</tr>
			</thead>
			<%
				/* abDAO.getListAll() : addrList와 같음 */
				for(int i=0; i<abDAO.getListAll().size(); i++){
					AddrBook addrBook = abDAO.getListAll().get(i);
			%>
			<tbody>
				<tr>
					<td><%=addrBook.getBnum() %></td>
					<td><%=addrBook.getUsername() %></td>
					<td><%=addrBook.getTel() %></td>
					<td><%=addrBook.getEmail() %></td>
					<td><%=addrBook.getGender() %></td>
					<td><%=addrBook.getRegDate() %></td>
					<td>
						<a href="addrView.jsp?bnum=<%=addrBook.getBnum()%>">
							<button type="button">보기</button>
						</a>
					</td>
				</tr>
			</tbody>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>