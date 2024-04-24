<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="customer.dao.*, java.util.*" %>

<%
    // 인증
    if(session.getAttribute("loginEmp") == null){
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    } 

    ArrayList<HashMap<String, Object>> checkList = CommentDAO.checkComment();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글 확인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- 직원 메뉴 포함 -->
    <jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
<div class="container mt-5">

    <table class="table table-bordered table-striped mt-4">
        <thead class="thead-dark">
            <tr>
                <th>No</th>
                <th>메일</th>
                <th>평점</th>
                <th>내용</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <%
                for(HashMap<String, Object> m : checkList){
            %>
                <tr>
                    <td><%= (Integer)(m.get("ordersNo")) %></td>
                    <td><%= (String)(m.get("mail")) %></td>
                    <td><%= (Integer)(m.get("score")) %></td>
                    <td><%= (String)(m.get("content")) %></td>
                    <td><a href="/shop/emp/deleteCommentAction.jsp?ordersNo=<%= (Integer)(m.get("ordersNo")) %>">삭제</a></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

</body>
</html>
