<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	} 
 	
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by active asc, hire_date desc";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	stmt = conn.prepareStatement(sql);
	ResultSet rs = null;
	rs = stmt.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<h1>사원목록</h1>
<%
	while(rs.next()){
%>		
		<form>
		<table border = "1">
			<tr>
				<td>ID: </td>
				<td><%=rs.getString("empId") %></td>
			</tr>
			<tr>
				<td>NAME: </td>
				<td><%=rs.getString("empName") %></td>
			</tr>
			<tr>
				<td>JOB: </td>
				<td><%=rs.getString("empJob") %></td>
			</tr>
			<tr>
				<td>hireDate</td>
				<td><%=rs.getString("hireDate") %></td>
			</tr>
			<tr>
				<td>active</td>
				<td><%=rs.getString("active") %></td>
			</tr>
			
		
		</table>
	</form>
<%
	}
%>
	


<a href = "/shop/emp/empLogout.jsp">logout</a>


</body>
</html>