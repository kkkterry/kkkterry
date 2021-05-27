package com.lec.ex10;

public class Staff extends Person {
	private String de;
	
	public Staff(String id, String name, String de) {
		super(id, name);
		this.de = de;
	}

	public void printDe() {
		System.out.println("(ºÎ¼­)"+de);
	}

	public String getDe() {
		return de;
	}

	public void setDe(String de) {
		this.de = de;
	}
	
	
}
