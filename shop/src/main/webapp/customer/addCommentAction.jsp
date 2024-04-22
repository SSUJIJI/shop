<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*"%>

<%
	int score = Integer.parseInt(request.getParameter("score"));
	String content = request.getParameter("content");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	
	System.out.println(score);
	System.out.println(goodsNo);
	System.out.println(ordersNo);
	System.out.println(content);
	
	int row = CommentDAO.insertComment(ordersNo, score, content);
%>
<%	
	if(row==1){
		System.out.println("입력 성공");
		response.sendRedirect("/shop/customer/goodsOne.jsp?goodsNo="+goodsNo);
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/customer/addCommentForm.jsp?ordersNo="+ordersNo);
		
	}
%>
