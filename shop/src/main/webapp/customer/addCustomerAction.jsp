<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	//로그인 세션변수 loginCustomer
			
	
	if (session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	} 
%>
<%

	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	System.out.println(email);
	System.out.println(pw);
	System.out.println(name);
	System.out.println(birth);
	System.out.println(gender);
	
	/*INSERT INTO customer(cust_mail, cust_pw, cust_name, cust_birth, cust_gender, update_date, create_date ) VALUES('suji4510@naver.com', PASSWORD('1234'), 
			'수지', '2002-03-19', '여',NOW(),NOW());*/
	String sql = "INSERT INTO customer(cust_mail, cust_pw, cust_name, cust_birth, cust_gender, update_date, create_date ) VALUES(?, PASSWORD(?), ?, ?, ?,NOW(),NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,email);
	stmt.setString(2,pw);
	stmt.setString(3,name);
	stmt.setString(4,birth);
	stmt.setString(5,gender);
	int row = 0;
	row = stmt.executeUpdate();
	
	System.out.println(stmt);
	
	if(row == 1){
		System.out.println("입력성공");
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
	}else{
		System.out.println("입력실패");
		response.sendRedirect("/shop/customer/customerList.jsp");
	}
%>
