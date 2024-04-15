<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.dao.*" %>
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
	
	
	//lastPage 모듈
	int totalRow = EmpDAO.totalRow();

	
	System.out.println(totalRow +"<total");
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	System.out.println(currentPage +" <currentpage");
	
	
	ArrayList<HashMap<String,Object>> empList = EmpDAO.selectEmpList(startRow, rowPerPage);
%>

<%	
	//model layer
	// 모델:특수한 형태의 데이터(RDBMS: mariadb) -> API사용하여 자료구조(ResultSet) 취득 -> 일반화된 자료구조(ArrayList<HashMap>)로 변경을 해야함 
	/*String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?,?";
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
	// JDBC API 사용이 끝났다면 DB자원 반납*/
	
	
%>
<!-- view layer : 모델(ArrayList<HashoMap<String, Object>> -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- css -->
 
	<style>
        /* 스타일 추가 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .table-container {
            width: 80%;
            margin: 20px auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border-radius: 8px;
        }

        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #333;
            color: white;
        }

        .table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .table tr:hover {
            background-color: #ddd !important;
        }

        .active-link {
            color: blue;
            text-decoration: underline;
            cursor: pointer;
        }
		.page-info-container {
		            text-align: center;
		            margin-top: 20px;
		}
		 .custom-link {
            display: inline-block;
            padding: 6px 12px;
            background-color: #555;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .custom-link:hover {
            background-color: #f0f0f0;
		
		}
		.pagination .page-link {
            color: black; /* 페이지 번호 텍스트 색상 */
        }

        .pagination .page-link:hover {
            color: #FFD9FA; /* 페이지 번호에 마우스를 올렸을 때 색상 변경 */
        }

        .pagination .page-item.active .page-link {
            background-color: #FFD9FA; /* 현재 페이지 표시 링크 배경색 */
            border-color:#FFD9FA; /* 현재 페이지 표시 링크 테두리 색상 */
            color: white; /* 현재 페이지 텍스트 색상 */
        }

        .pagination .page-item .page-link {
            background-color: #fff;
            border: 1px solid #ddd;
        }

      
    </style>
</head>
<body>
	<!-- empMenu.jsp include : 주체가 서버 vs redirect(주제:클라이언트) -->
	<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/..	.시작하지 않는다 -->
	<jsp:include page = "/emp/inc/empMenu.jsp"></jsp:include>
	<hr>

	  <div class="table-container">
		<table class = "table table-hover">
		    <tr>
		        <th>ID</th>
		        <th>NAME</th>
		        <th>JOB</th>
		        <th>Hire Date</th>
		        <th>Active</th>
		    </tr>
		    <%
		        for(HashMap<String,Object> m : empList){
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
		        		 <a class="custom-link" href='/shop/emp/modifyEmpActive.jsp?active=<%=(String)(m.get("active")) %>&empId=<%=(String)(m.get("empId"))%>'>
		        			<%=(String)(m.get("active")) %>
		        		</a>
		        	<%
		        	}
		        	%>
		    <%
		        } 
		    %>
		        	
		        </td>
		    </tr>
		</table>
		</div>
		    <!-- 페이지 정보 표시 -->
	    <div class="page-info-container">
	        <%=currentPage %>/<%=lastPage %>Page
	    </div>
		<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center" style="color: #f0f0f0" >
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
				}else {
			%>
				<li class="page-item disabled">
					<a class = "page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
				</li>
				<li class="page-item disabled">
					<a class = "page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
				</li>
			<%		
				}				
			%>
			</ul>
		</nav>
			
	
	
	<hr>
		<div style="text-align: right;">
	        <a href="/shop/emp/empLogout.jsp" class="custom-link">logout</a>
	    </div>


</body>
</html>