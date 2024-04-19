package customer.dao;

import java.sql.*;
import java.util.*;

import shop.dao.DBHelper;


public class OrdersDAO {
	//고객이 자신의 주문을 확인
	// customer/ordersCheck.jsp
	public static ArrayList<HashMap<String, Object>> selectOrderListByCustomer(String mail, int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT o.mail mail, o.goods_color goodsColor, o.total_amount totalAmout, o.total_price totalPrice, o.address, o.state, o.update_date updateDate"
				+ " from orders o inner join goods g"
				+ " on o.goods_no = g.goods_no "
				+ " WHERE o.mail = ? LIMIT ?,?";
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,mail);
		stmt.setInt(2, startRow);
		stmt.setInt(3,rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("mail", rs.getString("mail"));
			m.put("goodsColor", rs.getString("goodsColor"));
			m.put("totalAmout", rs.getInt("totalAmout"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("address", rs.getString("o.address"));
			m.put("state", rs.getString("o.state"));
			m.put("updateDate", rs.getString("updateDate"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	//고객 페이지 totalRow
	public static int totalRow(String mail) throws Exception{
		
		int totalRow = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "select count(*) cnt from orders where mail =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,mail);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()){
			totalRow = rs.getInt("cnt");
		}
			
		conn.close();
		return totalRow;
		
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
	//modifyOrdersAction에서 action을 바꾸는 sql
		public static int modifyOrders(String goodsNo, String active) throws Exception {
			
			int row = 0 ;
			Connection conn = DBHelper.getConnection();
			String sql = "update orders set state = ? where goods_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			if(active.equals("결제중")){
				stmt.setString(1,"결제완료");
			}else if(active.equals("결제완료")){
				stmt.setString(1,"배송완료");
			}
			stmt.setString(2,goodsNo);
			
			row = stmt.executeUpdate(); 
			
			conn.close();
			return row;
		}
	//고객이 자신의 주문 액션
	// customer/addOrdersAction.jsp
	// int goodsNo, String goodsTitle, String color
	// return : row
	public static int insertOrders( 
			String mail,
			int goodsNo,
			int goodsPrice,
			String goodsColor,
			int goodsAmount,
			String address
			) throws Exception{
		
		int row = 0;
		int totalPrice = goodsAmount*goodsPrice;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO orders( mail, goods_no, goods_color, total_amount, total_price,address, state, create_date, update_date)"
				+ "VALUES(?,?,?,?,?,?,'결제완료',NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2,goodsNo);
		stmt.setString(3, goodsColor);
		stmt.setInt(4, goodsAmount);
		stmt.setInt(5, totalPrice);
		stmt.setString(6, address);
		row = stmt.executeUpdate();
		

		conn.close();
		return row;
	}
}
