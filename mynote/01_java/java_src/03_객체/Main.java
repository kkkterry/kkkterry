package com.lec.ex10;

public class Main {
	public static void main(String[] args) {
		Person[] p = {new Student("A01", "나학생","JAVA반"),
					  new Student("A02", "홍길동","C++반"),
					  new Staff("S01", "나직원", "교무팀"),
					  new Staff("S02", "나도요", "취업지원팀"),
					  new Ganasa("G01", "나선생","프로그래밍")
		};
		for(int i =0; i<p.length; i++) {
			p[i].printId();
			p[i].printName();
			if(i<=1) {
				System.out.println("(반)"+((Student)p[i]).getBan());
			}
			if(i<=3 && i>1) {
				System.out.println("(부서)"+((Staff)p[i]).getDe());
			}
			if(i>=4)
				System.out.println("(과목)"+((Ganasa)p[i]).getCl());
			}
		}
	}
		