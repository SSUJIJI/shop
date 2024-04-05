<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	String goodsTitle = request.getParameter("goodsTitle");
	
	System.out.println(goodsTitle);
	
	String sql = "select category, emp_id empId, goods_title goodsTitle, filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, create_date createDate from goods where goods_title = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,goodsTitle);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	while(rs.next()){
		HashMap<String,Object> m  = new HashMap<String,Object>();
		m.put("category",rs.getString("category"));
		m.put("empId",rs.getString("empId"));
		m.put("goodsTitle",rs.getString("goodsTitle"));
		m.put("filename",rs.getString("filename"));
		m.put("goodsContent",rs.getString("goodsContent"));
		m.put("goodsPrice",rs.getString("goodsPrice"));
		m.put("goodsAmount",rs.getString("goodsAmount"));
		m.put("createDate",rs.getString("createDate"));
		list.add(m);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	
	<%
		for(HashMap<String,Object> m : list){
	%>	
		<table>	
		<tr>
			<td>Category: </td>
			<td><%=(String)(m.get("category"))%></td>
		</tr>
		<tr>
			<td>Id: </td>
			<td><%=(String)(m.get("empId"))%></td>
		</tr>
		<tr>
			<td>Title: </td>
			<td><%=(String)(m.get("goodsTitle"))%></td>
		</tr>
		<tr>
			<td>Img:</td>
			<td><img src = "/shop/upload/<%=(String)(m.get("filename"))%>" width = 100></td>
		</tr>
		<tr>	
			<td>Content: </td>
			<td><%=(String)(m.get("goodsContent"))%></td>
		</tr>
		<tr>
			<td>Price: </td>
			<td><%=(String)(m.get("goodsPrice"))%></td>
		</tr>
		<tr>
			<td>Amount: </td>
			<td><%=(String)(m.get("goodsAmount"))%></td>
		</tr>
		<tr>
			<td>Create: </td>
			<td><%=(String)(m.get("createDate"))%></td>
		</tr>
	</table>
	<div>
		<a href = "/shop/emp/deleteGoodsAction.jsp?goodsTitle=<%=(String)(m.get("goodsTitle"))%>">삭제</a>
	</div>
	<%
		}
	%>

</body>
</html>