package com.javaex.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.javaex.vo.GuestVo;

public class GuestDao {
	
	
	//0. import java.sql.*;
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs =null; //select문에 사용됨
	
	
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String id = "webdb";
	private String pw = "webdb";
	
	//생성자
	
	//디폴드 생성자 생략 (다른 생성자 없음)
	
	//메소드 g/s
	
	//메소드 일반
	
	//(공통되는부분 골라내기)
	
	//접속 메소드(DB접속)
	public void getConnection() {
		
		try {
			
			Class.forName(driver);
			
			//2. connection얻어오기
			conn = DriverManager.getConnection(url, id, pw);
			
			//System.out.println("[접속성공]");
			
		}catch(ClassNotFoundException e) {
			System.out.println("error:드라이버 로딩 실패 - " + e);
		}catch(SQLException e) {
			System.out.println("error:" + e );
		}	
		
	}
	
	//자원정리
	public void close() {	
		try {
			if(rs != null){
				 rs.close();
			}
				 
			if(pstmt != null) {
				pstmt.close();
					
			}
			if(conn != null) {
				conn.close();
			}
				
			}catch (SQLException e) {
				System.out.println("error:" + e);
			}
		}
	


	//1. 리스트가져오기
	public List<GuestVo> getGuestList(){

		//db접속
		getConnection();
		
		List<GuestVo> guestList = new ArrayList<GuestVo>();

		
		try {
			
			String query = "";
			
			//3.sql문 준비 / 바인딩 실행 (* 는 왠만하면 쓰지 않기)
			query += " select no, ";
			query += "        name, ";
			query += "        password, ";
			query += "        content, ";
			query += "        reg_date ";
			query += " from guestbook ";
			
			System.out.println(query);
			
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int no = rs.getInt("no");
				String name = rs.getString("name");
				String password = rs.getString("password");
				String content = rs.getString("content");
				String reg_date = rs.getString("reg_date");

				
				GuestVo vo = new GuestVo(no , name , password , content , reg_date);
				guestList.add(vo);
			}
				
		}catch(SQLException e) {
			System.out.println("error:" + e );
		}
	
		//자원정리
		close();
				
		return guestList;
		
	}
	
	//2. 등록 (select)
	public int guestInsert(GuestVo guestVo) {
		
		getConnection();
		
		int count = 0;
		
		try {
			//3. sql문 준비 /바인딩 /실행
			String query = "";
			query += " insert into guestbook ";
			query += " values (seq_guest_no.nextval, ?, ?, ?, sysdate)";
			//ORA-00911: invalid character 에러 (자바에서 sql로 쿼리를 날릴때 ; 가 들어있을 경우)
			
			//System.out.println(query); 확인용
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, guestVo.getName());
			pstmt.setString(2, guestVo.getPassword());
			pstmt.setString(3, guestVo.getContent());
			
			count = pstmt.executeUpdate();
			
			//4.결과처리
			
			System.out.println("[" + count + "건 등록되었습니다.]");
			 
		}catch(SQLException e) {
			System.out.println("error:" + e);
		}
		close();
		
		return count;
	}
	
	
	
	//삭제(delete)
	public int guestDelete(int no , String password) { 
		
		getConnection();
		
		int count = 0;
		
		try {
			//3.sql문 준비
			
			String query ="";
			query += " delete from guestbook ";
			query += " where no = ? ";
			query += " and password = ? ";
			//no와 password값 모두 맞아야 삭제
			
			//System.out.println(query);
			
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, no);
			pstmt.setString(2, password);
			
			count = pstmt.executeUpdate();
			
			//4.결과처리
			
			System.out.println("[" + count + "건 삭제되었습니다.]");
			
		}catch(SQLException e) {
			System.out.println("error:" + e );
		}	
		
		//자원정리
		close();		
		System.out.println("[" + count + "건 삭제되었습니다.]");
		return count;
	}
	
	
	
	//사람 1명 정보 가져오기
	
	public GuestVo getGuest(int guestNo) {
		
		GuestVo guestVo = null;
		
		//db접속
		getConnection();
		
		try {
			
			String query = "";
			
			//3.sql문 준비 / 바인딩 실행 (* 는 왠만하면 쓰지 않기)
			query += " select no, ";
			query += "        name, ";
			query += "        password, ";
			query += "        content, ";
			query += "        reg_date ";
			query += " from guestbook ";
			query += " where no = ? ";
			
			//System.out.println(query);
			
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1,guestNo);
			
			rs = pstmt.executeQuery(); //날리다
			
			//결과처리
			
			while (rs.next()) {
				int no = rs.getInt("no");
				String name = rs.getString("name");
				String password = rs.getString("password");
				String content = rs.getString("content");
				String reg_date = rs.getString("reg_date");

				
				GuestVo vo = new GuestVo(no , name , password , content , reg_date);
			}
				
		}catch(SQLException e) {
			System.out.println("error:" + e );
		}
	
		//자원정리
		close();
				
		return guestVo;
		
	}
	
	
	
	

}
