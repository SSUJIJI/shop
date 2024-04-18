<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "customer.dao.*" %>

<%
	String goodsNo = request.getParameter("goodsNo");
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsColor = request.getParameter("goodsColor");
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	String address = request.getParameter("address");
	
	HashMap<String,Object> loginMember 
	= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));	
	String mail = (String)(loginMember.get("mail"));
	System.out.println(mail + "<-mail");
	System.out.println(goodsNo +"<goodsNo");
	System.out.println(goodsTitle +"<goodsTitle");
	System.out.println(goodsColor +"<goodsColor");
	System.out.println(goodsColor +"<goodsAmount");
	System.out.println(goodsColor +"<totalPrice");
	System.out.println(goodsColor +"<address");
	
	/*int row = OrdersDAO.row(goodsNo, goodsColor, mail, goodsAmount, totalPrice, address, state);
	if(row == 1) {
		System.out.println("입력 성공");
		response.sendRedirect("/shop/customer/checkOrders.jsp");
	}else{
		System.out.println("입력 실패");
		response.sendRedirect("/shop/customer/addOrdersForm.jsp");
	}*/
%>

