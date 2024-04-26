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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Comment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        form {
            max-width: 600px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
        }

        table tr td {
            padding: 10px;
        }

        .star-rating input[type="radio"] {
            display: none;
        }

        .star-rating label {
            font-size: 25px;
            color: #ccc;
            cursor: pointer;
        }

        .star-rating input[type="radio"]:checked ~ label {
            color: #ffcc00;
        }

        textarea {
            width: calc(100% - 20px);
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            resize: vertical;
        }

        button[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            border: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <form method="post" action="/shop/customer/addCommentAction.jsp">
        <table>
            <tr>
                <td> 아이디 </td>
                <td>주문 번호</td>
                <td>상품 번호</td>
                <td>  별점 </td>
                <td> 내용 </td>
            </tr>
            <tr>
                <td>
                    <input type="hidden" name="mail" value="<%=mail %>">
                    <%=mail %>
                </td>
                <td>
                    <input type="hidden" name="ordersNo" value="<%=ordersNo %>">
                      <%=ordersNo %>
                </td>
                <td>
                    <input type="hidden" name="goodsNo" value="<%=goodsNo%>">
                      <%=goodsNo %>
                </td>
                <td class="star-rating">
                    <input type="radio" id="star5" name="score" value="5"><label for="star5">★</label>
                    <input type="radio" id="star4" name="score" value="4"><label for="star4">★</label>
                    <input type="radio" id="star3" name="score" value="3"><label for="star3">★</label>
                    <input type="radio" id="star2" name="score" value="2"><label for="star2">★</label>
                    <input type="radio" id="star1" name="score" value="1"><label for="star1">★</label>
                </td>
                <td>
                    <textarea rows="3" name="content"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="5" align="center">
                    <button type="submit">작성하기</button>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>