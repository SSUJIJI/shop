<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsColor = request.getParameter("goodsColor");
	System.out.println(goodsTitle);
	System.out.println(goodsPrice);
	System.out.println(goodsAmount);
	System.out.println(goodsColor);
	
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
				<td><input type="hidden" name = goodsNo value= goodsNo></td>
			</tr>
			<tr>
				<td>mail:</td>
				<td>
					<%	
						HashMap<String,Object> loginMember 
						= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
						if (loginMember != null) {
					%>
						<%=(String)(loginMember.get("mail")) %>
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<td>goodsTitle: </td>
				<td><input type="hidden" name = goodsTitle><%=goodsTitle %></td>
			</tr>
			<tr>
				<td><input type="hidden" name = goodsAmount value= goodsAmount></td>
			</tr>
			<tr>
				<td>totalPrice: </td>
				<td>
					<%
						int totalPrice = 0;
						if(goodsAmount>=0){
							totalPrice = goodsPrice*goodsAmount;
						}
					%>
					<%=totalPrice %>
				</td>
			</tr>
			<tr>
				<td>goodsColor: </td>
				<td><input type="hidden" name = goodsColor><%=goodsColor %></td>
			</tr>		
			<tr>
				<td>address: </td>
				<td>
					<textarea rows="2" cols="10" name = address></textarea>
				</td>
			</tr>
			<tr>
				<td><button type = "submit">주문하기</button></td>
			</tr>
		</table>
	</form>
</body>
</html>