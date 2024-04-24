package customer.dao;

import java.util.*;
import java.sql.*;

public class CommentDAO {
	//commnet 추가하는 쿼리
	public static int insertComment(int ordersNo, String mail, int score, String content, int goodsNo) throws Exception{
		int row = 0;
		String sql = "INSERT INTO comment(orders_no, goods_no, score, mail, content, update_date, create_date)"
				+ "VALUES(?, ?, ?, ?, ?, NOW(),NOW())";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, score);
		stmt.setString(4,mail);
		stmt.setString(5,content);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	//comment goodsOne.jsp에서 보여주는 쿼리
	public static ArrayList<HashMap<String,Object>> selectComment(int goodsNo, String mail) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		String sql = "SELECT c.score, c.content, o.orders_no ordersNo, c.mail"
				+ " FROM COMMENT c inner join orders o "
				+ "ON c.orders_no = o.orders_no "
				+ "WHERE o.goods_no = ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("score", rs.getInt("score"));
			m.put("content", rs.getString("content"));
			m.put("mail", rs.getString("mail"));
			list.add(m);
		}
		
		conn.close();
		return list;
		
	}
	//emp/deleteCommentAction.jsp 
	public static int deleteRow(int ordersNo) throws Exception{
		int row = 0;
		String sql = "DELETE FROM comment WHERE orders_no = ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
		
	
	}
	//emp/commenCheckList에서 comment보여주는 쿼리
	public static ArrayList<HashMap<String,Object>> checkComment() throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT c.score, c.content, c.orders_no ordersNo, c.mail"
				+ " FROM COMMENT c inner join orders o "
				+ "ON c.orders_no = o.orders_no ";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("score", rs.getInt("score"));
			m.put("content", rs.getString("content"));
			m.put("mail", rs.getString("mail"));
			list.add(m);
		}
		
		return list;
	}
	//customer/deleteCommentAction.jsp
	public static int deleteCustomerRow(int ordersNo, String mail)throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "DELETE m"
				+ " FROM comment m"
				+ " JOIN customer c ON m.mail = c.mail"
				+ " WHERE c.mail = ? AND m.orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,mail);
		stmt.setInt(2,ordersNo);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	//comment 페이지 totalRow
	public static int totalRow(int goodsNo) throws Exception {
		
		int totalRow = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "select count(*) cnt from comment where goods_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()){
			totalRow = rs.getInt("cnt");
		}

		conn.close();
		return totalRow;
	}
}
