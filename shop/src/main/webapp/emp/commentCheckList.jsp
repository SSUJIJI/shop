<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%@ page import = "java.util.*" %>

<%

	ArrayList<HashMap<String,Object>> checkList = CommentDAO.checkComment();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<table>
		<tr>
			<td>No</td>
			<td>score</td>
			<td>content</td>
		</tr>
		<%
			for(HashMap<String,Object> m : checkList){
		%>		
				<tr>
					<td><%=(Integer)(m.get("ordersNo"))%></td>
					<td><%=(Integer)(m.get("score")) %></td>
					<td><%=(String)(m.get("content")) %></td>
					<td><a href = "/shop/emp/deleteCommentAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>">삭제</a>
				</tr>
				
		<%	
			}
		%>
		
	</table>
</body>
</html>