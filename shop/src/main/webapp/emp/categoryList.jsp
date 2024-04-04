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
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	String sql = "select category, create_date createDate from category";
	PreparedStatement stmt = null;	
	ResultSet rs= null;
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("category",rs.getString("category"));
		list.add(m);
	}
	
	System.out.println(list);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<h1>Category</h1>
	<table>
		<tr>
			<td>category</td>
		</tr>
			<%
				for(HashMap m : list){
			%>	
					<tr>
						<td>
							<a href = "/shop/emp/categoryOne.jsp?category=<%=(String)(m.get("category")) %>">
								<%=(String)(m.get("category")) %>
							</a>
						</td>	
					</tr>
			<%
				}
			%>
	</table>
	<div>
		<a href="/shop/emp/addCategoryForm.jsp">추가</a>
	</div>
</body>
</html>