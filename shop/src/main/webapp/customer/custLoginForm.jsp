<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 세션변수 loginCustomer?
			
	
	if (session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	} 
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
		<style>
		body {
			font-family: Arial, sans-serif;
			background-color: #f0f0f0;
			margin: 0;
			padding: 0;
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh;
		}
		form {
			background-color: #ffffff;
			padding: 20px;
			border-radius: 8px;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}
		table {
			width: 100%;
		}
		table tr {
			margin-bottom: 10px;
		}
		table td {
			padding: 10px;
		}
		input[type="email"],
		input[type="password"] {
			width: 100%;
			padding: 8px;
			border-radius: 4px;
			border: 1px solid #ccc;
			box-sizing: border-box;
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
	<form method = "post" action = "/shop/customer/custLoginAction.jsp"> 
		<table>
			<tr>
				<td>login: </td>
				<td><input type = "email" name = "email"></td>
			</tr>
			<tr>
				<td>password: </td>
				<td><input type = "password" name = "pw"></td>
			</tr>
	
		</table>
			  <div class="button-container">
                <button type="submit">login</button>
            </div>
	</form>
</body>
</html>