package kr.co.acorn.dto;

public class HelpMeDto {
	private int category;
	private String title;
	private String content;
	private int gender;
	private String helper_email;
	private String ask_email;
	private boolean iscomplete;
	private String addr;
	private String regdate;

	public HelpMeDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public HelpMeDto(int category, String title, String content, int gender, String helper_email, String ask_email,
			boolean iscomplete, String addr, String regdate) {
		super();
		this.category = category;
		this.title = title;
		this.content = content;
		this.gender = gender;
		this.helper_email = helper_email;
		this.ask_email = ask_email;
		this.iscomplete = iscomplete;
		this.addr = addr;
		this.regdate = regdate;
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

	public String getHelper_email() {
		return helper_email;
	}

	public void setHelper_email(String helper_email) {
		this.helper_email = helper_email;
	}

	public String getAsk_email() {
		return ask_email;
	}

	public void setAsk_email(String ask_email) {
		this.ask_email = ask_email;
	}

	public boolean isIscomplete() {
		return iscomplete;
	}

	public void setIscomplete(boolean iscomplete) {
		this.iscomplete = iscomplete;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	

}
