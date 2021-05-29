package com.lec.ex6;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;



public class MainTest {
	public static void main(String[] args) {
		String name1 =null;
		String tel1 =null;
		String birth1 =null;
		String ad1 =null;
		String line = null;
		Writer writer = null;
		Reader reader = null;
	
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
		Date today = new Date();
		String strToday = sdf.format(today);
		
		
		ArrayList<Customer> arrayList = new ArrayList<Customer>();
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
			System.out.println("생일 :");
			birth1 = sc.nextLine();
			if(birth1.equals(strToday)) {
				System.out.println("생일축하합니다.");
			}
			System.out.print("주소:");
			ad1 = sc.nextLine();
			arrayList.add(new Customer(name1,tel1,birth1,ad1));
			
		}
		try {
			writer = new FileWriter("txtText/customer.txt");
			for(int i=0;i<arrayList.size();i++) {
				writer.write(arrayList.get(i).toString());
			}
			writer.write("이하"+arrayList.size()+"명 가입");
		} catch (IOException e1) {
			System.out.println(e1.getMessage());
		} finally {
			if(writer!=null) {
				try {
					writer.close();
				} catch (IOException e) {
					
				}
			}
		}
		
		try {
			reader = new FileReader("txtText/customer.txt");
			while(true) {
				int i = reader.read();
				if(i==-1) {
					break;
				}
				System.out.print((char)i);
			}
		} catch (FileNotFoundException e) {
			System.out.println(e.getMessage());
		} catch (IOException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(reader!=null) {
					reader.close();
				}
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}
		
	}
}
