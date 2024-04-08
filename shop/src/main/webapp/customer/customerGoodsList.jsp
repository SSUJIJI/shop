<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.nio.file.*" %>
<!-- control layer -->
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
 	
%>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	int currentPage = 1;
	if(request.getParameter("currentPage")!= null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 9;
	int startRow = ((currentPage-1)*rowPerPage);
	
	String sql3 = "select count(*) cnt from goods";
	PreparedStatement stmt3 = null;
	stmt3 = conn.prepareStatement(sql3);
	ResultSet rs3 = null;
	rs3 = stmt3.executeQuery();
	
	int totalRow = 0;

	
	if(rs3.next()){
		totalRow = rs3.getInt("cnt");
	}
	
	System.out.println(totalRow +"<total");
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	System.out.println(currentPage +" <currentpage");
	
	
	/*
		null이면
		select * from goods 
		null이 아니면 
		select * from goods where category = ?;
	*/

%>
<!-- model layer -->
<%
	String category = "";
	if(request.getParameter("category")!=null){
		category = request.getParameter("category");
	}
	//category별 개수
	ResultSet rs1= null;
	PreparedStatement stmt1 = null;	
	
	String sql1 = "select category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category asc";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	ArrayList<HashMap<String,Object>> categoryList = new ArrayList<HashMap<String,Object>>();
	
	while(rs1.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("category", rs1.getString("category"));
		m.put("cnt", rs1.getInt("cnt"));
		categoryList.add(m);
	}
	//디버깅
	System.out.println(categoryList);
	
	String sql4 = "select category, COUNT(*) cnt FROM goods where category = ? GROUP BY category";
	PreparedStatement stmt4 = null;
	stmt4 = conn.prepareStatement(sql4);
	stmt4.setString(1,category);
	ResultSet rs4 = null;
	rs4 = stmt4.executeQuery();
	
	int cateTotalRow = 0;

	
	if(rs4.next()){
		cateTotalRow = rs4.getInt("cnt");
	}
	System.out.println(cateTotalRow +"<cateTotal");

	int cateLastPage = cateTotalRow/rowPerPage;
	
	if(cateTotalRow % rowPerPage != 0){
		cateLastPage = cateLastPage+1;
	}
	System.out.println(cateLastPage +"<cateLastPage");

	
	
	//category에 따른 상품 보여주는 list

	String sql2 = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_price goodsPrice from goods where category like ? limit ?,?";
	ResultSet rs2= null;
	PreparedStatement stmt2 = null;	
	stmt2 = conn.prepareStatement(sql2);	
	stmt2.setString(1,"%"+category+"%");
	stmt2.setInt(2,startRow);
	stmt2.setInt(3,rowPerPage);
	rs2 = stmt2.executeQuery();

	System.out.println(stmt2+"<stmt2");

	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs2.next()){
		HashMap<String,Object> na = new HashMap<String, Object>();
		na.put("goodsNo", rs2.getInt("goodsNo"));
		na.put("category", rs2.getString("category"));
		na.put("goodsTitle", rs2.getString("goodsTitle"));
		na.put("filename", rs2.getString("filename"));
		na.put("goodsPrice", rs2.getInt("goodsPrice"));
		list.add(na);
	}

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
    <!-- 서브메뉴 카테고리별 상품리스트 -->
    <div class="container-fluid">
        <div class="row justify-content-end">
            <div class="col-auto">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a href="/shop/customer/customerGoodsList.jsp" class="nav-link" style="color: black;">전체</a>
                    </li>
                    <%
                        for(HashMap m : categoryList){
                    %>
                            <li class="nav-item">
                                <a href="/shop/customer/customerGoodsList.jsp?category=<%=(String)(m.get("category"))%>" class="nav-link" style="color: black;">
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
                for(HashMap<String,Object> na : list){
            %>  
            <div class="col-4">
                <div>
                    <a href="/shop/emp/goodsOne.jsp?goodsNo=<%=(Integer)(na.get("goodsNo"))%>">
                    <img src="/shop/upload/<%=(String)(na.get("filename")) %>" width="100">
                    </a>
                </div>
                <div><%=(String)(na.get("category")) %></div>
                <div><%=(String)(na.get("goodsTitle"))%></div>
                <div><%=(Integer)(na.get("goodsPrice"))%></div><br>
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
                            <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=1&category=<%=category%>" style="color: black;">처음페이지</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>" style="color: black;">이전페이지</a>
                        </li>                                                                
                <%      
                    } else {
                %>
                        <li class="page-item disabled">
                            <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=1&category=<%=category%>" style="color: black;">처음페이지</a>
                        </li>
                        <li class="page-item disabled">
                            <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>" style="color: black;">이전페이지</a>
                        </li>
                <%      
                    }               
                        if(category==""){
                            if(currentPage < lastPage){
                %>
                                    <li class="page-item">
                                        <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage+1%>" style="color: black;">다음페이지</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=lastPage%>" style="color: black;">마지막페이지</a>
                                    </li>
                            <%      
                                } else{
                            %>
                                <li class="page-item disabled">
                                    <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" style="color: black;">다음페이지</a>
                                </li>
                                <li class="page-item disabled">
                                    <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>" style="color: black;">마지막페이지</a>
                            <%
                                }
                            %>
                    <%          
                        }else{
                            if(currentPage < cateLastPage){
                    %>
                                <li class="page-item">
                                    <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" style="color: black;">다음페이지</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=cateLastPage%>&category=<%=category%>" style="color: black;">마지막페이지</a>
                                </li>
                    <%      
                        }else{
                    %>
                                <li class="page-item disabled">
                                    <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" style="color: black;">다음페이지</a>
                                </li>
                                <li class="page-item disabled">
                                    <a class="page-link" href="/shop/customer/customerGoodsList.jsp?currentPage=<%=cateLastPage%>&category=<%=category%>" style="color: black;">마지막페이지</a>
                    <%
                            }
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
