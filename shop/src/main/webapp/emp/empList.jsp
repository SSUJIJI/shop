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
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	
	int startRow = ((currentPage-1)*rowPerPage);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	
	//lastPage 모듈
	String sql2 = "select count(*) cnt from emp";
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = null;
	rs2 = stmt2.executeQuery();
	
	int totalRow = 0;

	
	if(rs2.next()){
		totalRow = rs2.getInt("cnt");
	}
	
	System.out.println(totalRow +"<total");
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	System.out.println(currentPage +" <currentpage");
	
%>

<%	
	//model layer
	// 모델:특수한 형태의 데이터(RDBMS: mariadb) -> API사용하여 자료구조(ResultSet) 취득 -> 일반화된 자료구조(ArrayList<HashMap>)로 변경을 해야함 
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?,?";
	PreparedStatement stmt = null;
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
	<!-- css -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<!-- empMenu.jsp include : 주체가 서버 vs redirect(주제:클라이언트) -->
	<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/...시작하지 않는다 -->
	<jsp:include page = "/emp/inc/empMenu.jsp"></jsp:include>
<h1>사원목록</h1>
		<table class = "table table-border">
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
		        	<%
		        	HashMap<String,Object> sm = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
		        		if((Integer)(sm.get("grade"))>0){
		        	%>
		        		<a href='/shop/emp/modifyEmpActive.jsp?active=<%=(String)(m.get("active")) %>&empId=<%=(String)(m.get("empId"))%>'>
		        			<%=(String)(m.get("active")) %>
		        		</a>
		        	<%
		        	}
		        	%>
		        	
		        </td>
		    </tr>
		    <%
		        } 
		    %>
		</table>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-end">
			<%
				if(currentPage > 1) {
			%>
				<li class="page-item">
					<a class = "page-link" href="/shop/emp/empList.jsp?currentPage=1">처음페이지</a>
				</li>
				<li class="page-item">
					<a class = "page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
				</li>																
			<%		
				} else {
			%>
				<li class="page-item disabled">
					<a class = "page-link" href="/shop/emp/empList.jsp?currentPage=1">처음페이지</a>
				</li>
				<li class="page-item disabled">
					<a class = "page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
				</li>
			<%		
				}				
				if(currentPage < lastPage) {
			%>
				<li class="page-item">
					<a class = "page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
				</li>
				<li class="page-item">
					<a class = "page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
				</li>
			<%		
				}
			%>
			</ul>
		</nav>
			
		<div>
			<%=currentPage %>/<%=lastPage %>Page
		</div>
	
	<hr>
		<a href = "/shop/emp/empLogout.jsp">logout</a>


</body>
</html>