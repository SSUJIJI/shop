package customer.dao;

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
	}
