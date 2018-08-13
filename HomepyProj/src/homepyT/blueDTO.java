package homepyT;

import java.sql.Date;

public class blueDTO {

	private String name;//일련번호(식별자)
	private String addr;//제목
	private String phone;
	private String phone2;
	private String email;
	private String type;
	private java.sql.Date residate;//작성일
	private String rsize;	
	private String book;//작성자아이디
	private String ask;//조회수
	private String content;

	
	
	public blueDTO() {}


	public blueDTO(String name, String addr, String phone, String phone2, String email, String type, Date residate,
			String rsize, String book, String ask, String content) {
		super();
		this.name = name;
		this.addr = addr;
		this.phone = phone;
		this.phone2 = phone2;
		this.email = email;
		this.type = type;
		this.residate = residate;
		this.rsize = rsize;
		this.book = book;
		this.ask = ask;
		this.content = content;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public java.sql.Date getResidate() {
		return residate;
	}
	public void setResidate(java.sql.Date residate) {
		this.residate = residate;
	}
	public String getRsize() {
		return rsize;
	}
	public void setRsize(String rsize) {
		this.rsize = rsize;
	}
	public String getBook() {
		return book;
	}
	public void setBook(String book) {
		this.book = book;
	}
	public String getAsk() {
		return ask;
	}
	public void setAsk(String ask) {
		this.ask = ask;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}	
	
}
