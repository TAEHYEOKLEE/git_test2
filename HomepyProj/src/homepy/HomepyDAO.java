package homepy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import community.CommunityDTO;
import homepyT.HomepyBoardDTO;

public class HomepyDAO {
	
	Connection con; //오라클 서버와 연결할때 사용
	PreparedStatement psmt;//오라클 서버와 쿼리전송 역활
	ResultSet rs;//쿼리의 결과를 받을때 사용
	
	public HomepyDAO() {		
		try {
			Context ctx = new InitialContext();
			DataSource source = 
			  (DataSource)
			  ctx.lookup("java:comp/env/jdbc/myoracle");
			
			con = source.getConnection();
			System.out.println("DBCP연결성공");
		}
		catch(Exception e) {
			System.out.println("DBCP연결실패");
			e.printStackTrace();
		}		
	}
	public void close() {
		try {
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		}
		catch(Exception e) {
			System.out.println("자원반납시 예외발생");
			e.printStackTrace();
		}
	}
	public int memberRegist(HomepyMemberDTO dto) {
		//적용된 행의 갯수확인을 위한 변수
		int affected = 0;
		try {
			String query = "INSERT INTO homepy_member_t ( "
				+ " id,pass,name,tel,mobile,email,zipcode,"
				+ " addr1,addr2) "
				+ " VALUES ( "
				+ " ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getTel());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getZipcode());
			psmt.setString(8, dto.getAddr1());
			psmt.setString(9, dto.getAddr2());
			
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("insert중 예외발생");
			e.printStackTrace();
		}
		
		return affected;
	}
	
		
	public Map<String, String> memberLogin(String id,
			String pwd){
		
		Map<String, String> maps = 
				new HashMap<String, String>();
		
		String query = "SELECT id, pass, name FROM "
				+ " homepy_member_t WHERE id=? AND pass=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			rs = psmt.executeQuery();
			
			//결과셋이 있는 경우에만 레코드를 읽어온다.
			if(rs.next()) {		
				//Map에 추가할때는 put()메소드 사용함.
				maps.put("id", rs.getString(1));
				maps.put("pass", rs.getString(2));
				maps.put("name", rs.getString("name"));
			}
			else {
				System.out.println("결과셋이 없습니다.");
			}
		}
		catch(Exception e) {
			System.out.println("getMemberDTO오류");
			e.printStackTrace();
		}
		
		return maps;
	}
	
	public HomepyMemberDTO getMemberInfo(String id) {
		
		HomepyMemberDTO dto = new HomepyMemberDTO();
		
		String query = " "
			+"SELECT * FROM homepy_member_t "
			+" WHERE id=?";		
		System.out.println(id+" "+query);
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if(rs.next()) {				
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));				
				dto.setName(rs.getString(3));				
				dto.setTel(rs.getString(4));
				dto.setMobile(rs.getString(5));
				dto.setEmail(rs.getString(6));
				dto.setZipcode(rs.getString(7));
				dto.setAddr1(rs.getString(8));
				dto.setAddr2(rs.getString(9));				
			}			
		}
		catch(Exception e) {
			System.out.println("getMemberInfo() 예외발생");
			e.printStackTrace();
		}				
				
		return dto;
	}


	//게시물 수정하기
	public int memberModify(HomepyMemberDTO dto) {
		
		int affected = 0;
		try {
			String query = "UPDATE homepy_member_t SET"
					+ " pass=?,name=?,tel=?,mobile=?,email=?,zipcode=?,addr1=?,addr2=?"
					+ " WHERE id=?";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getPass());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getTel());
			psmt.setString(4, dto.getMobile());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getZipcode());
			psmt.setString(7, dto.getAddr1());
			psmt.setString(8, dto.getAddr2());
			
			psmt.setString(9, dto.getId());
						
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("update중 예외발생");
			e.printStackTrace();
		}
		
		return affected;		
	}

	
	
	//메인 리스트 출력하기(list)
	public List<HomepyBoardDTO> selectList()
	{
		//1.결과 레코드셋을 담기위한 컬렉션 생성
		List<HomepyBoardDTO> bbs = new Vector<HomepyBoardDTO>();
		
		//2.게시물을 가져오기 위한 쿼리작성
		int count = 0;
		String sql = "SELECT num, title, postdate FROM homepy_board_t "
				+ " WHERE 1=1 "
				+ " ORDER BY num DESC";
		try{
			//3.prepare 객체생성 및 실행
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next())
			{
				//4.결과셋을 DTO객체에 담는다.
				HomepyBoardDTO dto = new HomepyBoardDTO();
				
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setPostDate(rs.getDate(3));
				
				//5.DTO객체를 컬렉션에 추가한다.
				bbs.add(dto);
				count++;
				if(count>3) 
				
				return bbs;
			}		
		}
		catch(Exception e){
			e.printStackTrace();
		}	
		//6.DTO객체를 담은 List컬렉션을 반환
		return bbs;
	}
	
	
	
	
	

}
