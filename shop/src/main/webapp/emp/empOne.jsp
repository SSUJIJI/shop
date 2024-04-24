<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.dao.*" %>
<%@ page import = "java.net.*" %>

<%
    if(session.getAttribute("loginEmp")== null){
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    } 
    
    String empName = request.getParameter("empName");
    String empJob = request.getParameter("empJob");
    HashMap<String,Object> empOne = EmpDAO.selectEmpOne(empName);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>직원 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }
        .container {
            margin-top: 50px;
        }
        .delete-link {
            margin-top: 20px;
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

<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>

<div class="container">
    <h1 class="text-center">직원 정보</h1>
    
    <table class="table table-bordered">
        <tbody>
            <tr>
                <th scope="row">직원 ID</th>
                <td><%=(String)(empOne.get("empId")) %></td>
            </tr>
            <tr>
                <th scope="row">등급</th>
                <td><%=(Integer)(empOne.get("grade")) %></td>
            </tr>
            <tr>
                <th scope="row">직원명</th>
                <td><%=(String)(empOne.get("empName")) %></td>
            </tr>
            <tr>
                <th scope="row">직무</th>
                <td><%=(String)(empOne.get("empJob")) %></td>
            </tr>
            <tr>
                <th scope="row">입사일</th>
                <td><%=(String)(empOne.get("hireDate")) %></td>
            </tr>
            <tr>
                <th scope="row">활성화 상태</th>
                <td><%=(String)(empOne.get("active")) %></td>
            </tr>
        </tbody>
    </table>

    <div class="delete-link">
        <a class="btn btn-danger" href="/shop/emp/deleteEmpAction.jsp?empId=<%=(String)(empOne.get("empId"))%>&empPw=<%=(String)(empOne.get("empPw"))%>&empName=<%=(String)(empOne.get("empName")) %>">직원 탈퇴</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
