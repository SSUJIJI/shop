<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	//로그인 인증분기 : 세션 변수 이름 loginEmp
	
	
	
	if (session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	} 
	
	String errMsg = request.getParameter("errMsg");
%>




<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<style>
        /* 스타일 추가 */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        form {
            width: 300px; /* 폼의 너비 지정 */
            padding: 20px; /* 폼의 안쪽 여백 지정 */
            border: 1px solid #ccc; /* 폼의 테두리 스타일 지정 */
            border-radius: 5px; /* 폼의 테두리를 둥글게 만듦 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
        }
        
        button[type="submit"] {
            align-self: flex-end;
        }
        .button-container {
            display: flex;
            justify-content: flex-end;
        }
    </style>
</head>
<body>


 	<div>
	<%
		if(errMsg != null){
	%>	
			<%=errMsg %>
	<%
		}
	%>
		</div>
	<form method = "post" action = "/shop/emp/empLoginAction.jsp"> 
		<table>
			<tr>
				<td>login: </td>
				<td><input type = "text" name = "empId"></td>
			</tr>
			<tr>
				<td>password: </td>
				<td><input type = "password" name = "empPw"></td>
			</tr>
	
		</table>
			  <div class="button-container">
                <button type="submit">login</button>
            </div>
	</form>

	
</body>
</html>