<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	//로그인 세션변수 loginCustomer
			
	
	if (session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
%>


	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>

        /* 스타일 추가 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #333;
            padding: 10px 20px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
            transition: color 0.3s;
        }

        .navbar a:hover {
            color: #ddd;
        }

        .welcome-message {
            margin-right: 20px;
        }
    </style>
<div class="navbar">
	<!-- category CRUD  -->
 	<div class="welcome-message">
            <% 
                HashMap<String,Object> loginCustomer = (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
                if (loginCustomer != null) {
            %>
                    <a href="/shop/customer/customerOne.jsp?name=<%= loginCustomer.get("name") %>&mail=<%=loginCustomer.get("mail")%>"><%= loginCustomer.get("name") %>님</a> 반갑습니다
            <% 
                }
            %>
        </div>
    </div>
</div>