<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "customer.dao.*" %>

<%
	//로그인 세션변수 loginCustomer?
			
	if (session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	} 
%>
<%
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	System.out.println(mail + "<-mail");
	System.out.println(pw + "<-pw");
	
	
	HashMap<String, String> loginCustomer = CustomerDAO.login(mail, pw);
	
	
	if(loginCustomer == null){
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인하세요.","utf-8");
		response.sendRedirect("/shop/customer/custLoginForm.jsp?errMsg="+errMsg);
		
	} else {
		System.out.println("로그인 성공");
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		session.setAttribute("loginCustomer",loginCustomer);
	}
%>