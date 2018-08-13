package clean;

public class OrderDTO {

	private String name, addr, contactnum, cellnum, email, cleantype, cleansize, cleandate, book, etc ;

	
	public OrderDTO() {}
	public OrderDTO(String name, String addr, String contactnum, String cellnum, String email, String cleantype,
			String cleansize, String cleandate, String book, String etc) {
		this.name = name;
		this.addr = addr;
		this.contactnum = contactnum;
		this.cellnum = cellnum;
		this.email = email;
		this.cleantype = cleantype;
		this.cleansize = cleansize;
		this.cleandate = cleandate;
		this.book = book;
		this.etc = etc;
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

	public String getContactnum() {
		return contactnum;
	}

	public void setContactnum(String contactnum) { 
		this.contactnum = contactnum;
	}

	public String getCellnum() {
		return cellnum;
	}

	public void setCellnum(String cellnum) {
		this.cellnum = cellnum;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCleantype() {
		return cleantype;
	}

	public void setCleantype(String cleantype) {
		this.cleantype = cleantype;
	}

	public String getCleansize() {
		return cleansize;
	}

	public void setCleansize(String cleansize) {
		this.cleansize = cleansize;
	}

	public String getCleandate() {
		return cleandate;
	}

	public void setCleandate(String cleandate) {
		this.cleandate = cleandate;
	}

	public String getBook() {
		return book;
	}

	public void setBook(String book) {
		this.book = book;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}
	
	
}
