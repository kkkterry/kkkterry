package com.lec.ex2Customer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class CustomerDao {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	
	public static final int SUCCESS = 1;
	public static final int FAIL = 0;
	
	private static CustomerDao INSTANCE;
	private CustomerDao() {
		try {
			Class.forName(driver);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public static CustomerDao getInstance() {
		if(INSTANCE == null) {
			INSTANCE = new CustomerDao();
		}
		return INSTANCE;
	}
	//1.입력
	public int insertCustomer(CustomerDto dto) {
		int result = FAIL;
		//로직수행
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO CUSTOMER VALUES (CUSTOMER_ID_SQ.NEXTVAL, ?, ?, ?)";
		try {
			conn=DriverManager.getConnection(url,"scott","tiger");
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPhone());
			pstmt.setString(2, dto.getName());
			pstmt.setInt(3, dto.getPoint());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return result;
	}
	//2. 번호 출력
	public ArrayList<CustomerDto> selectPhone(String phone){
		ArrayList<CustomerDto> dtos = new ArrayList<CustomerDto> ();
		//로직수행
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM CUSTOMER WHERE PHONE LIKE '%'||?";
		try {
			conn = DriverManager.getConnection(url,"scott","tiger");
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, phone);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String phone1 = rs.getString("phone");
				String name = rs.getString("name");
				int point = rs.getInt("point");
				dtos.add(new CustomerDto(id,phone1,name,point));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}	
		return dtos;
		
	}
	//3.출력
	public ArrayList<CustomerDto> selectAll(){
		ArrayList<CustomerDto> dtos = new ArrayList<CustomerDto>();
		//로직수행
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM CUSTOMER";
		try {
			conn = DriverManager.getConnection(url,"scott", "tiger");
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				do {
					String name = rs.getString("name");
					String phone = rs.getString("phone");
					int point = rs.getInt("point");
					int id = rs.getInt("id");
					dtos.add(new CustomerDto(id,phone,name,point));
				}while(rs.next());
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return dtos;
		
	}
	
	
	
	
}
