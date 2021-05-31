package com.lec.ex2_swing;
import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.util.ArrayList;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class MyFrame extends JFrame implements ActionListener{

	private Container contenPane;
	private JPanel jp,jp1;
	private JTextField jtxtName, jtxtTel, jtxtAge;
	private ImageIcon icon1, icon2;
	private JButton btnOut, btnIn;
	private ArrayList<Person> persons;
	Writer writer = null;
	Reader reader = null;
	
	public MyFrame() {
		this("");
	}
	
	public MyFrame(String title) {
		super(title);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		contenPane =getContentPane();
		
		jp = new JPanel(new GridLayout(3,2));
		jp1 = new JPanel(new FlowLayout());
		jtxtName = new JTextField();
		jtxtTel = new JTextField();
		jtxtAge = new JTextField();
		icon1 = new ImageIcon("icon/output.png");
		icon2 = new ImageIcon("icon/join.png");
		btnOut = new JButton("출력",icon1);
		btnIn = new JButton("입력",icon2);
		persons = new ArrayList<Person>();
		
		jp.add(new JLabel("이름", (int)CENTER_ALIGNMENT));
		jp.add(jtxtName);
		jp.add(new JLabel("전화", (int)CENTER_ALIGNMENT));
		jp.add(jtxtTel);
		jp.add(new JLabel("나이", (int)CENTER_ALIGNMENT));
		jp.add(jtxtAge);
		
		jp1.add(btnIn);
		jp1.add(btnOut);
		
		contenPane.add(jp, BorderLayout.NORTH);
		contenPane.add(jp1, BorderLayout.SOUTH);
		
		setVisible(true);
		setBounds(100, 100, 300, 180);
		
		btnIn.addActionListener(this);
		btnOut.addActionListener(this);
	}
	
	
	
	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		if(e.getSource()==btnIn) {
			String name = jtxtName.getText().trim();
			String tel = jtxtTel.getText().trim();
			//예외
			if(name.equals("")||tel.equals("")) {
				System.out.println("이름과 전화번호는 필수 입력 사항입니다.");
				return;
			}
			if(tel.indexOf("-") == tel.lastIndexOf("-")) {
				System.out.println("전화번호 포멧이 맞지 않습니다.");
				return;
			}
			if(tel.length()>13) {
				System.out.println("전화번호 포멧이 맞지 않습니다.");
				return;
			}
		
			
			//
			int age = 0;
			try {
				age = Integer.parseInt(jtxtAge.getText());
				if(age<0 || age>=150) {
					System.out.println("유요하지 않는 나이 값");
					return;
				}
			}catch(NumberFormatException e1) {
				System.out.println("유요하지 않는 나이 형식");
				return;
			}
			
			Person person = new Person(name, tel, age);
			persons.add(person);
			jtxtName.setText("");
			jtxtTel.setText("");
			jtxtAge.setText("");
			}
		
		if(e.getSource()==btnOut) {
			try {
				writer = new FileWriter("txtText/person.txt");
				for(int i=0;i<persons.size();i++) {
					writer.write(persons.get(i).toString());
					System.out.print(persons.get(i).toString());
				}
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				System.out.println(e1.getMessage());
			}finally {
				if(writer!=null) {
					try {
						writer.close();
					}catch(IOException e2) {
						
					}
				}
			}
			System.out.println("저장성공");
		}
	}
	
	public static void main(String[] args) {
		new MyFrame("GUI 예제");
	}
	
	
}
