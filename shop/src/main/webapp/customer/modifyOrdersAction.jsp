<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "customer.dao.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginCustomer
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
 	
%>
<%
	String ordersNo = request.getParameter("ordersNo");
	String state = "";
	System.out.println(state);
	System.out.println(ordersNo);

	int row = OrdersDAO.modifyOrders(ordersNo, state);
	
	if(row==1){		
		System.out.println("전환성공");
		response.sendRedirect("/shop/emp/empList.jsp?ordersNo="+ordersNo);
	}else{
		System.out.println("전환실패");
		response.sendRedirect("/shop/emp/empList.jsp?ordersNo="+ordersNo);
	}
	
	  
	   

	
%>