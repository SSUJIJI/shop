package customer.dao;

import java.sql.*;
import java.util.*;

public class OrdersDAO {
	//고객이 자신의 주문을 확인
	public static ArrayList<HashMap<String, Object>> selectOrderListByCustomer(String mail, int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();

		String sql = "from orders o inner join goods g on o.goods_no = g.goods_no";
		
		return list;
	}
	//관리자 전체주문을 확인(페이징)
	public static ArrayList<HashMap<String, Object>> selectOrderListAll(int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();

		String sql = "select o.orders_no ordersNo,"
				+ "			 o.goods_no g.goodsNo,"
				+ "			g.goods_title goodsTitle"
				+ "from orders o inner join goods g"
				+ "on o.goods_no = g.goods_no"
				+ "where o.mail = ?"				
				+ "order by o.orders_no desc"
				+ "offset ? rows fetch next ? rows only";
		
		return list;
		}
	
	//고객이 자신의 주문 액션
	// customer/addOrdersAction.jsp
	// int goodsNo, String goodsTitle, String color
	// return : row
	public static int row(int goodsNo, String goodsColor,
			String mail,
			int goodsAmount,
			int totalPrice,
			String address,
			String state
			) throws Exception{
		
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO orders(mail, goods_no, total_amount, total_price, address, state, create_date, update_date)"
				+ "VALUES(?,?,?,?,?,?,NOW(),NOW());";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, goodsAmount);
		stmt.setInt(4, totalPrice);
		stmt.setString(5, address);
		stmt.setString(6, state);
		row = stmt.executeUpdate();
		

		conn.close();
		return row;
	}
}
