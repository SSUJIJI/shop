<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import = "java.net.*" %>


<%
	//로그인 세션변수 loginCustomer
			
	
	if (session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	} 
%>

<%
	String empName = request.getParameter("empName");
	empName = URLEncoder.encode(empName,"utf-8");
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	System.out.println(empId);
	System.out.println(empPw);
	int row = EmpDAO.deleteEmp(empId, empPw);

	if(row == 0){
		System.out.println("탈퇴실패");
		response.sendRedirect("/shop/emp/empOne.jsp?empName="+empName);
	}else{
		System.out.println("탈퇴성공");
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		session.invalidate(); //세션 공간을 초기화 한 것...
	}
%>