<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "shop.dao.*" %>
<%
	String category = request.getParameter("category");
	System.out.println(category + "<cate");
	
	int row = CategoryDAO.deleteCategory(category);
	
	if(row == 0){
		System.out.println("삭제실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else{
		System.out.println("삭제성공");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
	
%>