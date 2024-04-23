<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*"%>
<%@ page import = "java.util.*" %>
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	
	System.out.println(ordersNo + "<-ordersNo");
	System.out.println(goodsNo + "<-goodsNo");
	System.out.println(totalAmount + "<-totalAmount");
	System.out.println(goodsAmount + "<-goodsAmount");
	
	
	int row1 = OrdersDAO.dropOrders(ordersNo);
	int row2 = GoodsDAO.dropsGoodsAmount(goodsNo, goodsAmount, totalAmount);
	HashMap<String,Object> loginMember 
	= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));	
	String mail = (String)(loginMember.get("mail"));
%>
<%
	if(row1 ==1 && row2==1){
		System.out.println("취소 성공");
		response.sendRedirect("/shop/customer/ordersCheckList.jsp?mail="+mail);	
	}else{
		System.out.println("취소 실패");
		response.sendRedirect("/shop/customer/ordersCheckList.jsp?ordersNo="+ordersNo);
	}

%>
