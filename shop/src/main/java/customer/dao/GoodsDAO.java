package customer.dao;

import java.util.*;
import java.awt.List;
import java.sql.*;

public class GoodsDAO {
	
	//고객 로그인 후 상품목록 페이지
	// /customer/goodsList.jsp
	// param : void 
	// return : Goods(일부속성)의 배열 -> ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String,Object>> selectGoodsList (String category, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		// Connection 
		Connection conn = DBHelper.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		if(category != null && !category.equals("")) {
			sql = "select "
					+ "goods_no goodsNo, "
					+ "category,"
					+ " goods_title goodsTitle,"
					+ "filename,"
					+ " goods_price goodsPrice "
					+ "from goods "
					+ "where category = ? "
					+ "order by goods_no desc "
					+ "limit ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
		} else {
			sql = "select "
					+ "goods_no goodsNo, "
					+ "category, "
					+ "goods_title goodsTitle,"
					+ "filename, "
					+ "goods_price goodsPrice "
					+ "from goods "
					+ "order by goods_no desc "
					+ "limit ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		}
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("category", rs.getString("category"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			list.add(m);
		}
		conn.close();
		return list;
	}
	
	//category 목록을 보여주는 개수 
	// /customer/goodsList
	//param : void
	//return : ArrayList
	public static ArrayList<HashMap<String,Object>> selectCategoryCount () throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("category", rs.getString("category"));
			m.put("cnt", rs.getInt("cnt"));
			list.add(m);
		}
		conn.close();
		return list;
	}
	
	// 상품 전체 목록 개수
	// /customer/goodsList.jsp
	// param : void
	// return : int totalRow
	
	public static int totalRow(String category) throws Exception{
		Connection conn = DBHelper.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalRow = 0;
		
		if(category != null && !category.equals("")) {
			sql = "select count(*) cnt from goods where category = ? group by category";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,category);
		}else {
			sql = "select count(*) cnt from goods";
			stmt = conn.prepareStatement(sql);
		}
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		
		conn.close();
		return totalRow;
	}
	
	// 상품 상세보기 -> 주문 
	// customer/goodsOne.jsp
	// param : int(goods_no)
	// return : Goods -> HashMap
	public static HashMap<String,Object> selectGoodsOne(int goodsNo) throws Exception{
		HashMap<String, Object> m = null;
		
		Connection conn = DBHelper.getConnection();
		String sql = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount from goods where goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {
			m = new HashMap<String, Object>();
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("category", rs.getString("category"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("goodsContent", rs.getString("goodsContent"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("goodsAmount", rs.getInt("goodsAmount"));
		}
		conn.close();
		return m;
	}
	
	// 상품 주문시 수정할 수량 
	// /customer/addOrdersAction.jsp or dropOrderAction.jsp or 반품 ?
	// param : int(상품번호), int(변경할 수량 + or -)
	public static int updateGoodsAmount(int goodsNo, int goodsAmount, int totalAmount) throws Exception {

		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "update goods set goods_amount = ? + -?, "
					+ "update_date = now() "
					+ "where goods_no = ?";
			
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,goodsAmount);
		stmt.setInt(2,totalAmount);
		stmt.setInt(3, goodsNo);
		row = stmt.executeUpdate();

		conn.close();
		return row;
	}
	// 주문취소시 수정할 수량
	//customer/dropOrdersAction.jsp
	public static int dropsGoodsAmount(int goodsNo, int goodsAmount, int totalAmount) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "update goods set goods_amount = ? + +?, "
				+ "update_date = now()"
				+ " where goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,goodsAmount);
		stmt.setInt(2,totalAmount);
		stmt.setInt(3, goodsNo);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
}	
