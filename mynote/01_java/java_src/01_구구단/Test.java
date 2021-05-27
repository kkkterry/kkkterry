package com.lec.ex;
import java.util.Scanner;

public class Test {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int su;
		
		do {
			System.out.print("구구단 단수를 입력하시오: ");
			su = sc.nextInt();
			if(su>=2 && su<=9)
				break;
		}while(true);
		
		gugu(su);
	}

private static void gugu(int su) {
	int result=1;
	for(int i=1; i<=9; i++) {
		System.out.printf("%d * %d =%d \t",su, i, su*i);
	}
}
	
}
