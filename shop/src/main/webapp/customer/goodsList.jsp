<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import = "customer.dao.*" %>

<%
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
 	
	String mail = request.getParameter("mail");
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 9;
	int startRow = ((currentPage-1)*rowPerPage);
	
	String category = "";
	if(request.getParameter("category") != null){
		category = request.getParameter("category");
	}
	int totalRow = GoodsDAO.totalRow(category);
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
%>

<%
	ArrayList<HashMap<String,Object>> categoryList = GoodsDAO.selectCategoryCount();
	ArrayList<HashMap<String,Object>> list = GoodsDAO.selectGoodsList(category, startRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>goodsList</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>

<div class="container mt-5">
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a href="/shop/customer/goodsList.jsp" class="nav-link">전체</a>
        </li>
        <% for(HashMap<String,Object> m : categoryList){ %>
            <li class="nav-item">
                <a href="/shop/customer/goodsList.jsp?category=<%= m.get("category") %>" class="nav-link">
                    <%= m.get("category") %> (<%= m.get("cnt") %>)
                </a>
            </li>
        <% } %>
    </ul>
    
    <div class="row mt-4">
        <% for(HashMap<String,Object> m : list){ %>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="/shop/upload/<%= m.get("filename") %>" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title"><%= m.get("goodsTitle") %></h5>
                        <p class="card-text"><%= m.get("goodsPrice") %></p>
                        <a href="/shop/customer/goodsOne.jsp?goodsNo=<%= m.get("goodsNo") %>" class="btn btn-primary">상세보기</a>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
    
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-4">
            <% if(currentPage > 1) { %>
                <li class="page-item">
                    <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%= category %>">처음</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%= currentPage-1 %>&category=<%= category %>">이전</a>
                </li>
            <% } else { %>
                <li class="page-item disabled">
                    <a class="page-link" href="#">처음</a>
                </li>
                <li class="page-item disabled">
                    <a class="page-link" href="#">이전</a>
                </li>
            <% } %>
            
            <% if(currentPage < lastPage){ %>
                <li class="page-item">
                    <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%= currentPage+1 %>&category=<%= category %>">다음</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%= lastPage %>&category=<%= category %>">끝</a>
                </li>
            <% } else { %>
                <li class="page-item disabled">
                    <a class="page-link" href="#">다음</a>
                </li>
                <li class="page-item disabled">
                    <a class="page-link" href="#">끝</a>
                </li>
            <% } %>
        </ul>
    </nav>
    
    <hr>
    <div>
    	<a href="/shop/customer/custLogout.jsp" class="btn btn-danger">로그아웃</a>
    </div>
</div>

</body>
</html>
