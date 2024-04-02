<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	String active = request.getParameter("active");
	String empId = request.getParameter("empId");
	System.out.println(empId);
	System.out.println(active);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	String sql = "update emp set active = ? where emp_id = ?";
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	ResultSet rs = null;
	if(active.equals("ON")){
		stmt.setString(1,"OFF");
	}else if(active.equals("OFF")){
		stmt.setString(1,"ON");
	}
	stmt.setString(2,empId);
	
	int row = stmt.executeUpdate(); 
	
	System.out.println(stmt + "<-stmt");
	
	if(row==1){		
		System.out.println("전환성공");
		response.sendRedirect("/shop/emp/empList.jsp?empId="+empId);
	}else{
		System.out.println("전환실패");
		response.sendRedirect("/shop/emp/empList.jsp?empId="+empId);
	}
	
	  
	   

	
%>

