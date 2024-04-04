<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	} 
 	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<form method = "post" action = "/shop/emp/addCategoryAction.jsp">
		<table>
			<tr>
				<td>category:</td>
				<td><input type = "text" name = "category"></td>
				<td><input type = "hidden" name = "createDate"></td>
			</tr>
		</table>
		<button type = "submit">추가하기</button>
	</form>
</body>
</html>