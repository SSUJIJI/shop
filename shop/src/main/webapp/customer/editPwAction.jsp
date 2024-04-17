<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%@ page import = "java.net.*" %>
<%
	//로그인 세션변수 loginCustomer
			
	
	if (session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	} 
%>
<%
	String mail = request.getParameter("mail");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	
	System.out.println(mail);
	System.out.println(oldPw + "<oldPw");
	System.out.println(newPw + "<newPw");
	
	int row = CustomerDAO.updatePw(mail, oldPw, newPw);

	if(row == 1){//수정 성공
		response.sendRedirect("/shop/customer/customerOne.jsp?mail="+mail);
		System.out.println("수정완료");
	}else{
		response.sendRedirect("/shop/customer/editPwForm.jsp");
		System.out.println("수정실패");
	}

%>