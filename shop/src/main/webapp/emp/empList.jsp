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

<% 	//controller layer
	// request 분석
	int currentPage = 1;
	if(request.getParameter("cuurentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("cuurentPage"));
	}
	int rowPerPage = 10;
	int startRow = 0;
	
%>

<%	
	//model layer
	// 모델:특수한 형태의 데이터(RDBMS: mariadb) -> API사용하여 자료구조(ResultSet) 취득 -> 일반화된 자료구조(ArrayList<HashMap>)로 변경을 해야함 
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?,?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	stmt = conn.prepareStatement(sql);
	ResultSet rs = null;
	stmt.setInt(1,startRow);
	stmt.setInt(2,rowPerPage);
	rs = stmt.executeQuery(); 
	// JDBC API 종속된 자료구조 모델 (ResultSet)-> 기본 API 자료구조 (ArrayList)로 변경
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String, Object>>();
	
	//ResultSet -> ArrayList<HashMap<String, Object>>
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String, Object>();
		m.put("empId", rs.getString("empId"));
		m.put("empName", rs.getString("empName"));
		m.put("empJob", rs.getString("empJob"));
		m.put("hireDate", rs.getString("hireDate"));
		m.put("active", rs.getString("active"));
		list.add(m);
		
	}
	// JDBC API 사용이 끝났다면 DB자원 반납
%>
<!-- view layer : 모델(ArrayList<HashoMap<String, Object>> -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<h1>사원목록</h1>
	<form>
		<table border="1">
		    <tr>
		        <th>ID</th>
		        <th>NAME</th>
		        <th>JOB</th>
		        <th>Hire Date</th>
		        <th>Active</th>
		    </tr>
		    <%
		        for(HashMap<String,Object> m : list){
		    %>
		    <tr>
		        <td><%=(String)(m.get("empId"))%></td>
		        <td><%=(String)(m.get("empName"))%></td>
		        <td><%=(String)(m.get("empJob")) %></td>
		        <td><%=(String)(m.get("hireDate")) %></td>
		        <td>
		        	<a href='/shop/emp/modifyEmpActive.jsp?active=<%=(String)(m.get("active")) %>&empId=<%=(String)(m.get("empId"))%>'>
		        		<%=(String)(m.get("active")) %>
		        	</a>
		        </td>
		    </tr>
		    <%
		        } 
		    %>
		</table>
	</form>
	<hr>
		<a href = "/shop/emp/empLogout.jsp">logout</a>


</body>
</html>