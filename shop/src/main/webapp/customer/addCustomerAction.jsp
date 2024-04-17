<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "customer.dao.*" %>

<%
    // 기존 로그인 세션 종료
    session.removeAttribute("loginCustomer");
    session.invalidate(); // 세션 무효화
%>
<%

	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	System.out.println(mail);
	System.out.println(name);
	System.out.println(pw);
	System.out.println(birth);
	System.out.println(gender);
	
	int row = CustomerDAO.insertCustomer(mail, pw, name, birth, gender);
	
	if(row == 1){
		System.out.println("입력성공");
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
	}else{
		System.out.println("입력실패");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
	}
%>
