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
<%
	String category = request.getParameter("category");
	System.out.println(category + "<-category");
	
	HashMap<String,Object> categoryOne = CategoryDAO.selectCategoryOne(category);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	  <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        h1 {
            text-align: center;
            color: #343a40;
        }
        table {
            width: 60%;
            margin: 20px auto;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
            transition: background-color 0.3s;
        }
        th {
            background-color: #343a40;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        a {
            text-decoration: none;
            color: #dc3545;
            transition: color 0.3s;
        }
        a:hover {
            color: #c82333;
        }
    </style>
</head>
<body>
<h1 style="text-align: center;" >Category Information</h1>
	  <table style="margin: 0 auto;">
		<tr>
			<td>category</td>
			<td>createDate</td>
		</tr>
					<tr>
						<td>
							<%=(String)(categoryOne.get("category"))%>
						</td>	
						<td><%=(String)(categoryOne.get("createDate")) %></td>	
					</tr>	
						
	</table>
	<div style="text-align: center; margin-top: 20px;">
		<a href="/shop/emp/deleteCategoryAction.jsp?category=<%=category%>">삭제</a>
	</div>
</body>
</html>