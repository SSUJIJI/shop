<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="customer.dao.*" %>
<%@ page import = "java.util.*" %>

<%
    if(session.getAttribute("loginCustomer") == null){
        response.sendRedirect("/shop/customer/custLoginForm.jsp");
        return;
    } 

    HashMap<String,Object> loginMember = (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
    String mail = (String)(loginMember.get("mail"));

    int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
    int currentPage = (request.getParameter("currentPage") != null) ? Integer.parseInt(request.getParameter("currentPage")) : 1;
    int rowPerPage = 10;
    int startRow = ((currentPage-1) * rowPerPage);
    int totalRow = CommentDAO.totalRow(goodsNo);
    int lastPage = (totalRow % rowPerPage == 0) ? totalRow/rowPerPage : totalRow/rowPerPage + 1;

    HashMap<String,Object> goodslist = GoodsDAO.selectGoodsOne(goodsNo);
    ArrayList<HashMap<String,Object>> commentList = CommentDAO.selectComment(goodsNo, mail);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 상세 및 후기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/shop/css/styles.css"> <!-- Custom styles -->
</head>
<body>
<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/..	.시작하지 않는다 -->
	<jsp:include page = "/customer/inc/customerMenu.jsp"></jsp:include>
<div class="container mt-5">
    <!-- 주문 정보 -->
    <section class="order-details">
        <h2>주문 정보</h2>
        <form method="post" action="/shop/customer/addOrdersAction.jsp">
            <!-- 상품 정보 -->
            <div class="product-info">
                <img src="/shop/upload/<%=goodslist.get("filename")%>" alt="상품 이미지" class="product-image"  width="200">
                <h3><%=goodslist.get("goodsTitle")%></h3>
                <p>카테고리: <%=goodslist.get("category")%></p>
                <p>가격: <%=goodslist.get("goodsPrice")%>원</p>
                <input type="hidden" name="goodsNo" value="<%=goodslist.get("goodsNo")%>">
                <input type="hidden" name="goodsTitle" value="<%=goodslist.get("goodsTitle")%>">
                <input type="hidden" name="goodsPrice" value="<%=goodslist.get("goodsPrice")%>">
            </div>
            
            <!-- 주문 정보 입력 -->
            <div class="order-form">
                <!-- 주문 수량 -->
                <div class="form-group">
                    <label for="totalAmount">주문 수량</label>
                    <input type="number" class="form-control" name="totalAmount" required>
                </div>
                
                <!-- 상품 색상 -->
                <div class="form-group">
                    <label for="goodsColor">상품 색상</label>
                    <select name="goodsColor" class="form-control">
                        <option value="">-- 색상 선택 --</option>
                        <option value="스위트라벤더(PP)">스위트라벤더(PP)</option>
                        <option value="크림베이지(IVY)">크림베이지(IVY)</option>
                        <option value="에어리블루(BL)">에어리블루(BL)</option>
                        <option value="브라우니(BW)">브라우니(BW)</option>
                        <option value="코지민트(GR)">코지민트(GR)</option>
                        <option value="멜로우핑크(LPK)">멜로우핑크(LPK)</option>
                    </select>
                </div>
                
                <!-- 배송 주소 -->
                <div class="form-group">
                    <label for="address">배송 주소</label>
                    <textarea class="form-control" rows="2" name="address" required></textarea>
                </div>
                
                <!-- 주문 버튼 -->
                <button type="submit" class="btn btn-primary">주문하기</button>
            </div>
        </form>
    </section>

    <!-- 상품 후기 -->
    <section class="product-reviews mt-5">
        <h2>상품 후기</h2>
        <table class="table table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>No</th>
                    <th>평점</th>
                    <th>내용</th>
                    <th>작성자</th>
                    <th>작업</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(HashMap<String,Object> m : commentList){
                %>
                    <tr>
                        <td><%=m.get("ordersNo")%></td>
                        <td>
                            <div class="star-rating">
                                <% 
                                    for (int i = 1; i <= 5; i++) {
                                        if (i <= (Integer)(m.get("score"))) {
                                %>
                                    <span class="star filled-star">★</span>
                                <% 
                                        } else {
                                %>
                                    <span class="star">★</span>
                                <% 
                                        }
                                    }
                                %>
                            </div>
                        </td>
                        <td><%=m.get("content")%></td>
                        <td><%=m.get("mail")%></td>
                        <td>
                            <%
                                if(mail.equals(m.get("mail"))){
                            %>
                                <a href="/shop/customer/deleteCommentAction.jsp?ordersNo=<%=m.get("ordersNo")%>&mail=<%=m.get("mail")%>" class="btn btn-danger btn-sm">삭제</a>
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

        <!-- 페이지네이션 -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <%
                    if(currentPage > 1) {
                %>
                        <li class="page-item">
                            <a class="page-link" href="/shop/customer/goodsOne.jsp?currentPage=1&goodsNo=<%=goodsNo%>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="/shop/customer/goodsOne.jsp?currentPage=<%=currentPage-1%>&goodsNo=<%=goodsNo%>"><%=currentPage-1%></a>
                        </li>
                <%
                    } else {
                %>
                        <li class="page-item disabled">
                            <span class="page-link">&laquo;</span>
                        </li>
                <%
                    }
                %>

                <!-- 현재 페이지 -->
                <li class="page-item active"><span class="page-link"><%=currentPage%></span></li>

                <%
                    if(currentPage < lastPage) {
                %>
                        <li class="page-item">
                            <a class="page-link" href="/shop/customer/goodsOne.jsp?currentPage=<%=currentPage+1%>&goodsNo=<%=goodsNo%>"><%=currentPage+1%></a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="/shop/customer/goodsOne.jsp?currentPage=<%=lastPage%>&goodsNo=<%=goodsNo%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                <%
                    } else {
                %>
                        <li class="page-item disabled">
                            <span class="page-link">&raquo;</span>
                        </li>
                <%
                    }
                %>
            </ul>
        </nav>
    </section>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/shop/js/scripts.js"></script> <!-- Custom scripts -->
</body>
</html>
