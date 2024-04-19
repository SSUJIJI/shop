<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "customer.dao.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginCustomer
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
 	
%>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsColor = request.getParameter("goodsColor");
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String address = request.getParameter("address");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));

	
	HashMap<String,Object> loginMember 
	= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));	
	String mail = (String)(loginMember.get("mail"));
	
	
	System.out.println(mail + "<-mail");
	System.out.println(goodsNo +"<goodsNo");
	System.out.println(goodsColor +"<goodsColor");
	System.out.println(goodsAmount +"<goodsAmount");
	System.out.println(address +"<address");
%>
<%	
	int row = OrdersDAO.insertOrders(mail, goodsNo, goodsPrice, goodsColor, goodsAmount, address);
	if(row==1){
		System.out.println("입력 성공");
		response.sendRedirect("/shop/customer/ordersCheckList.jsp?mail="+mail);
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/customer/addOrdersForm.jsp");
		
	}
%>

