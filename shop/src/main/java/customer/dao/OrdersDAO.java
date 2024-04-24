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
		String sql = "SELECT o.mail mail, o.orders_no ordersNo, o.goods_color goodsColor, g.goods_no goodsNo, o.total_amount totalAmount, o.total_price totalPrice, o.address, o.state, o.update_date updateDate, g.goods_amount goodsAmount"
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
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsAmount", rs.getInt("goodsAmount"));
			m.put("totalAmount", rs.getInt("totalAmount"));
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
	
	//modifyOrdersAction에서 action을 바꾸는 sql
		public static int modifyOrders(String goodsNo, String state) throws Exception {
			
			int row = 0 ;
			Connection conn = DBHelper.getConnection();
			String sql = "update orders set state = ? where goods_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			if(state.equals("결제중")){
				stmt.setString(1,"결제완료");
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
			int totalAmount,
			String address
			) throws Exception{
		
		int row = 0;
		int totalPrice = totalAmount*goodsPrice;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO orders( mail, goods_no, goods_color, total_amount, total_price,address, state, create_date, update_date)"
				+ "VALUES(?,?,?,?,?,?,'결제완료',NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2,goodsNo);
		stmt.setString(3, goodsColor);
		stmt.setInt(4, totalAmount);
		stmt.setInt(5, totalPrice);
		stmt.setString(6, address);
		row = stmt.executeUpdate();
		

		conn.close();
		return row;
	}
	//고객이 자신의 주문 취소 액션 결제완료 -> 주문취소
	//customer/dropOrdersAction.jsp
	//
	//return : row
	public static int dropOrders (int ordersNo) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "update orders set state = ? where orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "주문취소");
		stmt.setInt(2,ordersNo);
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	//관리자 전체주문을 확인(페이징)
	public static ArrayList<HashMap<String, Object>> selectOrderListAll(int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		String sql = "SELECT o.mail mail, o.goods_color goodsColor, o.goods_no goodsNo, o.orders_no ordersNo, o.total_amount totalAmount, o.total_price totalPrice, o.address, o.state, o.update_date updateDate"
				+ " from orders o inner join goods g "
				+ " on o.goods_no = g.goods_no "
				+ "LIMIT ?,?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("mail", rs.getString("mail"));
			m.put("goodsColor", rs.getString("goodsColor"));
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("address", rs.getString("address"));
			m.put("state", rs.getString("state"));
			m.put("updateDate", rs.getString("updateDate"));
			list.add(m);
		}
		conn.close();
		return list;
	}
	//modifyOrdersAction에서 '결제완료->배송중'을 바꾸는 sql
	public static int shippingModify (String ordersNo, String state) throws Exception {
		int row = 0;
		String sql = "update orders set state = ? where orders_no = ?";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		if(state.equals("결제완료")){
			stmt.setString(1,"배송중");
		}
		stmt.setString(2,ordersNo);
		
		row = stmt.executeUpdate(); 
		
		conn.close();
		return row;
	
	}
	
	//ordersCheckList에서 '배송중->배송완료' and 결제완료는 못 누르게
	public static int successModify (String ordersNo, String state) throws Exception{
		int row = 0;
		String sql = "update orders set state = ? where orders_no = ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		if(state.equals("배송중")){
			stmt.setString(1,"배송완료");
		}
		stmt.setString(2,ordersNo);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;
	
	
	}
	//직원 페이지 totalRow
		public static int totalRow2() throws Exception{
			
			int totalRow = 0;
			Connection conn = DBHelper.getConnection();
			String sql = "select count(*) cnt from orders";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			ResultSet rs = stmt.executeQuery();
			
			if(rs.next()){
				totalRow = rs.getInt("cnt");
			}
				
			conn.close();
			return totalRow;
			
			}
	
}
