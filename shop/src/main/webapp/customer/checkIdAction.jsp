<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "customer.dao.*" %>


<%
	String mail = request.getParameter("mail");
	System.out.println(mail);
	
	boolean result = CustomerDAO.checkMail(mail);
	
	if(result == false){//아이디 입력 불가능
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?mail="+mail+"&ck=F");
	} else{
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?mail="+mail+"&ck=T");
	}
	
%>

