<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//로그인 세션변수 loginCustomer?
			
	if (session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	} 
%>
<%
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	
	System.out.println(email + "<-email");
	System.out.println(pw + "<-pw");
	
	String sql = "SELECT cust_mail custMail, cust_pw custPw, cust_name custName, cust_birth custBirth, cust_gender custGender FROM customer WHERE cust_mail = ? AND cust_pw = password(?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,email);
	stmt.setString(2,pw);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	
	System.out.println(stmt);
	
	if(rs.next()){//로그인 성공
		System.out.println("로그인 성공");
		HashMap<String,Object> loginCustomer = new HashMap<String,Object>();
		loginCustomer.put("email",rs.getString("custMail"));
		loginCustomer.put("pw",rs.getString("custPw"));
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		
		session.setAttribute("loginCustomer",loginCustomer);
		
	} else {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인하세요.","utf-8");
		response.sendRedirect("/shop/customer/custLoginForm.jsp?errMsg="+errMsg);
	}
%>