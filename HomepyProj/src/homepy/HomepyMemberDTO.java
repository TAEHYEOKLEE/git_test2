package homepy;

import java.sql.Date;

public class HomepyMemberDTO {
	//멤버변수
	private String id;
	private String pass;
	private String name;
	private String tel;
	private String mobile;
	private String email;
	private String zipcode;
	private String addr1;
	private String addr2;
	private java.sql.Date regidate;
	//생성자(기본,인자)
	public HomepyMemberDTO(String id, String pass, String name, String tel, String mobile, String email, String zipcode,
			String addr1, String addr2, Date regidate) {		
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.tel = tel;
		this.mobile = mobile;
		this.email = email;
		this.zipcode = zipcode;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.regidate = regidate;
	}
	public HomepyMemberDTO() {}	
	//getter/setter메소드
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public java.sql.Date getRegidate() {
		return regidate;
	}
	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}
}
