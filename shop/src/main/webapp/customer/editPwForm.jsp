<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//로그인 세션변수 loginCustomer
			
	
	if (session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
%>
<%
	String mail = request.getParameter("mail");
	System.out.println(mail);
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Password</title>
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
            max-width: 400px;
            width: 100%;
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

        input[type="text"],
        input[type="password"] {
            width: calc(100% - 22px);
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
            background-color: #FFB2D9;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
            max-width: 200px;
            margin: 0 auto;
        }

        button:hover {
            background-color: black;
        }
    </style>
</head>
<body>
<form method="post" action="/shop/customer/editPwAction.jsp">
    <table>
        <tr>
            <td>Mail:</td>
            <td><input type="text" name="mail" value="<%=mail%>" readonly="readonly"></td>
        </tr>
        <tr>
            <td>이전 비밀번호:</td>
            <td><input type="password" name="oldPw"></td>
        </tr>
        <tr>
            <td>변경할 비밀번호:</td>
            <td><input type="password" name="newPw"></td>
        </tr>
    </table>
    <div class="button-container">
        <button type="submit">수정하기</button>
    </div>
</form>
</body>
</html>
