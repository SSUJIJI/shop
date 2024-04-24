<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="customer.dao.*, java.util.*" %>

<%
    // 인증
    if(session.getAttribute("loginEmp") == null){
        response.sendRedirect("/shop/emp/empLoginForm.jsp");
        return;
    } 

    int currentPage = 1;
    if(request.getParameter("currentPage") != null){
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    
    int rowPerPage = 10;
    int startRow = (currentPage - 1) * rowPerPage;
    
    int totalRow = OrdersDAO.totalRow2();
    int lastPage = totalRow / rowPerPage;
    if(totalRow % rowPerPage != 0){
        lastPage = lastPage + 1;
    }

    ArrayList<HashMap<String, Object>> listAll = OrdersDAO.selectOrderListAll(startRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/..	.시작하지 않는다 -->
	<jsp:include page = "/emp/inc/empMenu.jsp"></jsp:include>
<div class="container mt-5">
    <table class="table table-bordered">
        <thead class="thead-dark">
            <tr>
                <th>주문번호</th>
                <th>이메일</th>
                <th>상품색상</th>
                <th>총 수량</th>
                <th>총 가격</th>
                <th>주소</th>
                <th>상태</th>
                <th>수정일</th>
            </tr>
        </thead>
        <tbody>
            <%
                for(HashMap<String, Object> m : listAll){
            %>
                <tr>
                    <td><%= (Integer)(m.get("ordersNo")) %></td>
                    <td><%= (String)(m.get("mail")) %></td>
                    <td><%= (String)(m.get("goodsColor")) %></td>
                    <td><%= (Integer)(m.get("totalAmount")) %></td>
                    <td><%= (Integer)(m.get("totalPrice")) %></td>
                    <td><%= (String)(m.get("address")) %></td>
                    <td>
                    <%
                        String state = (String)(m.get("state"));
                        if(state.equals("배송완료") || state.equals("주문취소") || state.equals("배송중")){
                    %>
                            <%= state %>
                    <%
                        } else {
                    %>
                            <a href="/shop/emp/modifyOrdersAction.jsp?ordersNo=<%= (Integer)(m.get("ordersNo")) %>&state=<%= state %>">
                            <%= state %></a>
                            <%
                                if(state.equals("배송중") || state.equals("결제완료")){
                            %>
                                <!-- 추가 기능 -->
                            <%
                                } else {
                            %>
                                    <a href="/shop/emp/dropOrdersAction.jsp?ordersNo=<%= (Integer)(m.get("ordersNo")) %>&state=<%= state %>">
                                    <%= state %></a>
                            <%
                                }
                            %>
                    <%
                        }
                    %>
                    </td>
                    <td><%= (String)(m.get("updateDate")) %></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
    
    <div class="d-flex justify-content-center">
        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <%
                    if(currentPage > 1) {
                %>
                        <li class="page-item">
                            <a class="page-link" href="/shop/emp/ordersCheckList.jsp?currentPage=1">처음페이지</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="/shop/emp/ordersCheckList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
                        </li>
                <%
                    } else {
                %>
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">처음페이지</a>
                        </li>
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">이전페이지</a>
                        </li>
                <%
                    }
                %>
                <%
                    if(currentPage < lastPage) {
                %>
                        <li class="page-item">
                            <a class="page-link" href="/shop/emp/ordersCheckList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="/shop/emp/ordersCheckList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
                        </li>
                <%
                    } else {
                %>
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">다음페이지</a>
                        </li>
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">마지막페이지</a>
                        </li>
                <%
                    }
                %>
            </ul>
        </nav>
    </div>
</div>
</body>
</html>
