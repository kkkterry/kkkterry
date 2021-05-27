package com.lec.ex10;

public class Student extends Person{
	private String ban;
	
	public Student(String id, String name, String ban) {
		super(id, name);
		this.ban = ban;
	}
	
	public void printBan() {
		System.out.println("(¹Ý)"+ban);
	}

	public String getBan() {
		return ban;
	}

	public void setBan(String ban) {
		this.ban = ban;
	}
	
}
