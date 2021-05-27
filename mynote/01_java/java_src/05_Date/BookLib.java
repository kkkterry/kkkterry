package com.lec.ex05_lib;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class BookLib implements ILendable {
	private String borrower;
	private byte state;
	private String checkOutDate;
	private String bookNo;
	private String bookTitle;
	private String writer;
	Date checkoutDate;
	Date checkinDate;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 E요일");
	
	
	
	public BookLib(String bookNo, String bookTitle, String writer) {
		this.bookNo = bookNo;
		this.bookTitle = bookTitle;
		this.writer = writer;
	}
	

	public String getBorrower() {
		return borrower;
	}


	public void setBorrower(String borrower) {
		this.borrower = borrower;
	}


	public byte getState() {
		return state;
	}


	
	public void setState(byte state) {
		this.state = state;
	}


	public String getBookNo() {
		return bookNo;
	}


	public void setBookNo(String bookNo) {
		this.bookNo = bookNo;
	}


	public String getBookTitle() {
		return bookTitle;
	}


	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	
	public Date getCheckoutDate() {
		return checkoutDate;
	}


	public void setCheckoutDate(Date checkoutDate) {
		this.checkoutDate = checkoutDate;
	}


	public Date getCheckinDate() {
		return checkinDate;
	}


	public void setCheckinDate(Date checkinDate) {
		this.checkinDate = checkinDate;
	}


	@Override
	public void checkOut(String borrower) throws Exception {
		if(state != STATE_NORMAL) {
			throw new Exception("대출중인 도서입니다.");
		}
		//대출처리 로직
		this.borrower = borrower;
		checkoutDate = new Date();
		state = STATE_BORROWED;
		// 대출 완성후 메세지: "베개" 도서가 대출되었습니다.
		System.out.println("\""+this.getBookTitle()+"\" 도서가 대출되었습니다");
		System.out.println("[대출인]"+borrower);
		System.out.println("[대출일]"+sdf.format(checkoutDate));
	}

	@Override
	public void checkIn() throws Exception {
		if(state != STATE_BORROWED) {
			throw new Exception("대납중인 도서가 아닙니다.");
		}
		
		// 반납처리 로직
		checkinDate = new Date();
		
		long diff = checkinDate.getTime()-checkoutDate.getTime();
		long day = diff/(1000*60*60*24);				//두 시점 사이 몇일이 지났는가?
		if(day>14) {
			long money = (day-14)*100;
			System.out.println(money+"원 연체료를 납부하셔야 합니다.(y/n)");
			Scanner sc = new Scanner(System.in);
			String c = sc.next();
			if(c.equalsIgnoreCase("y")) {
				System.out.println("반납완료");
			}else {
				System.out.println("반납미완료 연체료를 내십시오");
			}
		}
		borrower = null;
		checkinDate = null;
		state = STATE_NORMAL;
		// 대출 완성후 메세지: "베개" 도서가 대출되었습니다.
		System.out.println("\""+this.getBookTitle()+"\" 도서가 반납되었습니다");
		

	}
	
	@Override
	public String toString() {
		//java(890ㄱ-01)" 홍길동著 대출가능
		//"hadoop(890ㄱ-02)" 홍하둡著 대출(20-12-16 수요일) 중
		if(state==STATE_NORMAL) {
			return bookTitle +"("+bookNo+")"+ getBookTitle()+"대출가능";
		}else {
			return bookTitle +"("+bookNo+")"+ getBookTitle()+"대출("+sdf.format(getCheckoutDate())+")";
		}
	}
}
