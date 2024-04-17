<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 세션변수 loginCustomer
			
	
	if (session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
%>
<%
	String mail = request.getParameter("mail");
	System.out.println(mail);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<form method = "post" action = "/shop/customer/editPwAction.jsp">
		<table>
			<tr>	
				<td>mail: </td>
				<td><input type = "text" name = mail value=<%=mail%> readonly = "readonly"></td>
			</tr>
			<tr>	
				<td>이전 비밀번호: </td>
				<td><input type = "password" name = "oldPw"></td>
			</tr>
			<tr>	
				<td>변경할 비밀번호:</td>
				<td><input type = "password" name = "newPw"></td>
			</tr>
		</table>
		<button type = "submit">수정하기</button>
	</form>
</body>
</html>