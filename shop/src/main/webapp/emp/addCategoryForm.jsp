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
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	 <style>
        /* Custom button style */
        .button {
            color: black; /* 흰색 텍스트 */
            padding: 10px 20px; /* 내부 여백 */
            border: none; /* 테두리 없음 */
            border-radius: 5px; /* 버튼 모서리 둥글게 */
            cursor: pointer; /* 커서를 포인터로 변경 */
            transition: background-color 0.3s ease; /* 호버 효과 전환 시간 */
        }

        /* Button hover effect */
        .button:hover {
            background-color: #FFB2F5; /* 호버 시 더 진한 핑크색으로 변경 */
        }
        .custom-form {
            max-width: 400px; /* 폼 최대 너비 설정 */
            margin: auto; /* 수평 가운데 정렬 */
            padding: 20px; /* 폼 내부 여백 설정 */
            border: 1px solid #ccc; /* 폼 테두리 설정 */
            border-radius: 10px; /* 폼 모서리 둥글게 설정 */
        }
        .custom-form-container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
       </style>
</head>
<body>
	<div class="custom-form-container">
			<form method = "post" action = "/shop/emp/addCategoryAction.jsp" class="custom-form">
				 <div class="mb-3">
					<label for="category" class="form-label" style = "font-size: 25px;">Category</label>
	                <input type="text" name="category" class="form-control" id="category">
	            </div>
	                <input type="hidden" name="createDate">
	            <div class="text-center ">
	               	<button type="submit" class="button">추가하기</button>
				</div>
			</form>
			</div>
</body>
</html>