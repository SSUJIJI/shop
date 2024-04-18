<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import = "customer.dao.*" %>
<!-- control layer -->
<%

	//로그인 인증분기 : 세션 변수 이름 loginCustomer
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
 	
%>
<%
	String mail = request.getParameter("mail");
	int currentPage = 1;
	if(request.getParameter("currentPage")!= null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 9;
	int startRow = ((currentPage-1)*rowPerPage);
	
	String category = "";
	if(request.getParameter("category")!=null){
		category = request.getParameter("category");
	}
	int totalRow = GoodsDAO.totalRow(category);

	System.out.println(totalRow +"<total");
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	System.out.println(currentPage +" <currentpage");
	
%>
<!-- model layer -->
<%
	
	//category별 개수

	ArrayList<HashMap<String,Object>> categoryList = GoodsDAO.selectCategoryCount();
	System.out.println(categoryList);
	
	//category에 따른 상품 보여주는 list
	ArrayList<HashMap<String,Object>> list = GoodsDAO.selectGoodsList(category, startRow, rowPerPage);
	System.out.println(list);
%>

<!-- view layer -->
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>goodsList</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>


<!-- empMenu.jsp include : 주체가 서버 vs redirect(주제:클라이언트) -->
	<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/..	.시작하지 않는다 -->
	<jsp:include page = "/customer/inc/customerMenu.jsp"></jsp:include>
    <!-- 서브메뉴 카테고리별 상품리스트 -->
    <div class="container-fluid">
        <div class="row justify-content-end">
            <div class="col-auto">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a href="/shop/customer/goodsList.jsp" class="nav-link" style="color: black;">전체</a>
                    </li>
                    <%
                        for(HashMap<String,Object> m : categoryList){
                    %>
                            <li class="nav-item">
                                <a href="/shop/customer/goodsList.jsp?category=<%=(String)(m.get("category"))%>" class="nav-link" style="color: black;">
                                <%=(String)(m.get("category"))%>
                                (<%=(Integer)(m.get("cnt"))%>)</a>
                            </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </div>  
    <br>
    <br>
    <div class="container text-center">
        <div class="row">
            <%
                for(HashMap<String,Object> m : list){
            %>  
            <div class="col-4">
                <div>
                    <a href="/shop/customer/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>">
                    <img src="/shop/upload/<%=(String)(m.get("filename")) %>" width="100">
                    </a>
                </div>
                <div><%=(String)(m.get("category")) %></div>
                <div><%=(String)(m.get("goodsTitle"))%></div>
                <div><%=(Integer)(m.get("goodsPrice"))%></div><br>
            </div>
            <%  
                }
            %>
        </div>  
    </div>  
    <br>
    <div class="pagination-container">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <%
                    if(currentPage > 1) {
                %>
                        <li class="page-item">
                            <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>" style="color: black;">처음페이지</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>" style="color: black;">이전페이지</a>
                        </li>                                                                
                <%      
                    } else {
                %>
                        <li class="page-item disabled">
                            <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=1&category=<%=category%>" style="color: black;">처음페이지</a>
                        </li>
                        <li class="page-item disabled">
                            <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>" style="color: black;">이전페이지</a>
                        </li>
   				<%
   					}
   				%>
                <%          
                   	if(currentPage < lastPage){
                %>
                            <li class="page-item">
                                <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" style="color: black;">다음페이지</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>" style="color: black;">마지막페이지</a>
                            </li>
                <%      
                    }else{
                %>
                            <li class="page-item disabled">
                                <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" style="color: black;">다음페이지</a>
                            </li>
                            <li class="page-item disabled">
                                <a class="page-link" href="/shop/customer/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>" style="color: black;">마지막페이지</a>
                <%
                    }
                %>
            </ul>
        </nav>      
    </div>
    <hr>
    <div>
    	<a href = "/shop/customer/custLogout.jsp">로그아웃</a>
    </div>
</body>
</html>
