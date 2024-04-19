<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "customer.dao.*" %>
<%
	String goodsNo = request.getParameter("goodsNo");
	String active = "";
	System.out.println(active);
	System.out.println(goodsNo);

	int row = OrdersDAO.modifyOrders(goodsNo, active);
	
	if(row==1){		
		System.out.println("전환성공");
		response.sendRedirect("/shop/emp/empList.jsp?goodsNo="+goodsNo);
	}else{
		System.out.println("전환실패");
		response.sendRedirect("/shop/emp/empList.jsp?goodsNo="+goodsNo);
	}
	
	  
	   

	
%>