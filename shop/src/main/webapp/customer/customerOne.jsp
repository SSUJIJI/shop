<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%@ page import = "java.util.*" %>

<%
    if (session.getAttribute("loginCustomer") == null){
        response.sendRedirect("/shop/customer/custLoginForm.jsp");
        return;
    }

    String mail = request.getParameter("mail");
    HashMap<String, Object> custOne = CustomerDAO.selectCustOne(mail);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/..	.시작하지 않는다 -->
	<jsp:include page = "/customer/inc/customerMenu.jsp"></jsp:include>
<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            회원 정보
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">메일</th>
                        <td><%=(String)(custOne.get("mail")) %></td>
                    </tr>
                    <tr>
                        <th scope="row">비밀번호</th>
                        <td><a href="/shop/customer/editPwForm.jsp?mail=<%=(String)(custOne.get("mail")) %>">비밀번호 수정</a></td>
                    </tr>
                    <tr>
                        <th scope="row">이름</th>
                        <td><%=(String)(custOne.get("name")) %></td>
                    </tr>
                    <tr>
                        <th scope="row">생년월일</th>
                        <td><%=(String)(custOne.get("birth")) %></td>
                    </tr>
                    <tr>
                        <th scope="row">성별</th>
                        <td><%=(String)(custOne.get("gender")) %></td>
                    </tr>
                    <tr>
                        <th scope="row">최근 업데이트 일자</th>
                        <td><%=(String)(custOne.get("updateDate")) %></td>
                    </tr>
                    <tr>
                        <th scope="row">가입 일자</th>
                        <td><%=(String)(custOne.get("createDate")) %></td>
                    </tr>
                    <tr>
                        <th scope="row">회원 탈퇴</th>
                        <td><a href="/shop/customer/dropCustomerAction.jsp?mail=<%=(String)(custOne.get("mail")) %>&pw=<%=(String)(custOne.get("pw"))%>&name=<%=(String)(custOne.get("name"))%>">회원탈퇴</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
