<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import = "shop.dao.*" %>


<!-- control layer -->
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
	//전체 상품 개수
	
	int totalRow = GoodsDAO.totalRow();
	
	System.out.println(totalRow +"<total");
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	System.out.println(currentPage +" <currentpage");
	
%>
<!-- model layer -->
<%
	String category = "";
	if(request.getParameter("category")!=null){
		category = request.getParameter("category");
	}
	//category별 개수를 HashMap으로 나타냄 
	
	ArrayList<HashMap<String,Object>> list = GoodsDAO.selectCategoryList();
	//디버깅
	System.out.println(list + "<-categoryList");
	
	//category별 개수
	
	int cateTotalRow = GoodsDAO.cateTotalRow(category);
	System.out.println(cateTotalRow +"<cateTotal");

	int cateLastPage = cateTotalRow/rowPerPage;
	
	if(cateTotalRow % rowPerPage != 0){
		cateLastPage = cateLastPage+1;
	}
	System.out.println(cateLastPage +"<cateLastPage");

	
	
	//category에 따른 상품 보여주는 list

	ArrayList<HashMap<String,Object>> goodsList = GoodsDAO.selectGoodsList(category, startRow, rowPerPage);
	
%>

<!-- view layer -->
<!-- view layer -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>goodsList</title>
    
	<style>
        /* 스타일 추가 */
         body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .table-container {
            width: 80%;
            margin: 20px auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border-radius: 8px;
        }

        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #333;
            color: white;
        }

        .table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .table tr:hover {
            background-color: #ddd !important;
        }

        .active-link {
            color: blue;
            text-decoration: underline;
            cursor: pointer;
        }
		.page-info-container {
		            text-align: center;
		            margin-top: 20px;
		}
		 .custom-link {
            display: inline-block;
            padding: 6px 12px;
            background-color: #555;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .custom-link:hover {
            background-color: #f0f0f0;
		
		}
		.pagination .page-link {
            color: black; /* 페이지 번호 텍스트 색상 */
        }

        .pagination .page-link:hover {
            color: #FFD9FA; /* 페이지 번호에 마우스를 올렸을 때 색상 변경 */
        }

        .pagination .page-item.active .page-link {
            background-color: #FFD9FA; /* 현재 페이지 표시 링크 배경색 */
            border-color:#FFD9FA; /* 현재 페이지 표시 링크 테두리 색상 */
            color: white; /* 현재 페이지 텍스트 색상 */
        }

        .pagination .page-item .page-link {
            background-color: #fff;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <!-- 메인메뉴 -->
    <div>
        <jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
    </div>
    <!-- 서브메뉴 카테고리별 상품리스트 -->
    <div class="container-fluid">
        <div class="row justify-content-end">
            <div class="col-auto">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a href="/shop/emp/addGoodsForm.jsp" class="nav-link" style="color: black;">상품등록</a>
                    </li>
                    <li class="nav-item">
                        <a href="/shop/emp/goodsList.jsp" class="nav-link" style="color: black;">전체</a>
                    </li>
                    <%
                        for(HashMap<String,Object> m : list){
                    %>
                            <li class="nav-item">
                                <a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>" class="nav-link" style="color: black;">
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
                for(HashMap<String,Object> m : goodsList){
            %>  
            <div class="col-4">
                <div>
                    <a href="/shop/emp/goodsOne.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>">
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
    <div class="page-info-container">
	        <%=currentPage %>/<%=lastPage %>Page
	</div>
        <nav aria-label="Page navigation example" style="color: #f0f0f0">
            <ul class="pagination justify-content-center">
                <%
                    if(currentPage > 1) {
                %>
                        <li class="page-item">
                            <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>" style="color: black;">처음페이지</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>" style="color: black;">이전페이지</a>
                        </li>                                                                
                <%      
                    } else {
                %>
                        <li class="page-item disabled">
                            <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>" style="color: black;">처음페이지</a>
                        </li>
                        <li class="page-item disabled">
                            <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>" style="color: black;">이전페이지</a>
                        </li>
                <%      
                    }               
                        if(category==""){
                            if(currentPage < lastPage){
                %>
                                    <li class="page-item">
                                        <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>" style="color: black;">다음페이지</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>" style="color: black;">마지막페이지</a>
                                    </li>
                            <%      
                                } else{
                            %>
                                <li class="page-item disabled">
                                    <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" style="color: black;">다음페이지</a>
                                </li>
                                <li class="page-item disabled">
                                    <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>" style="color: black;">마지막페이지</a>
                            <%
                                }
                            %>
                    <%          
                        }else{
                            if(currentPage < cateLastPage){
                    %>
                                <li class="page-item">
                                    <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" style="color: black;">다음페이지</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=cateLastPage%>&category=<%=category%>" style="color: black;">마지막페이지</a>
                                </li>
                    <%      
                        }else{
                    %>
                                <li class="page-item disabled">
                                    <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" style="color: black;">다음페이지</a>
                                </li>
                                <li class="page-item disabled">
                                    <a class="page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=cateLastPage%>&category=<%=category%>" style="color: black;">마지막페이지</a>
                    <%
                            }
                        }
                    %>
            </ul>
        </nav>      
</body>
</html>
