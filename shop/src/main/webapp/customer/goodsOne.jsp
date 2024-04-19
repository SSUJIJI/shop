<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="customer.dao.*" %>
<%@ page import = "java.util.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginCustomer
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
 	
%>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	System.out.println(goodsNo + "<-goodsNo");
	
	
	HashMap<String,Object> goodslist = GoodsDAO.selectGoodsOne(goodsNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<form method = "post" action = "/shop/customer/addOrdersAction.jsp">
		<table>
			<tr>
				<td><input type="hidden" name = "goodsNo" value= "<%=(String)(goodslist.get("goodsNo")) %>"></td>
			</tr>
			<tr>
				<td>category: </td>
				<td><%=(String)(goodslist.get("category"))%></td>
			</tr>
			<tr>
				<td>goodsTitle: </td>
				<td><%=(String)(goodslist.get("goodsTitle")) %></td>
				<td><input type="hidden" name = "goodsTitle" value= "<%=(String)(goodslist.get("goodsTitle")) %>"></td>
			</tr>
			<tr>
				<td>filename: </td>
				<td><img src = "/shop/upload/<%=(String)(goodslist.get("filename"))%>" width = 100></td>
			</tr>
			<tr>	
				<td>goodsContent: </td>
				<td><%=(String)(goodslist.get("goodsContent")) %></td>
				
			<tr>
				<td>goodsPrice: </td>
				<td><%=(Integer)(goodslist.get("goodsPrice")) %></td>
				<td><input type="hidden" name = "goodsPrice" value= "<%=(Integer)(goodslist.get("goodsPrice")) %>"></td>
				
			</tr>
			<tr>
				<td>goodsAmount: </td>
				<td><input type = "number" name = "goodsAmount"></td>
			</tr>
			<tr>
				<td>goodsColor: </td>
				<td><select name = "goodsColor">
					<option value = "">--color--</option>
					<option value = "white">white</option>
					<option value = "yellow">yellow</option>
					<option value = "black">black</option>
				</select></td>
			</tr>
			<tr>
				<td>address: </td>
				<td>
					<textarea rows="2" cols="10" name = "address"></textarea>
				</td>
			</tr>
			<tr>		
				<td><button type = "submit">주문하기</button></td>
			</tr>
		</table>
	</form>
</body>
</html>