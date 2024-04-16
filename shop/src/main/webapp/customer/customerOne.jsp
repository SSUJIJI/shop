<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//로그인 세션변수 loginCustomer
			
	
	if (session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	} 
%>

<%
	String name = request.getParameter("name");
	System.out.println(name);
	String mail = request.getParameter("mail");

	
	ArrayList<HashMap<String, Object>> custOne = CustomerDAO.selectCustOne(name);
	
	
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
		<%
			for(HashMap<String, Object> m : custOne){
		%>		
			<tr>
				<td>mail: </td>
				<td><%=(String)(m.get("mail")) %></td>
			</tr>
			<tr>
				<td>pw: </td>
				<td><%=(String)(m.get("pw")) %></td>
				<td><a href = "/shop/customer/editPwForm.jsp?mail=<%=(String)(m.get("mail")) %>&name=<%=(String)(m.get("name")) %>">비밀번호 수정</a></td>
			</tr>
				<tr>
				<td>name: </td>
				<td><%=(String)(m.get("name")) %></td>
			</tr>
			<tr>
				<td>birth: </td>
				<td><%=(String)(m.get("birth")) %></td>
			</tr>
			<tr>
				<td>gender: </td>
				<td><%=(String)(m.get("gender")) %></td>
			</tr>
			<tr>
				<td>updateDate: </td>
				<td><%=(String)(m.get("updateDate")) %></td>
			</tr>
			<tr>
				<td>createDate: </td>
				<td><%=(String)(m.get("createDate")) %></td>
			</tr>
			<tr>
				<td><a href = "/shop/customer/dropCustomerAction.jsp?mail=<%=(String)(m.get("mail")) %>&pw=<%=(String)(m.get("pw"))%>">회원탈퇴</a></td>
			</tr>
		<%
			}
		%>
		
		</table>
	</form>
	
</body>
</html>