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
	String sql = "select category, create_date createDate from category";
	PreparedStatement stmt = null;	
	ResultSet rs= null;
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("category",rs.getString("category"));
		list.add(m);
	}
	
	System.out.println(list);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        td a {
            color: black;
            text-decoration: none;
        }
        td a:hover {
        	color: #F361DC;
            text-decoration: none;
        }
        .add-link {
            margin-top: 20px;
            text-align: right;
        }
        .add-link a {
            color: #F361DC;
            text-decoration: none;
        }
        .add-link a:hover {
            text-decoration: none;
        }
         th {
            font-size: 35px; /* category 글씨 크기 조절 */
        }
    </style>
</head>
<body>
<!-- empMenu.jsp include : 주체가 서버 vs redirect(주제:클라이언트) -->
	<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/..	.시작하지 않는다 -->
	<jsp:include page = "/emp/inc/empMenu.jsp"></jsp:include>
	<hr>
  <div class="container">
	<table>
	
		<tr>
			<th style = "text-align: center;">category</th>
		</tr>
			<%
				for(HashMap m : list){
			%>	
					<tr>
						<td>
							<a href = "/shop/emp/categoryOne.jsp?category=<%=(String)(m.get("category")) %>">
								<%=(String)(m.get("category")) %>
							</a>
						</td>	
					</tr>
			<%
				}
			%>
	</table>
	
	<div class="add-link">
			<a href="/shop/emp/addCategoryForm.jsp" class="btn btn-outline-secondary">추가</a>
	</div>
	
	
	</div>
</body>
</html>