<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.dao.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	} 
 	
%>
<%
	String category = request.getParameter("category");
	System.out.println(category);
	
	int row = CategoryDAO.addCategory(category);
	
	if(row == 1){
		System.out.println("입력성공");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else {
		System.out.println("입력실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
%>