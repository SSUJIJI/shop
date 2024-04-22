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
	String ordersNo = request.getParameter("ordersNo");
	String state = request.getParameter("state");
	System.out.println(state);
	System.out.println(ordersNo);

	int row = OrdersDAO.shippingModify(ordersNo, state);
	
	if(row==1){		
		System.out.println("전환성공");
		response.sendRedirect("/shop/emp/ordersCheckList.jsp?ordersNo="+ordersNo);
	}else{
		System.out.println("전환실패");
		response.sendRedirect("/shop/emp/ordersCheckList.jsp?ordersNo="+ordersNo);
	}
%>