package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {
	
	//GoodsList에 상품 추가하는 sql
	public static int insertGoods(
		String category,
		String goodsTitle,
		String filename,
		String goodsContent,
		int goodsPrice,
		int goodsAmount) throws Exception {
		
		int row = 0;
		String sql = "INSERT INTO goods(category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date, create_date) VALUES(?,'admin',?,?,?,?,?,NOW(),NOW())";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,category);
		stmt.setString(2,goodsTitle);
		stmt.setString(3,filename);
		stmt.setString(4,goodsContent);
		stmt.setInt(5,goodsPrice);
		stmt.setInt(6,goodsAmount);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;
		
		}
	
	//GoodsList에서 상품 삭제하는 sql
	public static int deleteGoods(int goodsNo) throws Exception{
		int row = 0;
		String sql = "DELETE FROM goods WHERE goods_no = ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	//상품 자세히보는 GoodsOne sql
	public static HashMap<String,Object> selectGoodsOne(int goodsNo) throws Exception{
		
		HashMap<String,Object> m = null;
		Connection conn = DBHelper.getConnection();
		String sql = "select goods_no goodsNo, category, emp_id empId, goods_title goodsTitle, filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, create_date createDate from goods where goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			m = new HashMap<String,Object>();
			m.put("goodsNo",rs.getInt("goodsNo"));
			m.put("category",rs.getString("category"));
			m.put("empId",rs.getString("empId"));
			m.put("goodsTitle",rs.getString("goodsTitle"));
			m.put("filename",rs.getString("filename"));
			m.put("goodsContent",rs.getString("goodsContent"));
			m.put("goodsPrice",rs.getInt("goodsPrice"));
			m.put("goodsAmount",rs.getInt("goodsAmount"));
			m.put("createDate",rs.getString("createDate"));
		}
		conn.close();
		return m;
	}
	//GoodsList 보여주는 sql
		public static ArrayList<HashMap<String,Object>> selectGoodsList(
				String category, int startRow, int rowPerPage)throws Exception{
			ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
			
			Connection conn = DBHelper.getConnection();
			String sql = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_price goodsPrice from goods where category like ? limit ?,?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1,"%"+category+"%");
			stmt.setInt(2,startRow);
			stmt.setInt(3, rowPerPage);
			
			ResultSet rs = stmt.executeQuery();
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
		
	//전체 상품 개수
	public static int totalRow() throws Exception{
		
		int totalRow = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "select count(*) cnt from goods";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()){
			totalRow = rs.getInt("cnt");
		}
		conn.close();
		return totalRow;
	}
	//category별 상품 개수
	public static int cateTotalRow(String category) throws Exception{
		
		int cateTotalRow = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "select category, COUNT(*) cnt FROM goods where category = ? GROUP BY category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()){
			cateTotalRow = rs.getInt("cnt");
		}
		conn.close();
		return cateTotalRow;
	}
	//category별 개수를 HashMap으로 나타냄 
	public static ArrayList<HashMap<String,Object>> selectCategoryList() throws Exception {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("category", rs.getString("category"));
			m.put("cnt", rs.getInt("cnt"));
			list.add(m);
		}
		conn.close();
		return list;
	}
	//goodsForm에서 categoryList 목록보는 sql
	public static ArrayList<String> selectCategory() throws Exception{
		ArrayList<String> category = new ArrayList<String>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select category from category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
			category.add(rs.getString("category"));
		}
		conn.close();
		return category;
	}
}
