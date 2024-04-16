<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>


<%
	String mail = request.getParameter("mail");
	if(mail == null){
	mail = "";
	}

	String ck = request.getParameter("ck");
	if(ck == null){
		ck = "";
	}
	String msg = "";
	if(ck.equals("T")){
		msg = "가입이 가능한 아이디입니다.";
	} else if(ck.equals("F")){
		msg = "이미 존재하는 아이디입니다.";
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
            background-color: #f5f5f5;
            margin: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        form {
            width: 60%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        input[type="email"],
        input[type="password"],
        input[type="text"],
        input[type="date"] {
            width: calc(100% - 20px);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        input[type="radio"] {
            margin-right: 10px;
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
	<h1>회원가입</h1>
				<form method = "post" action = "/shop/customer/checkIdAction.jsp">
					<table>	
					<tr>
						<td>mail : <%=mail %></td>
						<td>ck : <%=ck %></td>
					</tr>
					<tr>
					중복확인: 
						<td><input type = "email" name = "mail"></td>
						<td class = button-container><button type = "submit">중복확인</button></td>
						<td><%=msg %></td>
					</tr>
					</table>
				</form>
				<form method = "post" action = "/shop/customer/addCustomerAction.jsp">
			<table>
				<tr>
					<td>mail: </td>
					<%
						if(ck.equals("T")){
					%>
							<td><input type = "email" name = "mail" readonly = "readonly" value = "<%=mail%>"></td>
					<%
						}else{
					%>		
							<td><input type = "email" name = "mail" readonly = "readonly"></td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>pw: </td>
					<td><input type = "password" name = "pw"></td>
				</tr>
				<tr>
					<td>name: </td>
					<td><input type = "text" name = "name"></td>
				</tr>
				<tr>
					<td>birth: </td>
					<td><input type = "date" name = "birth"></td>
				</tr>
				<tr>
					<td>gender: </td>
					<td><input type = "radio" name = "gender" value = "여">여자</td>
					<td><input type = "radio" name = "gender" value = "남">남자</td>
				</tr>
				<tr>
					<td class="button-container">
						<button type = "submit">가입</button>
					</td>
				</tr>
			</table>
		</form>
</body>
</html>