<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	} 
 	
%>
<%

	String empName = request.getParameter("empName");
	System.out.println(empName + "<-empName");
	
	String sql = "select emp_id empId, grade, emp_pw empPw, emp_name empName, emp_job empJob, hire_date hireDate, active from emp where emp_name = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	
	stmt.setString(1,empName);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("empId", rs.getString("empId"));
		m.put("grade", rs.getInt("grade"));
		m.put("empName", rs.getString("empName"));
		m.put("empJob", rs.getString("empJob"));
		m.put("hireDate", rs.getString("hireDate"));
		m.put("active", rs.getString("active"));
		list.add(m);
	}

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	  <style>
         body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .delete-link {
            margin-top: 20px;
            display: block;
            text-align: center;
        }
        .delete-link a {
            color: #d9534f;
            text-decoration: none;
        }
        .delete-link a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
<!-- empMenu.jsp include : 주체가 서버 vs redirect(주제:클라이언트) -->
	<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/..	.시작하지 않는다 -->
	<jsp:include page = "/emp/inc/empMenu.jsp"></jsp:include>
<div class = "container">
	<h1>고객관리</h1>
	<%
		for(HashMap<String,Object> m : list){
	%>	
		<table class="table table-hover">
			<tr>
				<td>empId: </td>
				<td><%=(String)(m.get("empId")) %></td>
			</tr>
			<tr>
				<td>grade: </td>
				<td><%=(Integer)(m.get("grade")) %></td>
			</tr>
			<tr>
				<td>empName: </td>
				<td><%=(String)(m.get("empName")) %></td>
			</tr>
			<tr>
				<td>empJob: </td>
				<td><%=(String)(m.get("empJob")) %></td>
			</tr>
			<tr>
				<td>hireDate: </td>
				<td><%=(String)(m.get("hireDate")) %></td>
			</tr>
			<tr>
				<td>active: </td>
				<td><%=(String)(m.get("active")) %></td>
			</tr>
		</table>
		<div class="delete-link">
			<a href = "/shop/emp/deleteGoodsAction.jsp?empId=<%=(String)(m.get("empId"))%>">삭제</a>
		</div>
	<%
		}
	%>
	</div>
</body>
</html>