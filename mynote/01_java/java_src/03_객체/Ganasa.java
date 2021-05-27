package com.lec.ex10;

public class Ganasa extends Person {
	private String cl;
	
	public Ganasa(String id, String name, String cl) {
		super(id, name);
		this.cl = cl;
	}

	public void printCl() {
		System.out.println("(°ú¸ñ)"+cl);
	}

	public String getCl() {
		return cl;
	}

	public void setCl(String cl) {
		this.cl = cl;
	}
	
	
}
