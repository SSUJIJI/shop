<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String mail = request.getParameter("mail");
	
	System.out.println(ordersNo);
	System.out.println(goodsNo);
	System.out.println(mail);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
  <style>
        /* 별 모양의 라디오 버튼 스타일 */
        .star-rating input[type="radio"] {
            display: none;
        }
        .star-rating label {
            font-size: 25px;
            color: #ccc;
            cursor: pointer;
             flex-direction: row-reverse; /* 왼쪽에서 오른쪽으로 정렬 */
            justify-content: flex-end;
        }
        .star-rating input[type="radio"]:checked ~ label {
            color: #ffcc00; /* 선택된 별의 색상 */
        }
    </style>
</head>
<body>
<form method = "post" action = "/shop/customer/addCommentAction.jsp">
	<table>
		<tr>
			<td>아이디</td>
			<td>주문번호</td>
			<td>상품번호</td>
			<td>별점</td>
			<td>내용</td>
		</tr>
		<tr>
			<td><input type = "hidden" name = "mail" value ="<%=mail %>" ><%=mail %></td>
			<td><input type = "hidden" name = "ordersNo" value = "<%=ordersNo %>"><%=ordersNo %></td>
			<td><input type = "hidden" name = "goodsNo" value = "<%=goodsNo%>"><%=goodsNo %></td>
			  <td class="star-rating">
                <input type="radio" id="star5" name="score" value="5"><label for="star5">★</label>
                <input type="radio" id="star4" name="score" value="4"><label for="star4">★</label>
                <input type="radio" id="star3" name="score" value="3"><label for="star3">★</label>
                <input type="radio" id="star2" name="score" value="2"><label for="star2">★</label>
                <input type="radio" id="star1" name="score" value="1"><label for="star1">★</label>
            </td>
			<td><textarea rows="3" cols="15" name = "content"></textarea></td>
		</tr>
		<tr>
			<td>
				<button type = "submit">작성하기</button>
			</td>
	</table>
</form>
</body>
</html>