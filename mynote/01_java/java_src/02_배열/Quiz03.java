package com.lec.ex;

public class Quiz03 {
	public static void main(String[] args) {
		int[] arr = {76, 45, 34, 89, 100, 50, 90, 92};
		int tot =0;
		double avg=0;
		int max = 0;
		int min = 999;
		
		for(int i=0; i<arr.length; i++) {
			
			tot += arr[i];
			
			if (max<arr[i]) {
				max =arr[i];
			}
			
			if (min>arr[i]) {
				min =arr[i];
			}
		}
		
		
		avg= (double)tot/(arr.length);
		
		System.out.println("합계 = "+tot+"\t"+"평균 = "+ avg+"\n"+"최대값은 = "+max+"\t"+"최소값은 = "+min);
				
	}
	
}
