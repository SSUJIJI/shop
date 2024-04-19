<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%@ page import = "java.util.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginCustomer
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
 	
%>
<%
	String mail = request.getParameter("mail");
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	
	int startRow = ((currentPage-1)*rowPerPage);
	int totalRow = OrdersDAO.totalRow(mail);

	
	System.out.println(totalRow +"<total");
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	System.out.println(currentPage +" <currentpage");
	ArrayList<HashMap<String,Object>> checkOne = OrdersDAO.selectOrderListByCustomer(mail, startRow, rowPerPage);
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
			<td>mail </td>
			<td>goodsColor </td>
			<td>totalAmout </td>
			<td>totalPrice </td>
			<td>address </td>
			<td>state </td>
			<td>updateDate </td>
		</tr>
		<%
			for(HashMap<String,Object> m : checkOne){
		%>
				<tr>
					<td><%=(String)(m.get("mail"))%></td>
					<td><%=(String)(m.get("goodsColor"))%></td>
					<td><%=(Integer)(m.get("totalAmout"))%></td>
					<td><%=(Integer)(m.get("totalPrice"))%></td>
					<td><%=(String)(m.get("address"))%></td>
					<td><%=(String)(m.get("state"))%></td>
					<td><%=(String)(m.get("updateDate"))%></td>
				</tr>	
		<%	
			}
		%>
		
		
	
	
	</table>
</body>
</html>