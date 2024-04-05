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
	
	//model layer
	// 모델:특수한 형태의 데이터(RDBMS: mariadb) -> API사용하여 자료구조(ResultSet) 취득 -> 일반화된 자료구조(ArrayList<HashMap>)로 변경을 해야함 
	String sql1 = "select category from category";
	PreparedStatement stmt1 = null;
	stmt1 = conn.prepareStatement(sql1);
	ResultSet rs1 = null;
	rs1 = stmt1.executeQuery(); 
	// JDBC API 종속된 자료구조 모델 (ResultSet)-> 기본 API 자료구조 (ArrayList)로 변경
	ArrayList<String> categoryList = new ArrayList<String>();
	
	//ResultSet -> ArrayList<HashMap<String, Object>>
	while(rs1.next()){
		categoryList.add(rs1.getString("category"));
		}
	
	System.out.println(categoryList);
	// JDBC API 사용이 끝났다면 DB자원 반납
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<!-- 메인메뉴 -->
	<div>
		<jsp:include page = "/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<h1>상품등록</h1>
	<form method = "post" action = "/shop/emp/addGoodsAction.jsp" enctype = "multipart/form-data">
		<div>
			category:
			<select name = "category">
				<option value = "">선택</option>
				<%
					for(String c : categoryList){
				%>
					<option value = "<%=c%>"><%=c %></option>
				<%	
					}
				%>
			</select>
		</div>
		<!-- emp_id값은 세션변수에서 바인딩 -->
		<div>
			goodsTitle:
			<input type = "text" name = "goodsTitle">
		</div>
		<div>
			goodsImage:
			<input type = "file" name = "goodsImg">
		</div>
		<div>
			goodsPrice
			<input type = "number" name = "goodsPrice">
		</div>
		<div>
			goodsAmount:
			<input type = "number" name = "goodsAmount">
		</div>
		<div>
			goodsContent
			<textarea cols="50" rows= "5" name = "content"></textarea>
		</div>
		<button type = "submit">등록하기</button>
	</form>
	
</body>
</html>