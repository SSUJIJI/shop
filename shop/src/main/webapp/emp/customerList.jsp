<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%@ page import = "java.util.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	} 
 	
%>

<%

	int currentPage = 1;
	if(request.getParameter("currentPage")!= null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 9;
	int startRow = ((currentPage-1)*rowPerPage);
	
	//전체 고객 개수
	int totalRow = CustomerDAO.totalRow();
	//디버깅 
	System.out.println(totalRow);
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	System.out.println(currentPage +" <currentpage");
	
	ArrayList<HashMap<String,Object>> custList = CustomerDAO.selectCustomerListByPage(startRow, rowPerPage);



%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	 <style>
        body {
            font-family: '나눔고딕', 'Nanum Gothic', Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        jsp\\:include {
            display: block;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/..	.시작하지 않는다 -->
	<jsp:include page = "/emp/inc/empMenu.jsp"></jsp:include>
	<table>
		<tr>
			<td>mail</td>
			<td>name</td>
			<td>birth</td>
			<td>gender</td>
			<td>updateDate</td>
			<td>createDate</td>
		</tr>
		
			<%
				for(HashMap<String,Object> m : custList){
			%>	
				<tr>	
					<td><%=(String)(m.get("mail"))%></td>
					<td><%=(String)(m.get("name"))%></td>
					<td><%=(String)(m.get("birth"))%></td>
					<td><%=(String)(m.get("gender"))%></td>
					<td><%=(String)(m.get("updateDate"))%></td>
					<td><%=(String)(m.get("createDate"))%></td>
				</tr>	
			<%
				}
			
			%>
			
	
	</table>
</body>
</html>