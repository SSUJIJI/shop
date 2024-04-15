<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "shop.dao.*" %>
<%
	String active = request.getParameter("active");
	String empId = request.getParameter("empId");
	System.out.println(empId);
	System.out.println(active);

	int row = EmpDAO.modifyEmp(active, empId);
	
	if(row==1){		
		System.out.println("전환성공");
		response.sendRedirect("/shop/emp/empList.jsp?empId="+empId);
	}else{
		System.out.println("전환실패");
		response.sendRedirect("/shop/emp/empList.jsp?empId="+empId);
	}
	
	  
	   

	
%>

