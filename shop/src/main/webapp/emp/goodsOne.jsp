<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.dao.*" %>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	System.out.println(goodsNo);
	
	HashMap<String,Object> goodsOne = GoodsDAO.selectGoodsOne(goodsNo);
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
		<table>	
		<tr>
			<td>goodsNo: </td>
			<td><%=(Integer)(goodsOne.get("goodsNo"))%></td>
		</tr>
		<tr>
			<td>Category: </td>
			<td><%=(String)(goodsOne.get("category")) %></td>
		</tr>
		<tr>
			<td>Id: </td>
			<td><%=(String)(goodsOne.get("empId"))%></td>
		</tr>
		<tr>
			<td>Title: </td>
			<td><%=(String)(goodsOne.get("goodsTitle"))%></td>
		</tr>
		<tr>
			<td>Img:</td>
			<td><img src = "/shop/upload/<%=(String)(goodsOne.get("filename"))%>" width = 100></td>
		</tr>
		<tr>	
			<td>Content: </td>
			<td><%=(String)(goodsOne.get("goodsContent"))%></td>
		</tr>
		<tr>
			<td>Price: </td>
			<td><%=(Integer)(goodsOne.get("goodsPrice"))%></td>
		</tr>
		<tr>
			<td>Amount: </td>
			<td><%=(Integer)(goodsOne.get("goodsAmount"))%></td>
		</tr>
		<tr>
			<td>Create: </td>
			<td><%=(String)(goodsOne.get("createDate"))%></td>
		</tr>
	</table>
	<div class="delete-link">
		<a href = "/shop/emp/deleteGoodsAction.jsp?goodsNo=<%=(Integer)(goodsOne.get("goodsNo"))%>">삭제</a>
	</div>

	</div>

</body>
</html>