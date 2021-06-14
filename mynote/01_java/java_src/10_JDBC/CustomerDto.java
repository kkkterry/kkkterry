package com.lec.ex2Customer;

public class CustomerDto {
	private int id;
	private String phone;
	private String name;
	private int point;
	public CustomerDto(int id, String phone, String name, int point) {//sel
		this.id = id;
		this.phone = phone;
		this.name = name;
		this.point = point;
	}
	
	public CustomerDto(String phone, String name, int point) {//insert
		
		this.phone = phone;
		this.name = name;
		this.point = point;
	}
	
	public int getId() {
		return id;
	}
	public String getPhone() {
		return phone;
	}
	public String getName() {
		return name;
	}
	public int getPoint() {
		return point;
	}
	
	@Override
	public String toString() {
		return id +"\t "+ phone + "\t" + name + "\t" + point;
	}
	
	
	
	
}
