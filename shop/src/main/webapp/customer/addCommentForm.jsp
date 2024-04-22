<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	System.out.println(ordersNo);
	System.out.println(goodsNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<form method = "post" action = "/shop/customer/addCommentAction.jsp">
	<table>
		<tr>
			<td>주문번호</td>
			<td>상품번호</td>
			<td>점수</td>
			<td>내용</td>
		</tr>
		<tr>
			
			<td><input type = "hidden" name = "ordersNo" value = <%=ordersNo %>><%=ordersNo %></td>
			<td><input type = "hidden" name = "goodsNo" value = "<%=goodsNo%>"><%=goodsNo %>
			</td>
		
			<td><input type = "text" name = "score"></td>
			<td><textarea rows="3" cols="15" name = "content"></textarea></td>
		</tr>
		<tr>
			<td>
				<button type = "submit">작성하기</button>
			</td>
	</table>
</form>
</body>
</html>