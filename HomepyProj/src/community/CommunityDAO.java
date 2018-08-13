package community;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import community.CommunityDTO;

public class CommunityDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public CommunityDAO() {		
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
	
	//자원반납하기
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
	
	//게시판테이블의 전체 레코드 갯수 얻기
	public int getTotalRecordCount(Map map)
	{
		int totalCount = 0;
		try{
			String sql = "SELECT COUNT(*) FROM community ";
										
			if(map.get("Word")!=null){
				sql +=" WHERE "+map.get("Column")+" "
					+ " LIKE '%"+map.get("Word")+"%' ";				
			}
			
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e){}
		return totalCount;
	}
		
	//게시물 리스트 출력하기(list)
	public List<CommunityDTO> selectList()
	{
		//1.결과 레코드셋을 담기위한 컬렉션 생성
		List<CommunityDTO> bbs = new Vector<CommunityDTO>();
		
		//2.게시물을 가져오기 위한 쿼리작성
		String sql = "SELECT * FROM community "
				+ " WHERE 1=1 "
				+ " ORDER BY idx DESC";
		try{
			//3.prepare 객체생성 및 실행
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next())
			{
				//4.결과셋을 DTO객체에 담는다.
				CommunityDTO dto = new CommunityDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));
				dto.setVisitcount(rs.getInt(9));
				
				//5.DTO객체를 컬렉션에 추가한다.
				bbs.add(dto);
			}		
		}
		catch(Exception e){
			e.printStackTrace();
		}	
		//6.DTO객체를 담은 List컬렉션을 반환
		return bbs;
	}
	
	//페이징처리를 위한 select 메소드
	public List<CommunityDTO> selectPaging(Map map)
	{
		List<CommunityDTO> bbs = new Vector<CommunityDTO>();
		
		String sql = ""
			+"SELECT * FROM ("
			+"    SELECT Tb.*, rownum rNum FROM ("
			+"        SELECT * FROM community ";
			
		if(map.get("Word")!=null){
			sql +=" WHERE "+map.get("Column")+" "
				+ " LIKE '%"+map.get("Word")+"%' ";				
		}
		
		sql += " ORDER BY bgroup DESC, bstep ASC"
		//sql += " ORDER BY idx DESC"
		+"    ) Tb"
		+")"
		+" WHERE rNum BETWEEN ? and ?";
			
		System.out.println("쿼리문:"+sql);
						
		try{
			//3.prepare 객체생성 및 실행
			psmt = con.prepareStatement(sql);
						
			psmt.setInt(1, 
				Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, 
				Integer.parseInt(map.get("end").toString()));			

			rs = psmt.executeQuery();
			while(rs.next())
			{
				//4.결과셋을 DTO객체에 담는다.
				CommunityDTO dto = new CommunityDTO();
				
				//답변글처리를 위한 로직추가
				 
				int indentNum = rs.getInt(12);
				String spacer = "";
				
				dto.setBgroup(rs.getInt(10));
				dto.setBstep(rs.getInt(11));
				dto.setBindent(indentNum);
				if(indentNum>0){
					for(int i=1 ; i<=indentNum ; i++){
						spacer += "&nbsp;&nbsp;";
					}
					spacer += spacer+"<img src='../images/re2.gif'>";
				}
				 
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				
				dto.setTitle(spacer + rs.getString(3));				
				
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));				
				dto.setVisitcount(rs.getInt(9));//조회수추가
				
							
				
				//5.DTO객체를 컬렉션에 추가한다.
				bbs.add(dto);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}	
		
		return bbs;
	}
	
	//게시물 작성하기(write)
	public int insert(CommunityDTO dto)
	{		
		int affected = 0;//적용된 행의갯수
		try{
			/*
			답변형게시판에서 원글의 경우 idx와 bgroup은
			항상 동일한 번호를 가진다.
			답변글인 경우 원글의 idx값을 bgroup으로 가지게
			된다. 
			*/
			String sql = "INSERT INTO community ("
				+ " idx,"
				+ " title,name,content,attachedfile,pass,downcount "
				+ " ,bgroup, bstep, bindent) "
				+ " VALUES ("
				+ " community_seq.NEXTVAL,?,?,?,?,?,0,"
				+ "	community_seq.NEXTVAL,0,0)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());
			psmt.setString(5, dto.getPass());
			
			affected = psmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}		
		return affected;
	}
	
	//게시물 읽기(view)
	public CommunityDTO selectView(String idx)
	{
		CommunityDTO dto = null;
		
		String sql = "SELECT * FROM community "
			+ " WHERE idx=?";
		try{
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			if(rs.next()){
				dto = new CommunityDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));
				dto.setVisitcount(rs.getInt(9));//조회수추가
				
				//답변글달기 추가
				dto.setBgroup(rs.getInt(10));
				dto.setBstep(rs.getInt(11));
				dto.setBindent(rs.getInt(12));
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return dto;
	}
	//게시물 조회수 증가시키기
	public void updateVisitCount(String idx)
	{
		String sql = "UPDATE community SET "
			+ " visitcount=visitcount+1 "
			+ " WHERE idx=? ";
		try{
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		}
		catch(Exception e){}
	}	
	
	//파일 다운로드 수 증가
	public void downCountPlus(String idx){
		String sql = "UPDATE community SET "
			+ " downcount=downcount+1 "
			+ " WHERE idx=? ";
		try{
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		}
		catch(Exception e){}
	}
	
	//패스워드 검증하기
	public boolean isCorrectPassword(String pass,
			String idx) {
		//패스워드 검증후 반환할 값 지정
		boolean isCorr = true;
		try {
			/*
			패스워드와 일련번호를 동시에 조건문에 삽입하여
			일치하는 레코드가 있는지 확인 
			*/
			String sql = "SELECT COUNT(*) FROM community "
					+ " WHERE pass=? AND idx=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);
			psmt.setString(2, idx);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1)==0) {
				/*
				만약 만족하는 레코드가 없다면 false반환
				 */
				isCorr = false;
			}
		}
		catch(Exception e) {
			//쿼리실행시 예외가 발생하더라도 false반환
			isCorr = false;
			e.printStackTrace();
		}
				
		return isCorr;
	}
	
	//수정하기
	public int update(CommunityDTO dto) {
		
		int affected = 0;
		try {
			String query = "UPDATE community SET"
					+ " title=?, name=?, content=? "
					+ " , attachedfile=? "
					+ " WHERE idx=? AND pass=?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());				
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());
			
			//게시물수정을 위한 추가부분
			psmt.setString(5, dto.getIdx());
			psmt.setString(6, dto.getPass());
			
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("update중 예외발생");
			e.printStackTrace();
		}
		
		return affected;		
	}
	
	//게시물 삭제하기
	public int delete(String idx) {
		int affected = 0;
		try {
			String query = "DELETE FROM community "
					+ " WHERE idx=?";
			
			psmt = con.prepareStatement(query);			
			psmt.setString(1, idx);
			 
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("delete중 예외발생");
			e.printStackTrace();
		}
		
		return affected;	
	}
	
	
	//게시물에 답변글쓰기
	public int reply(CommunityDTO dto)
	{		
		
		//답변글을 입력하기전에 bstep을 +1증가시킴
		replyStepUpdate(dto.getBgroup(),dto.getBstep());
		
		int affected = 0;//적용된 행의갯수
		try{
			/*
			답변형게시판에서 원글의 경우 idx와 bgroup은
			항상 동일한 번호를 가진다.
			답변글인 경우 원글의 idx값을 bgroup으로 가지게
			된다. 
			*/
			String sql = "INSERT INTO community ("
				+ " idx,"
				+ " title,name,content,attachedfile,pass,downcount "
				+ " ,bgroup, bstep, bindent) "
				+ " VALUES ("
				+ " community_seq.NEXTVAL,?,?,?,?,?,0,"
				+ "	?,?,?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());
			psmt.setString(5, dto.getPass());
			
			/*
			답변글 추가하기 : 답변글이므로 bgroup은
			원본과 동일하게 입력하고, bstep(정렬)과
			bindent(깊이)는 +1 증가시킨다.
			 */
			psmt.setInt(6, dto.getBgroup());
			psmt.setInt(7, dto.getBstep()+1);
			psmt.setInt(8, dto.getBindent()+1);
			
			affected = psmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}		
		return affected;
	}
	
	//답변글 입력전 해당 그룹내 레코드 일괄 업데이트
	public void replyStepUpdate(int groupNum,
			int stepNum) {
		try {
			String sql = "UPDATE community "
				+ " SET bstep=bstep+1 "
				+ " WHERE bgroup=?"
				+ " AND bstep>?";
			
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, groupNum);
			psmt.setInt(2, stepNum);
			psmt.executeUpdate();			
		}
		catch(Exception e) {
			e.printStackTrace();
			
		}
	}
}
