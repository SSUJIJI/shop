<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	System.out.println(goodsNo);
	
	String sql = "select goods_no goodsNo, category, emp_id empId, goods_title goodsTitle, filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, create_date createDate from goods where goods_no = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1,goodsNo);
	ResultSet rs = null;
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	while(rs.next()){
		HashMap<String,Object> m  = new HashMap<String,Object>();
		m.put("goodsNo",rs.getInt("goodsNo"));
		m.put("category",rs.getString("category"));
		m.put("empId",rs.getString("empId"));
		m.put("goodsTitle",rs.getString("goodsTitle"));
		m.put("filename",rs.getString("filename"));
		m.put("goodsContent",rs.getString("goodsContent"));
		m.put("goodsPrice",rs.getInt("goodsPrice"));
		m.put("goodsAmount",rs.getInt("goodsAmount"));
		m.put("createDate",rs.getString("createDate"));
		list.add(m);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	 <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        img {
            max-width: 100px;
            height: auto;
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
	<div class="container">
	<h1>상세정보</h1>
	<%
		for(HashMap<String,Object> m : list){
	%>	
		<table>	
		<tr>
			<td>goodsNo: </td>
			<td><%=(Integer)(m.get("goodsNo"))%></td>
		</tr>
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
			<td><%=(Integer)(m.get("goodsPrice"))%></td>
		</tr>
		<tr>
			<td>Amount: </td>
			<td><%=(Integer)(m.get("goodsAmount"))%></td>
		</tr>
		<tr>
			<td>Create: </td>
			<td><%=(String)(m.get("createDate"))%></td>
		</tr>
	</table>
	<div class="delete-link">
		<a href = "/shop/emp/deleteGoodsAction.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>">삭제</a>
	</div>
	<%
		}
	%>
	</div>

</body>
</html>