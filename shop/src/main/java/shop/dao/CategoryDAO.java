package shop.dao;

import java.sql.*;
import java.util.*;

public class CategoryDAO {
	//categoryList에 추가하는 sql
	public static int addCategory(String cateogry) throws Exception{
		int row = 0;
		//DB 접근
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO category (category, create_date) VALUES(?,now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cateogry);
		
		row = stmt.executeUpdate();
		 
		conn.close();
		return row;
	}
	
	//categoryList를 보여주는 sql
	public static ArrayList<HashMap<String,Object>> selectCategoryList(
			String category) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		//DB접근
		Connection conn = DBHelper.getConnection();
		String sql = "select category, create_date createDate from category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("category", rs.getString("category"));
			list.add(m);
		}
		
		conn.close();
		return list;
		
	}
	
	//categoryOne을 보여주는 sql
	public static ArrayList<HashMap<String,Object>> selectCategoryOne(
			String category) throws Exception{
		ArrayList<HashMap<String, Object>> oneList = new ArrayList<HashMap<String,Object>>();
		
		//DB접근
		Connection conn = DBHelper.getConnection();
		String sql = "select category, create_date createDate from category where category = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);	
		stmt.setString(1,category);
		ResultSet rs= stmt.executeQuery();
		
		if(rs.next()){
			HashMap<String,Object> m = new HashMap<String, Object>();
			m.put("category", rs.getString("category"));
			m.put("createDate",rs.getString("createDate"));
			oneList.add(m);
		}
			conn.close();
			return oneList;
	}
	
	//category에서 지우는 sql
	public static int deleteCategory(String category) throws Exception {
		
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "DELETE FROM category WHERE category= ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		
		row = stmt.executeUpdate();
		 
		conn.close();
		return row;
	}
	
}
