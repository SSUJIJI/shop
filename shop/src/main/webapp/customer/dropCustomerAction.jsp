<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="customer.dao.*" %>

<%
	//로그인 세션변수 loginCustomer
			
	
	if (session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
%>

<%
	String name = request.getParameter("name");
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	int row = CustomerDAO.deleteCustomer(mail, pw);

	if(row ==1){
		System.out.println("탈퇴성공");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");	
		session.invalidate(); //세션 공간을 초기화 한 것...
	}else{
		System.out.println("탈퇴실패");
		response.sendRedirect("/shop/customer/customerOne.jsp?mail="+mail);
	}
%>

