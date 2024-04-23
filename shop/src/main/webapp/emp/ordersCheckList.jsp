<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%@ page import = "java.util.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	} 
 	
%>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	
	int startRow = ((currentPage-1)*rowPerPage);
	
	int totalRow = OrdersDAO.totalRow2();

	
	System.out.println(totalRow +"<total");
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	System.out.println(currentPage +" <currentpage");
	ArrayList<HashMap<String,Object>> listAll = OrdersDAO.selectOrderListAll(startRow, rowPerPage);
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
			<td>ordersNo</td>
			<td>mail </td>
			<td>goodsColor </td>
			<td>totalAmount </td>
			<td>totalPrice </td>
			<td>address </td>
			<td>state </td>
			<td>updateDate </td>
		</tr>
		<%
			for(HashMap<String,Object> m : listAll){
		%>
				<tr>
					<td><%=(Integer)(m.get("ordersNo"))%></td>
					<td><%=(String)(m.get("mail"))%></td>
					<td><%=(String)(m.get("goodsColor"))%></td>
					<td><%=(Integer)(m.get("totalAmount"))%></td>
					<td><%=(Integer)(m.get("totalPrice"))%></td>
					<td><%=(String)(m.get("address"))%></td>
					<td>
					<%
						if(m.get("state").equals("배송완료")){
					%>
							<%=(String)(m.get("state"))%>
					<%	
						}else{
					%>
							<a href = "/shop/emp/modifyOrdersAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=<%=(String)(m.get("state"))%>">
							<%=(String)(m.get("state"))%></a>
							<a href = "/shop/emp/dropOrdersAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>&state=<%=(String)(m.get("state"))%>">
							<%=(String)(m.get("state"))%></a>
					<%		
						}
					%>
					</td>
					<td><%=(String)(m.get("updateDate"))%></td>
				</tr>	
		<%	
			}
		%>
		
	</table>
</body>
</html>