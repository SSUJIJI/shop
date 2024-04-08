<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo);
	
	String sql = "DELETE FROM goods WHERE goods_no = ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1,goodsNo);
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 0){
		System.out.println("삭제실패");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else{
		System.out.println("삭제성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	}
%>