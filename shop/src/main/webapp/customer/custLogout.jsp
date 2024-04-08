<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
session.invalidate(); //세션 공간을 초기화 한 것...

response.sendRedirect("/shop/customer/custLoginForm.jsp"); 

%>