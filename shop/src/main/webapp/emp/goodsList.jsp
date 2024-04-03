<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<!-- control layer -->
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
	int currentPage = 1;
	if(request.getParameter("currentPage")!= null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = ((currentPage-1)*rowPerPage);
	
	String sql7 = "select count(*) cnt from goods";
	PreparedStatement stmt7 = null;
	stmt7 = conn.prepareStatement(sql7);
	ResultSet rs7 = null;
	rs7 = stmt7.executeQuery();
	
	int totalRow = 0;

	
	if(rs7.next()){
		totalRow = rs7.getInt("cnt");
	}
	
	System.out.println(totalRow +"<total");
	
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	System.out.println(currentPage +" <currentpage");
	
	String category = request.getParameter("category");
	/*
		null이면
		select * from goods 
		null이 아니면 
		select * from goods where category = ?;
	*/

%>
<!-- model layer -->
<%
	
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
	
	//category가 null 아닐때
	String sql2 = "select goods_no goodsNo, category, emp_id empId, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, update_date updateDate, create_date createDate from goods where category = ? limit ?,?";
	ResultSet rs2= null;
	PreparedStatement stmt2 = null;	
	stmt2 = conn.prepareStatement(sql2);	
	stmt2.setString(1,category);
	stmt2.setInt(2,startRow);
	stmt2.setInt(3,rowPerPage);
	rs2 = stmt2.executeQuery();

	System.out.println(stmt2+"<stmt2");

	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs2.next()){
		HashMap<String,Object> na = new HashMap<String, Object>();
		na.put("goodsNo", rs2.getInt("goodsNo"));
		na.put("category", rs2.getString("category"));
		na.put("empId", rs2.getString("empId"));
		na.put("goodsTitle", rs2.getString("goodsTitle"));
		na.put("goodsContent", rs2.getString("goodsContent"));
		na.put("goodsPrice", rs2.getInt("goodsPrice"));
		na.put("goodsAmount", rs2.getInt("goodsAmount"));
		na.put("updateDate", rs2.getString("updateDate"));
		na.put("createDate", rs2.getString("createDate"));
		list.add(na);
	}
	
	String sql3 = "select goods_no goodsNo, category, emp_id empId, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, update_date updateDate, create_date createDate from goods limit ?,?";
	ResultSet rs3= null;
	PreparedStatement stmt3 = null;	
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setInt(1,startRow);
	stmt3.setInt(2,rowPerPage);
	rs3 = stmt3.executeQuery();
	
	System.out.println(stmt3 + "<stmt3");

	ArrayList<HashMap<String,Object>> list2 = new ArrayList<HashMap<String, Object>>();
	while(rs3.next()){
		HashMap<String,Object> na2 = new HashMap<String, Object>();
		na2.put("goodsNo", rs3.getInt("goodsNo"));
		na2.put("category", rs3.getString("category"));
		na2.put("empId", rs3.getString("empId"));
		na2.put("goodsTitle", rs3.getString("goodsTitle"));
		na2.put("goodsContent", rs3.getString("goodsContent"));
		na2.put("goodsPrice", rs3.getInt("goodsPrice"));
		na2.put("goodsAmount", rs3.getInt("goodsAmount"));
		na2.put("updateDate", rs3.getString("updateDate"));
		na2.put("createDate", rs3.getString("createDate"));
		list2.add(na2);
	}

%>
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
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page = "/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div>
		<a href = "/emp/addGoods.jsp">상품등록</a>
	</div>
	<!-- 서브메뉴 카테고리별 상품리스트 -->
	<div>
		<a href = "/shop/emp/goodsList.jsp">전체</a>
		<%
			for(HashMap m : categoryList){
		%>		
				<a href = "/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
				<%=(String)(m.get("category"))%>
				(<%=(Integer)(m.get("cnt"))%>)</a>
		<%
			}
		%>
	</div>
				<table >
					<tr>
						<td>No.</td>
						<td>Category</td>
						<td>Id</td>
						<td>Title</td>
						<td>Content</td>
						<td>Price</td>
						<td>Amount</td>
						<td>updateDate</td>
						<td>createDate</td>
					</tr>
					<%
					if(category==null){
						for(HashMap<String,Object> na2 : list2){
					%>	
					<tr>
						<td><%=(Integer)(na2.get("goodsNo"))%></td>
						<td><%=(String)(na2.get("category"))%></td>
						<td><%=(String)(na2.get("empId"))%></td>
						<td><%=(String)(na2.get("goodsTitle"))%></td>
						<td><%=(String)(na2.get("goodsContent"))%></td>
						<td><%=(Integer)(na2.get("goodsPrice"))%></td>
						<td><%=(Integer)(na2.get("goodsAmount"))%></td>
						<td><%=(String)(na2.get("updateDate"))%></td>
						<td><%=(String)(na2.get("createDate"))%></td>
					</tr>
					
			<%
						}
					}else 	{
						for(HashMap<String,Object> na : list){
			%>	
					
					<tr>
						<td><%=(Integer)(na.get("goodsNo"))%></td>
						<td><%=(String)(na.get("category"))%></td>
						<td><%=(String)(na.get("empId"))%></td>
						<td><%=(String)(na.get("goodsTitle"))%></td>
						<td><%=(String)(na.get("goodsContent"))%></td>
						<td><%=(Integer)(na.get("goodsPrice"))%></td>
						<td><%=(Integer)(na.get("goodsAmount"))%></td>
						<td><%=(String)(na.get("updateDate"))%></td>
						<td><%=(String)(na.get("createDate"))%></td>
					</tr>
				
			<%	
				}
			}
			%>
			</table>		
			<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-end">
			<%
				if(currentPage > 1) {
			%>
				<li class="page-item">
					<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">처음페이지</a>
				</li>
				<li class="page-item">
					<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">이전페이지</a>
				</li>																
			<%		
				} else {
			%>
				<li class="page-item disabled">
					<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">처음페이지</a>
				</li>
				<li class="page-item disabled">
					<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">이전페이지</a>
				</li>
			<%		
				}				
				if(currentPage < lastPage) {
			%>
				<li class="page-item">
					<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음페이지</a>
				</li>
				<li class="page-item">
					<a class = "page-link" href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">마지막페이지</a>
				</li>
			<%		
				}
			%>
			</ul>
		</nav>		

</body>
</html>