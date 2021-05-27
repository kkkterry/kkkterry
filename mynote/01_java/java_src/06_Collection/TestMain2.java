package com.lec.ex1_list;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Scanner;

public class TestMain2 {
	public static void main(String[] args) {
		String name1=null;
		String tel1 = null;
		String ad1 = null;
		
		HashMap<String, Customer> hashmap = new HashMap<String, Customer>();
		Scanner sc = new Scanner(System.in);
		
		while(true) {
			System.out.println("이름 전화번호 주소를 입력하시오(출력을 원할 경우(n or N))");
			System.out.print("이름:(출력을 원할 경우(n or N))");
			name1 = sc.nextLine();
			if(name1.equalsIgnoreCase("n")) {
				break;
			}
			System.out.print("전화번호:");
			tel1 = sc.nextLine();
			System.out.print("주소:");
			ad1 = sc.nextLine();
			hashmap.put(tel1, new Customer(name1,tel1,ad1));
		}
		
		System.out.println("\n\n");
		
		if(hashmap.isEmpty()) {
			System.out.println("입력받은 값이 없습니다.");
		}
		
		Iterator<String> iterator = hashmap.keySet().iterator();
		
		while(iterator.hasNext()) {
			String key = iterator.next();
			System.out.println(hashmap.get(key));
		}
		
	}
}
