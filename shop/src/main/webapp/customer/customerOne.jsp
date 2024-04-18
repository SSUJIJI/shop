<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%@ page import = "java.util.*" %>
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

	
	HashMap<String, Object> custOne = CustomerDAO.selectCustOne(mail);
	
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<form>
		<table>	
			<tr>
				<td>mail: </td>
				<td><%=(String)(custOne.get("mail")) %></td>
			</tr>
			<tr>
				<td>pw: </td>
				<td><a href = "/shop/customer/editPwForm.jsp?mail=<%=(String)(custOne.get("mail")) %>">비밀번호 수정</a></td>
			</tr>
				<tr>
				<td>name: </td>
				<td><%=(String)(custOne.get("name")) %></td>
			</tr>
			<tr>
				<td>birth: </td>
				<td><%=(String)(custOne.get("birth")) %></td>
			</tr>
			<tr>
				<td>gender: </td>
				<td><%=(String)(custOne.get("gender")) %></td>
			</tr>
			<tr>
				<td>updateDate: </td>
				<td><%=(String)(custOne.get("updateDate")) %></td>
			</tr>
			<tr>
				<td>createDate: </td>
				<td><%=(String)(custOne.get("createDate")) %></td>
			</tr>
			<tr>
				<td><a href = "/shop/customer/dropCustomerAction.jsp?mail=<%=(String)(custOne.get("mail")) %>&pw=<%=(String)(custOne.get("pw"))%>&name=<%=(String)(custOne.get("name"))%>">회원탈퇴</a></td>
			</tr>
		</table>
	</form>
	
</body>
</html>