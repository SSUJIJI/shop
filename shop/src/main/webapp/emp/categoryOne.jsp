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
	String category = request.getParameter("category");
	System.out.println(category + "<-category");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	String sql = "select category, create_date createDate from category where category = ?";
	PreparedStatement stmt = null;	
	ResultSet rs= null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,category);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	if(rs.next()){
		HashMap<String,Object> m = new HashMap<String, Object>();
		m.put("category", rs.getString("category"));
		m.put("createDate",rs.getString("createDate"));
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
					<%
						for(HashMap<String,Object>m:list){
					%>	
						<td>
							<%=(String)(m.get("category"))%>
						</td>	
						<td><%=(String)(m.get("createDate")) %></td>	
					</tr>	
					<%
						}
					%>
						
	</table>
	<div style="text-align: center; margin-top: 20px;">
		<a href="/shop/emp/deleteCategoryAction.jsp?category=<%=rs.getString("category")%>">삭제</a>
	</div>
</body>
</html>