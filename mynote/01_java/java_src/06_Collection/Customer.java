package com.lec.ex1_list;

public class Customer {
	private String name;
	private String tel;
	private String ad;
	
	public Customer(String name, String tel, String ad) {
		this.name = name;
		this.tel = tel;
		this.ad = ad;
	}

	@Override
	public String toString() {
		return name +"  "+ tel + "  " + ad ;
	}

}
