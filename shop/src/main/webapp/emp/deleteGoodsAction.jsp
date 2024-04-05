<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	String goodsTitle = request.getParameter("goodsTitle");
	System.out.println(goodsTitle);
	
	String sql = "DELETE FROM goods WHERE goods_title = ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,goodsTitle);
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