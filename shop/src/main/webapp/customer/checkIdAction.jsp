<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>


<%
	String email = request.getParameter("email");
	System.out.println(email);
	
	String sql = "select cust_mail custMail from customer where cust_mail = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,email);
	ResultSet rs = null;
	
	System.out.println(stmt);
	rs = stmt.executeQuery();
	
	if(rs.next()){//아이디 입력 불가능
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?email="+email+"&ck=F");
	} else{
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?email="+email+"&ck=T");
	}
	
%>

