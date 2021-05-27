package com.lec.ex;

public class Quiz04 {
	public static void main(String[] args) {
		int money =2680;
		int[] coinUint = {0, 0, 0, 0};
		
		for(int i=0;i<coinUint.length;i++) {
			if(money>500) {
				coinUint[i]=money/500;
				money=money%500;
				continue;
			}else if(money>100) {
				coinUint[i]=money/100;
				money=money%100;
				continue;
			}else if(money>50) {
				coinUint[i]=money/50;
				money=money%50;
				continue;
			}else if(money>10) {
				coinUint[i]=money/10;
				money=money%10;
				continue;
			}
			
		}
		System.out.printf("500원짜리 %d개, 100원짜리 %d개, 50원짜리 %d개, 10원짜리 %d개",coinUint[0],coinUint[1],coinUint[2],coinUint[3]);
	}
}
