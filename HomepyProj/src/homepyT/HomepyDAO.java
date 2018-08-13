package homepyT;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import clean.OrderDTO;

public class HomepyDAO {
	
	Connection con; //오라클 서버와 연결할때 사용
	PreparedStatement psmt;//오라클 서버와 쿼리전송 역활
	ResultSet rs;//쿼리의 결과를 받을때 사용
	
	public HomepyDAO() {		
		
		String driver = "oracle.jdbc.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		try {
			Class.forName(driver);
			String id = "kosmo";
			String pw = "1234";
			con = 
				DriverManager.getConnection(url, id, pw);
			System.out.println("DB Success^^*");
		}
		catch(Exception e) {
			System.out.println("DB Fail;");
		}
		
		/*try {
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
		}*/		
		
				
		
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
		
		Map<String, String> maps = new HashMap<String, String>();
		
		String query = "SELECT id, pass, name, email FROM "
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
				maps.put("email", rs.getString("email"));
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
	
	//회원정보 가져오기
	public HomepyMemberDTO getMemberInfo(String id)
	{		
		HomepyMemberDTO dto = new HomepyMemberDTO();
		
		String query = " "
			+"SELECT * FROM homepy_member_t "
			+" WHERE id=?";		
		
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
			System.out.println("회원정보가져오기 중 "
					+ " 예외발생");
			e.printStackTrace();
		}	
		
		return dto;
	}
	
	//회원정보 수정하기
	public int memberModify(HomepyMemberDTO dto) 
	{		
		int affected = 0;
		
		try {
			String query = "UPDATE homepy_member_t SET"
					+ " pass=?,name=?,tel=?,mobile=?,email=?,"
					+ " zipcode=?,addr1=?,addr2=? "
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
			System.out.println("회원정보수정 중 예외발생");
			e.printStackTrace();
		}
				
		return affected;
	}
	
	//게시물 갯수를 카운트하기 위한 메소드
	public int getTotalRecordCount(
			Map<String,Object> map) {		
		int totalCount = 0;
		
		String query = "SELECT COUNT(*) FROM homepy_board_t"
				+ " WHERE 1=1 ";
		//검색어가 있는 경우 where 없을경우는 and 바꿔줘야하는지
		//고민해야하는데 where1=1로 하면서 밑에 그냥 다 and로 다 처리
		
		if(map.get("Word")!=null) 
		{
			if(map.get("Column").equals("both")) 
			{
				query +=" AND "
				  +" title LIKE '%"+ map.get("Word") +"%' "
				  +" OR "
				  +" content LIKE '%"+ map.get("Word") +"%' ";
			}
			else {
				query +=" AND "+ map.get("Column") +" "
				  +" LIKE '%"+ map.get("Word") +"%' ";
			}
			
			
			
		}
		
		
		//멀티게시판 추가
		query += " AND b_flag=? ";
		
		try {
			psmt = con.prepareStatement(query);
			
		
			psmt.setString(1, map.get("b_flag").toString());
			
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e) {}
				
		return totalCount;
	}
	
	//게시판 리스트 가져오기(검색처리, 페이지처리)
	public List<HomepyBoardDTO> selectList(Map<String,Object> map){
		
		//1.결과 레코드셋을 담기위한 리스트계열 컬렉션생성 
		List<HomepyBoardDTO> bbs = new Vector<HomepyBoardDTO>();
		
		//2.게시물 전체를 가져오기 위한 쿼리작성
		String query = " "		
			+" SELECT * FROM ( " 
			+"	 SELECT Tb.*, ROWNUM rNum FROM ( "
			+"	    SELECT B.*, M.name FROM homepy_board_t B "
			+"		  INNER JOIN homepy_member_t M"
			+"			ON M.id=B.id WHERE b_flag=?";

		if(map.get("Word")!=null) 
		{
			if(map.get("Column").equals("both")) 
			{
				query +=" AND "
				  + "title LIKE '%"+ map.get("Word") +"%' "
				  +" OR "
				  +" content LIKE '%"+ map.get("Word") +"%' ";
			}
			else {
				query +=" AND "+ map.get("Column") +" "
				  +" LIKE '%"+ map.get("Word") +"%' ";
			}			
		}				
		query += " "
		    +"    	ORDER BY num DESC "
		    +"    ) Tb "
		    +" ) "
		    +" WHERE rNum BETWEEN ? AND ?";			
		
		System.out.println("쿼리문:"+ query);			
			
		try {
			//3.prepare객체생성 및 실행
			psmt = con.prepareStatement(query);
			
			//멀티게시판 추가
			psmt.setString(1, map.get("b_flag").toString());
			
			psmt.setString(2, map.get("start").toString());
			psmt.setString(3, map.get("end").toString());			
			
			//4.쿼리실행후 결과셋 돌려받음
			rs = psmt.executeQuery();
			
			//5.결과셋의 갯수만큼 반복
			while(rs.next()) {
				
				//6.결과셋을 하나씩 DTO객체에 저장
				HomepyBoardDTO dto = new HomepyBoardDTO();
				
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString(3));
				dto.setPostDate(rs.getDate(4));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				
				//7번은 첨부파일
				dto.setChumfile(rs.getString(7));
				
				//b_flag가 추가되므로 name은 한칸뒤로 밀리게 된다.
				//join에 의한 name 필드추가
				dto.setName(rs.getString(9));
				
				//7.DTO객체를 컬렉션에 추가
				bbs.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	
	//게시판 글쓰기 처리
	   public int insertWrite(HomepyBoardDTO dto) {
	      //적용된 행의 갯수확인을 위한 변수
	      int affected = 0;
	      try {
	         String query = "INSERT INTO homepy_board_t ( "
	            + " num,title,content,id,visitcount,b_flag) "
	            + " VALUES ( "
	            + " seq_bbs_num.NEXTVAL, ?, ?, ?, 0, ?)";

	         psmt = con.prepareStatement(query);
	         psmt.setString(1, dto.getTitle());
	         psmt.setString(2, dto.getContent());
	         psmt.setString(3, dto.getId());
	         psmt.setString(4, dto.getB_flag());
	         
	         affected = psmt.executeUpdate();
	      }
	      catch(Exception e) {
	         System.out.println("insert중 예외발생");
	         e.printStackTrace();
	      }
	      
	      return affected;
	   }
	
	//게시판 상세보기
	public HomepyBoardDTO selectView(String num) {
		
		HomepyBoardDTO dto = new HomepyBoardDTO();
		
		String query = " "
			+"SELECT B.*, M.name, M.email FROM "
			+" homepy_board_t B INNER JOIN "
			+" homepy_member_t M "
			+" ON B.id = M.id "
			+" WHERE num=?";		
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
								
				/* DB에서 추출한후 DTO객체에 담기전 미리 줄바꿈 처리를				
				진행한다. */
				dto.setContent(rs.getString("content").replace("\r\n", "<br/>"));
				dto.setPostDate(rs.getDate(4));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				
				//첨부파일
				dto.setChumfile(rs.getString(7));
				
				//member테이블과 join된 결과추가
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
			}
		}
		catch(Exception e) {
			System.out.println("상세보기시 예외발생");
			e.printStackTrace();
		}				
				
		return dto;
	}
	
	//조회수 증가시키기
	public void updateVisitCount(String num) {
		
		String query = "UPDATE homepy_board_t SET "
			+ " visitcount=visitcount+1 "
			+ " WHERE num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			psmt.executeQuery();
		}
		catch(Exception e) {
			System.out.println("조회수 증가시 예외발생");
			e.printStackTrace();
		}
		
	}
	
	public int checkId(String usrid) throws Exception{
		   
		   int re = 0;
		   HomepyBoardDTO dto = new HomepyBoardDTO();
		   try{
		         
			    String selectSQL="select * from user_t where usrid=?";
			    psmt = con.prepareStatement(selectSQL);
			    psmt.setString(1,usrid);
			    ResultSet rs = psmt.executeQuery();
			    if(rs.next()){
			     re = 1;
			    }
		   }
		   catch (Exception e) {
			   e.printStackTrace();
		   }
		   return re;
		 
		   }
	
	public List<HomepyBoardDTO> recentList(Map<String, Object> map) {

		// 1.결과 레코드셋을 담기위한 리스트계열 컬렉션생성
		List<HomepyBoardDTO> bbs = new Vector<HomepyBoardDTO>();

		// 2.게시물 전체를 가져오기 위한 쿼리작성
		String query = " SELECT title,postdate FROM homepy_board_t order by postdate desc";

		System.out.println("쿼리문:" + query);

		try {
			// 3.prepare객체생성 및 실행
			psmt = con.prepareStatement(query);

			// 4.쿼리실행후 결과셋 돌려받음
			rs = psmt.executeQuery();

			// 5.결과셋의 갯수만큼 반복
			while (rs.next()) {

				// 6.결과셋을 하나씩 DTO객체에 저장
				HomepyBoardDTO dto = new HomepyBoardDTO();

				dto.setTitle(rs.getString(1));
				dto.setPostDate(rs.getDate(2));

				// 7.DTO객체를 컬렉션에 추가
				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}

		return bbs;
	}
	
	public String id_search2(String name, String email) { // 이름,이메일로 찾기

		String user_id = null; // 찾을아이디

		String sql = "SELECT id FROM homepy_member_t WHERE name=? AND email=?";

		try {
			psmt = con.prepareStatement(sql); 
			psmt.setString(1, name); 
			psmt.setString(2, email); 

			rs = psmt.executeQuery(); 

			while (rs.next()) { 
				user_id = rs.getString("id"); 
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
		return user_id;
	}

	public String id_search3(String id, String name, String email) { // 이름,이메일로 찾기

		String pass = null; // 찾을아이디

		String sql = "SELECT pass FROM homepy_member_t WHERE id=? AND name=? AND email=?";

		try {
			psmt = con.prepareStatement(sql); // 쿼리
			psmt.setString(1, id);
			psmt.setString(2, name); 
			psmt.setString(3, email);

			rs = psmt.executeQuery(); // 쿼리 실행의 결과값을 rs로 저장

			while (rs.next()) { // rs까지 반복
				pass = rs.getString("pass"); 
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
		return pass;
	}
	
	public int sendform(blueDTO dto) {
		
		int affected = 0;
		try {
			String query = "INSERT INTO homepy_blue ( "
					+ " name,addr,phone,phone2,email,type,residate,rsize,book,"
					+ " ask,content) "
					+ " VALUES ( "
					+ " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getAddr());
			psmt.setString(3, dto.getPhone());
			psmt.setString(4, dto.getPhone2());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getType());
			psmt.setString(7, dto.getRsize());
			psmt.setDate(8, dto.getResidate());
			psmt.setString(9, dto.getEmail());
			psmt.setString(9, dto.getBook());
			psmt.setString(9, dto.getAsk());
			psmt.setString(9, dto.getContent());
			
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("insert중 예외발생");
			e.printStackTrace();
		}
		
		return affected;
	}
	
	//블루클리닝 (이메일 보내기)
	public int af (OrderDTO dto ) {    
	      //적용된 행의 갯수확인을 위한 변수
	            int affected = 0;
	            try {
	               String query = " insert into cleanorder(name, addr, contactnum, cellnum, email, cleantype, cleansize, cleandate, book, etc ) "
	                     + " values (?,?,?,?,?,?,?,?,?,?) ";

	                psmt = con.prepareStatement(query);
	               
	                 psmt.setString(1, dto.getName());
	                  psmt.setString(2, dto.getAddr());
	                  psmt.setString(3, dto.getContactnum());
	                  psmt.setString(4, dto.getCellnum());
	                  psmt.setString(5, dto.getEmail());
	                  psmt.setString(6, dto.getCleantype());
	                  psmt.setString(7, dto.getCleansize());
	                  psmt.setString(8, dto.getCleandate());
	                  psmt.setString(9, dto.getBook());
	                  psmt.setString(10, dto.getEtc());
	               
	               affected = psmt.executeUpdate();
	            }
	            catch(Exception e) {
	               System.out.println("insert중 예외발생");
	               e.printStackTrace();
	            }
	            
	            return affected;
	   }
}
