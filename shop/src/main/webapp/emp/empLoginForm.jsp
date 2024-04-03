<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	
	
	
	if (session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	} 
	
	String errMsg = request.getParameter("errMsg");
%>




<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<h1>Login</h1>
	<div>
	<%
		if(errMsg != null){
	%>	
			<%=errMsg %>
	<%
		}
	%>
		</div>
	<form method = "post" action = "/shop/emp/empLoginAction.jsp"> 
		<table>
			<tr>
				<td>login: </td>
				<td><input type = "text" name = "empId"></td>
			</tr>
			<tr>
				<td>password: </td>
				<td><input type = "password" name = "empPw"></td>
			</tr>
	
		</table>
			<button type = "submit">login</button>
	</form>
</body>
</html>