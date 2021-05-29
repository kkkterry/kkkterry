package com.lec.ex6;


public class Customer {
	private String name;
	private String tel;
	private String birth;
	private String ad;
	
	public Customer(String name, String tel, String birth, String ad) {
		this.name = name;
		this.tel = tel;
		this.birth = birth;
		this.ad = ad;
	}
	
	public Customer() {
		
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return String.format("%s  %s  %s»ý  %s\n", name,tel,birth,ad);
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

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getAd() {
		return ad;
	}

	public void setAd(String ad) {
		this.ad = ad;
	}
	
	
}
