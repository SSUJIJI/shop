<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	String category = request.getParameter("category");
	System.out.println(category + "<cate");
	
	String sql = "DELETE FROM category WHERE category= ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;	
	int row = 0;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,category);
	row = stmt.executeUpdate();
	
	if(row == 0){
		System.out.println("삭제실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else{
		System.out.println("삭제성공");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
	
%>