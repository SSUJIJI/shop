<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(ordersNo);

%>
<%
	int row = CommentDAO.deleteRow(ordersNo);
%>
<%
	if(row ==1){
		System.out.println("삭제 성공");
		response.sendRedirect("/shop/emp/commentCheckList.jsp");	
	}else{
		System.out.println("삭제 실패");
		response.sendRedirect("/shop/emp/commentCheckList.jsp?ordersNo="+ordersNo);
	}
%>