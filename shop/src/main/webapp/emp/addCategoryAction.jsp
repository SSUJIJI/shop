<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
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
	
	String sql = "INSERT INTO category (category, create_date) VALUES(?,now())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,category);
	System.out.println(stmt);
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1){
		System.out.println("입력성공");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}else {
		System.out.println("입력실패");
		response.sendRedirect("/shop/emp/categoryList.jsp");
	}
%>