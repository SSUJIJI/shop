<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.dao.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo);
	
	int row = GoodsDAO.deleteGoods(goodsNo);
	
	if(row == 0){
		System.out.println("삭제실패");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else{
		System.out.println("삭제성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	}
%>