<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "customer.dao.*" %>
<%@ page import = "java.util.*" %>

<%
	//로그인 인증분기 : 세션 변수 이름 loginCustomer
	if(session.getAttribute("loginCustomer")== null){
		response.sendRedirect("/shop/customer/custLoginForm.jsp");
		return;
	} 
	
	String mail = request.getParameter("mail");
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	
	int startRow = ((currentPage-1)*rowPerPage);
	int totalRow = OrdersDAO.totalRow(mail);

	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage+1;
	}
	
	ArrayList<HashMap<String,Object>> checkOne = OrdersDAO.selectOrderListByCustomer(mail, startRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 내역</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/..	.시작하지 않는다 -->
	<jsp:include page = "/customer/inc/customerMenu.jsp"></jsp:include>
<div class="container mt-5">
	<h2 class="text-center">주문 내역</h2>
	<table class="table table-bordered table-striped">
		<thead>
			<tr>
				<th scope="col">No</th>
				<th scope="col">Mail</th>
				<th scope="col">Goods Color</th>
				<th scope="col">Total Amount</th>
				<th scope="col">Total Price</th>
				<th scope="col">Address</th>
				<th scope="col">State</th>
				<th scope="col">Update Date</th>
				<th scope="col"></th>
			</tr>
		</thead>
		<tbody>
			<%
				for(HashMap<String,Object> m : checkOne){
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
							if(m.get("state").equals("배송완료") || m.get("state").equals("주문취소")||m.get("state").equals("결제완료")){
						%>
								<%= m.get("state") %>
						<%	
							}else{
						%>
							<a href="/shop/customer/shippingModify.jsp?ordersNo=<%= (Integer)(m.get("ordersNo")) %>&state=<%= (String)(m.get("state")) %>&mail=<%= (String)(m.get("mail")) %>">
							<%= (String)(m.get("state")) %></a>
						<% 
							}
						%>
						</td>
						<td><%= (String)(m.get("updateDate")) %></td>
						<td>
						<%
							if(m.get("state").equals("배송완료")){
						%>
								<a href="/shop/customer/addCommentForm.jsp?ordersNo=<%= (Integer)(m.get("ordersNo")) %>&goodsNo=<%= (Integer)(m.get("goodsNo")) %>&mail=<%= (String)(m.get("mail")) %>">후기작성</a>
						<%		
							}else if(m.get("state").equals("결제완료")){
						%>		
								<a href="/shop/customer/dropOrdersAction.jsp?ordersNo=<%= (Integer)(m.get("ordersNo")) %>&goodsNo=<%= (Integer)(m.get("goodsNo")) %>&totalAmount=<%= (Integer)(m.get("totalAmount")) %>&goodsAmount=<%= (Integer)(m.get("goodsAmount")) %>">주문취소</a>
						<%
							}
						%>
						</td>
					</tr>	
			<%	
				}
			%>
		</tbody>
	</table>

	<div class="pagination-container">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<%
					if(currentPage > 1) {
				%>
						<li class="page-item">
							<a class="page-link" href="/shop/customer/ordersCheckList.jsp?currentPage=1" style="color: black;">처음페이지</a>
						</li>
						<li class="page-item">
							<a class="page-link" href="/shop/customer/ordersCheckList.jsp?currentPage=<%= currentPage-1 %>" style="color: black;">이전페이지</a>
						</li>                                                                
				<%      
					} else {
				%>
						<li class="page-item disabled">
							<a class="page-link" href="/shop/customer/ordersCheckList.jsp?currentPage=1" style="color: black;">처음페이지</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link" href="/shop/customer/ordersCheckList.jsp?currentPage=<%= currentPage-1 %>" style="color: black;">이전페이지</a>
						</li>
				<%
					}
				%>
				<%          
					if(currentPage < lastPage){
				%>
						<li class="page-item">
							<a class="page-link" href="/shop/customer/ordersCheckList.jsp?currentPage=<%= currentPage+1 %>" style="color: black;">다음페이지</a>
						</li>
						<li class="page-item">
							<a class="page-link" href="/shop/customer/ordersCheckList.jsp?currentPage=<%= lastPage %>" style="color: black;">마지막페이지</a>
						</li>
				<%      
					}else{
				%>
						<li class="page-item disabled">
							<a class="page-link" href="/shop/customer/ordersCheckList.jsp?currentPage=<%= currentPage+1 %>" style="color: black;">다음페이지</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link" href="/shop/customer/ordersCheckList.jsp?currentPage=<%= lastPage %>" style="color: black;">마지막페이지</a>
						</li>
				<%
					}
				%>
			</ul>
		</nav>      
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
