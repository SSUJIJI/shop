<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String mail = request.getParameter("mail");
	System.out.println(ordersNo);
	System.out.println(mail);
	
%>
<%
	int row = CommentDAO.deleteCustomerRow(ordersNo, mail);
%>
<%
	if(row ==1){
		System.out.println("삭제 성공");
		response.sendRedirect("/shop/customer/ordersCheckList.jsp?mail="+mail);	
	}else{
		System.out.println("삭제 실패");
		response.sendRedirect("/shop/customer/ordersCheckList.jsp?ordersNo="+ordersNo);
	}
%>