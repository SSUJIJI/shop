package customer.dao;

import java.util.*;
import java.sql.*;

public class CommentDAO {
	//commnet 추가하는 쿼리
	public static int insertComment(int ordersNo, int score, String content) throws Exception{
		int row = 0;
		String sql = "INSERT INTO comment(orders_no, score, content, update_date, create_date)"
				+ "VALUES(?, ?, ?, NOW(),NOW())";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		stmt.setInt(2, score);
		stmt.setString(3,content);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	//comment goodsOne.jsp에서 보여주는 쿼리
	public static ArrayList<HashMap<String,Object>> selectComment(int goodsNo) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		String sql = "SELECT c.score, c.content"
				+ " FROM COMMENT c inner join orders o "
				+ "ON c.orders_no = o.orders_no "
				+ "WHERE o.goods_no = ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("score", rs.getInt("score"));
			m.put("content", rs.getString("content"));
			list.add(m);
		}
		
		conn.close();
		return list;
		
	}
	//emp/commenCheckList에서 comment보여주는 쿼리
	public static ArrayList<HashMap<String,Object>> checkComment() throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT c.score, c.content, c.orders_no ordersNo"
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
			list.add(m);
		}
		
		return list;
	}

}
