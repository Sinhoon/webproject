package kr.co.acorn.dto;

public class ListHelpDto {
	private int num;
	private int category;
	private String title;
	private String content;
	private int gender;
	private int iscomplete;
	private int hmax;
	private String addr;
	private String email;
	private String regdate;

	public ListHelpDto(int num, int category, String title, String content, int gender, int iscomplete, int hmax,
			String addr, String email, String regdate) {
		super();
		this.num = num;
		this.category = category;
		this.title = title;
		this.content = content;
		this.gender = gender;
		this.iscomplete = iscomplete;
		this.hmax = hmax;
		this.addr = addr;
		this.email = email;
		this.regdate = regdate;
	}

	public ListHelpDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
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

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public int getIscomplete() {
		return iscomplete;
	}

	public void setIscomplete(int iscomplete) {
		this.iscomplete = iscomplete;
	}

	public int getHmax() {
		return hmax;
	}

	public void setHmax(int hmax) {
		this.hmax = hmax;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

}
