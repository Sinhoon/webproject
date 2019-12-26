package kr.co.acorn.dto;

public class RelHelpDto {
	private int num;
	private String h_email;
	private String a_email;
	public RelHelpDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RelHelpDto(int num, String h_email, String a_email) {
		super();
		this.num = num;
		this.h_email = h_email;
		this.a_email = a_email;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getH_email() {
		return h_email;
	}
	public void setH_email(String h_email) {
		this.h_email = h_email;
	}
	public String getA_email() {
		return a_email;
	}
	public void setA_email(String a_email) {
		this.a_email = a_email;
	}
	
	
}
