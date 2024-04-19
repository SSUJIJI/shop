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
	
	</table>
</body>
</html>