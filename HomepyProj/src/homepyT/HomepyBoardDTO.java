package homepyT;

import java.sql.Date;

/**
 * @author LEETAEHYUK
 *
 */
public class HomepyBoardDTO {
	//게시판정보
	private String num;//일련번호(식별자)
	private String title;//제목
	private String content;//내용	
	private java.sql.Date postDate;//작성일
	private String id;//작성자아이디
	private String visitcount;//조회수
	private String chumfile;//첨부파일
	//회원정보
	private String name;//회원이름
	private String email;//회원의 이메일주소	
	//멀티게시판추가
	private String b_flag;//게시판 플레그
	
	//기본생성자
	public HomepyBoardDTO() {}
	//인자생성자
	public HomepyBoardDTO(String num, String title, String content, Date postDate, String id, String visitcount,
			String chumfile, String name, String email) {
		
		this.num = num;
		this.title = title;
		this.content = content;
		this.postDate = postDate;
		this.id = id;
		this.visitcount = visitcount;
		this.chumfile = chumfile;
		this.name = name;
		this.email = email;
	}
	
	public HomepyBoardDTO(String num, String title, String content, Date postDate, String id, String visitcount,
			String chumfile, String name, String email, String b_flag) {
		super();
		this.num = num;
		this.title = title;
		this.content = content;
		this.postDate = postDate;
		this.id = id;
		this.visitcount = visitcount;
		this.chumfile = chumfile;
		this.name = name;
		this.email = email;
		this.b_flag = b_flag;
	}
	//getter/setter
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public java.sql.Date getPostDate() {
		return postDate;
	}
	public void setPostDate(java.sql.Date postDate) {
		this.postDate = postDate;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}
	public String getChumfile() {
		return chumfile;
	}
	public void setChumfile(String chumfile) {
		this.chumfile = chumfile;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	//멀티게시판 추가부분
	public String getB_flag() {
		return b_flag;
	}
	public void setB_flag(String b_flag) {
		this.b_flag = b_flag;
	}
	
}
