package shop.dao;
import java.util.HashMap;
import java.sql.*;
import java.util.*;


// emp 테이블을 CRUD하는 STATIC 메서드의 컨테이너 
public class EmpDAO {
	public static int insertEmp(String empId, String empPw, String empName, String empJob) throws Exception {
		int row = 0;
		// DB 접근
		Connection conn = DBHelper.getConnection();
		String sql = "insert ...?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJob);
		
		row = stmt.executeUpdate();
		 
		conn.close();
		return row;
		
	}
	//HashMap<String,Object>: null이면 로그인실패, 아니면 성공
	//String empId,String empPw : 로그인폼에서 사용자가 입력한 id/pw
	
	//호출코드 HashMap<Striing, Object> m = EmpDAO.empLogin("admin","1234")
	
	//EMP 로그인을 구분하는 sql
	public static HashMap<String,Object> empLogin(String empId,String empPw) throws Exception {
		HashMap<String, Object> resultMap = null;
		System.out.println(empId + "<---empId");
		System.out.println(empPw + "<---empPw");
		
		// DB 접근
		Connection conn = DBHelper.getConnection();
		String sql = "select t.empId empId, t.empName empName, t.grade grade"
				+ " from"
				+ " (select e.emp_id empId, e.emp_name empName, e.grade, eh.empPw"
				+ " from emp e inner join emp_history eh"
				+ " on e.emp_id = eh.empId"
				+ " where e.emp_id = ?"
				+ " order by eh.createdate desc"
				+ " LIMIT 0,1) t"
				+ " where t.empPw = password(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,empId);
		stmt.setString(2,empPw);
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMap = new HashMap<String,Object>();
			resultMap.put("empId", rs.getString("empId"));
			System.out.println(rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
		}
		conn.close();
		return resultMap;
		
		
	}
	
	//EmpOne을 보여주는 sql
	public static HashMap<String,Object> selectEmpOne(
			String empName) throws Exception{
		HashMap<String,Object> m = null;
		
		Connection conn = DBHelper.getConnection();
		String sql = "select emp_id empId, grade, emp_pw empPw, emp_name empName, emp_job empJob, hire_date hireDate, active from emp where emp_name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,empName);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			m = new HashMap<String,Object>();
			m.put("empId", rs.getString("empId"));
			m.put("empPw", rs.getString("empPw"));
			m.put("grade", rs.getInt("grade"));
			m.put("empName", rs.getString("empName"));
			m.put("empJob", rs.getString("empJob"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("active", rs.getString("active"));
			
		}
		conn.close();
		return m;
	}
	//emp 탈퇴 sql
	// customer/deleteEmpAction.jsp
	// param : int(String empId, String empPw)
	// return : int row
	public static int deleteEmp(String empId, String empPw) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "DELETE FROM emp WHERE emp_id = ? AND emp_pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,empId);
		stmt.setString(2, empPw);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	//empList를 보여주는 sql
	public static ArrayList<HashMap<String,Object>> selectEmpList(
			int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String,Object>> empList = new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,startRow);
		stmt.setInt(2,rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String,Object> m = new HashMap<String, Object>();
			m.put("empId", rs.getString("empId"));
			m.put("empName", rs.getString("empName"));
			m.put("empJob", rs.getString("empJob"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("active", rs.getString("active"));
			empList.add(m);
		}
		conn.close();
		return empList;
	}
	//empList의 총 갯수
	public static int totalRow() throws Exception{
		
		int totalRow = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "select count(*) cnt from emp";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()){
			totalRow = rs.getInt("cnt");
		}
			
		conn.close();
		return totalRow;
		
		}
	
	//empList에서 action을 바꾸는 sql
	public static int modifyEmp(String active, String empId) throws Exception {
		
		int row = 0 ;
		Connection conn = DBHelper.getConnection();
		String sql = "update emp set active = ? where emp_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		if(active.equals("ON")){
			stmt.setString(1,"OFF");
		}else if(active.equals("OFF")){
			stmt.setString(1,"ON");
		}
		stmt.setString(2,empId);
		
		row = stmt.executeUpdate(); 
		
		conn.close();
		return row;
	}
}
