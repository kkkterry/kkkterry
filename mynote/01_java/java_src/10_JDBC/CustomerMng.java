package com.lec.ex2Customer;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.*;

import com.lec.ex1person.PersonDto;

public class CustomerMng extends JFrame implements ActionListener {

	private Container contenPane;
	private JPanel jpup, jpdown;
	private JTextField txtPhone, txtName, txtPoint;
	private JButton btnJoin, btnSearch, btnOutput, btnExit;
	private JTextArea jta;
	private JScrollPane scrollpane;
	//
	private CustomerDao dao;
	private ArrayList<CustomerDto> customer;
	
	public CustomerMng(String title) {
		super(title);
		dao = CustomerDao.getInstance();
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		contenPane = getContentPane();
		contenPane.setLayout(new FlowLayout());
		jpup = new JPanel(new GridLayout(3,2));
		jpdown = new JPanel(new FlowLayout());
		txtPhone = new JTextField(15);
		txtName	= new JTextField(15);
		txtPoint = new JTextField(15);
		
		btnJoin = new JButton("입력");
		btnSearch = new JButton("폰조회");
		btnOutput = new JButton("출력");
		btnExit = new JButton("종료");
		
		btnJoin.setPreferredSize(new Dimension(150,50));
		btnOutput.setPreferredSize(new Dimension(150,50));
		btnSearch.setPreferredSize(new Dimension(150,50));
		btnExit.setPreferredSize(new Dimension(150,50));
		jta = new JTextArea(10,60);
		scrollpane = new JScrollPane(jta);
		jpup.add(new JLabel("폰번호",(int)CENTER_ALIGNMENT));
		jpup.add(txtPhone);
		jpup.add(new JLabel("이름",(int)CENTER_ALIGNMENT));
		jpup.add(txtName);
		jpup.add(new JLabel("포인트",(int)CENTER_ALIGNMENT));
		jpup.add(txtPoint);
		
		jpdown.add(btnJoin);
		jpdown.add(btnSearch);
		jpdown.add(btnOutput);
		jpdown.add(btnExit);
		
		contenPane.add(jpup);
		contenPane.add(jpdown);
		contenPane.add(scrollpane);
		setVisible(true);
		setSize(new Dimension(700, 450));
		setLocation(200, 150);
		
		btnJoin.addActionListener(this);
		btnOutput.addActionListener(this);
		btnSearch.addActionListener(this);
		btnExit.addActionListener(this);
	}
	
@Override
public void actionPerformed(ActionEvent e) {
	if(e.getSource()== btnJoin) {
		String phone = txtPhone.getText().trim();
		String name = txtName.getText().trim();
		String pointstr = txtPoint.getText().trim();
		if(name.equals("")||phone.equals("")||pointstr.equals("")) {
			jta.setText("폰번호, 이름, 포인트 모두 입력하셔야 입력가능");
			return;
		}
		int point = Integer.parseInt(pointstr);
		int result = dao.insertCustomer(new CustomerDto(phone,name,point));
		if(result == CustomerDao.SUCCESS) {
			jta.setText(name+"님 입력성공");
			txtPhone.setText("");
			txtName.setText("");
			txtPoint.setText("");
		}
			
		}else if(e.getSource()==btnSearch) {
			String phone = txtPhone.getText().trim();
			if(phone.equals("")) {
				jta.setText("직업을 선택후, 직업조회 가능");
				return;
			}
			customer = dao.selectPhone(phone);
			if(customer.isEmpty()) {
				jta.setText("해당직업의 사람이 없습니다.");
			}else {
				jta.setText("폰번호\t이름\t포인트");
				for(CustomerDto c : customer) {
					jta.append(c.toString()+"\n");
				}
			}
			
		}else if(e.getSource()==btnExit) {
			setVisible(false);
			dispose();
			System.exit(0);
		}else if(e.getSource() == btnOutput) {
			// 전체 출력을 txtPool에
			customer = dao.selectAll();
			if(customer.isEmpty()) {
				jta.setText("사람이 없습니다.");
			}else {
				jta.setText("순번\t폰번호\t\t이름\t포인트\n");
				for(CustomerDto c : customer) {
					jta.append(c.toString()+"\n");
				}
			}
		}
}

public static void main(String[] args) {
	new CustomerMng("회원관리");
}
	
}

