package com.lec.ex01;

import java.util.Scanner;

public class TestMain {
	public static void main(String[] args) {
		Friend[] F = {new Friend("홍길동","010-9999-1234","05-22"),
					  new Friend("포포몬","010-3333-1123","06-11")};
		Scanner sc = new Scanner(System.in);
		boolean searchOk = false;
		do {
			System.out.print("검색할 전화번호 뒷자리는(단, 종료를 원하시면 x를 입력하시오): ");
			String searchTel = sc.next();
			if(searchTel.equalsIgnoreCase("x")) {
				break;
			}
			
			searchOk = false;
			for(int idx=0;idx<F.length;idx++) {
				
				String postTel = F[idx].getPhone().substring(F[idx].getPhone().lastIndexOf("-")+1);
				if(searchTel.equals(postTel)) {
					System.out.println(F[idx]);
					searchOk = true;
				}
			}
			if(!searchOk) {
				System.out.println("해당 전화번호의 친구는 없습니다");
			}	
		}while(true);
		
		
		
	}
}
