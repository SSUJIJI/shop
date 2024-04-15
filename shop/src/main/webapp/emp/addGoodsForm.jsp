<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "shop.dao.*" %>
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	} 
 	
%>
<%	

//model layer
// 모델:특수한 형태의 데이터(RDBMS: mariadb) -> API사용하여 자료구조(ResultSet) 취득 -> 일반화된 자료구조(ArrayList<HashMap>)로 변경을 해야함 
// JDBC API 종속된 자료구조 모델 (ResultSet)-> 기본 API 자료구조 (ArrayList)로 변경
//ResultSet -> ArrayList<HashMap<String, Object>>

	ArrayList<String> categoryList = GoodsDAO.selectCategory();
	System.out.println(categoryList);
// JDBC API 사용이 끝났다면 DB자원 반납
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	 <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        h1 {
            text-align: center;
            margin-top: 20px;
        }
        form {
            width: 60%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        form div {
            margin-bottom: 15px;
        }
        label {
            display: inline-block;
            width: 100px;
            font-weight: bold;
        }
        select, input[type="text"], input[type="number"], textarea {
            width: calc(100% - 110px);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        select {
            cursor: pointer;
        }
        textarea {
            resize: none;
        }
        .button-container {
			text-align: center;
			margin-top: 20px;
		}
		.button-container button {
            background-color: #FFB2D9; /* 핑크색 */
            color: #fff; /* 흰색 텍스트 */
            border: none; /* 테두리 없음 */
            padding: 10px 20px; /* 안쪽 여백 설정 */
            border-radius: 4px; /* 모서리 둥글게 */
            cursor: pointer; /* 커서 모양 변경 */
            transition: background-color 0.3s ease; /* 호버 효과 */
        }
		button:hover {
			background-color: #FFD9EC;
		}
    </style>
</head>
<body>
<!-- 메인메뉴 -->
	<div>
		<jsp:include page = "/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<br>
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
		<div >
			goodsImage:
			<input type = "file" name = "goodsImg" >
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
		<div class="button-container">
			<button type = "submit">등록하기</button>
		</div>
	</form>
	
</body>
</html>