package customer.dao;

import java.sql.*;
import java.util.*;

import shop.dao.DBHelper;



public class CustomerDAO {
	
	//디버깅용 메인 메서드
		public static void main (String[] args) throws Exception {
			// 메일 체크 메서드 디버깅
			//System.out.println(CustomerDAO.checkMail("a@goodee.com"));
			// 회원가입 메서드 디버깅
			//System.out.println(CustomerDAO.insertCustomer("z@goodee.com","1234","zzz","1999/09/09","여"));
			// 로그인 메서드 디버깅
			//System.out.println(CustomerDAO.login("a@goodee.com","1234"));
			// 탈퇴 메서드 디버깅
			//System.out.println(CustomerDAO.deleteCustomer("a@goodee.com","1234"));
		}
			
		// 회원가입 액션
		// 호출 - addCustomerAction.jsp
		// param : customer .. 
		// return : int(입력실패 0, 아니면 성공)
		public static int insertCustomer(String mail, String pw, String name, 
				String birth, String gender) throws Exception {
			int row = 0;
			
			Connection conn = DBHelper.getConnection();
			String sql = "insert into customer (mail, pw, name, birth, gender, update_date, create_date) "
					+ "values (?,password(?),?,?,?,now(), now())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, mail);
			stmt.setString(2, pw);
			stmt.setString(3, name);
			stmt.setString(4, birth);
			stmt.setString(5, gender);
			row = stmt.executeUpdate();
			
			
			conn.close();
			
			return row;
		}	
		// 회원가입시 mail 중복확인 
		// 호출 - checkIdAction.jsp
		// param : String(메일문자열)
		// return : boolean(사용가능하면 true, 불가면 false)
		public static boolean checkMail(String mail) throws Exception {
			boolean result  = false;
			Connection conn = DBHelper.getConnection();
			String sql = "select mail from customer where mail = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, mail);
			ResultSet rs = stmt.executeQuery();
			if(!rs.next()) { // 사용불가
				result = true;
			}
			
			conn.close();
			
			return result;
			
		}
		
		// customerOne list 보여주기
		// 호출 : customerOne.jsp
		//param : String(mail, name, birth, gender, updateDate, createDate  )
		//return : ArrayList<HashMap<String, Object>>
		public static ArrayList<HashMap<String, Object>> selectCustOne (
				String name) throws Exception {
			ArrayList<HashMap<String,Object>> custOne = new ArrayList<HashMap<String,Object>>();
		
			Connection conn = DBHelper.getConnection();
			String sql = "SELECT mail, pw, NAME, birth, gender, update_date updateDate, create_date createDate FROM customer WHERE NAME = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1,name);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				HashMap<String,Object> m = new HashMap<String,Object>();
				m.put("mail", rs.getString("mail"));
				m.put("pw", rs.getString("pw"));
				m.put("name", rs.getString("name"));
				m.put("birth", rs.getString("birth"));
				m.put("gender", rs.getString("gender"));
				m.put("updateDate", rs.getString("updateDate"));
				m.put("createDate", rs.getString("createDate"));
				custOne.add(m);
			}
			conn.close();
			return custOne;
		}
		
		// 비밀번호 수정
		// 호출 : editPwAction.jsp
		// param : String(mail), String(수정 전 pw), String(수정할 pw)
		// return : int (1성공, 0실패)
		public static int updatePw(String mail, String oldPw, String newPw) throws Exception{
			int row = 0;
			
			Connection conn = DBHelper.getConnection();
			String sql = "update customer set pw = password(?) where mail = ? and pw = password(?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, newPw);
			stmt.setString(2, mail);
			stmt.setString(3, oldPw);
			row = stmt.executeUpdate();
			
			
			conn.close();
			
			return row;
			
		}
		
		//회원탈퇴 메서드
		//호출 : dropCustomerAction.jsp
		//param : String(세션안에 mail),String(pw)
		//return : int(1이면 탈퇴, 0이면 탈퇴 실패)
		
		public static int deleteCustomer(String mail, String pw) throws Exception{
			int row = 0;
			
			Connection conn = DBHelper.getConnection();
			String sql = "delete from customer where mail = ? and pw = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, mail);
			stmt.setString(2, pw);
			row = stmt.executeUpdate();
			
			
			conn.close();
			
			
			
			return row;
			
		}
		
		
		//로그인 메서드
		//호출 : loginAction.jsp
		//param:String(mail), String (pw)
		//return : HashMap(mail, 이름)
		public static HashMap<String, String> login(String mail, String pw) throws Exception{
			HashMap<String,String> map = null;
			
			Connection conn = DBHelper.getConnection();
			String sql = "select mail, name from customer where mail = ? and pw =password(?)";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, mail);
			stmt.setString(2, pw);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String, String>();
				map.put("mail", rs.getString("mail"));
				map.put("name",  rs.getString("name"));
				
			}
			
			conn.close();
			return map;
			
		}
}
