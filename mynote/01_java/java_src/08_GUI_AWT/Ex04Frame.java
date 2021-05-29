package ch17_GUI;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Ex04Frame extends Frame implements ActionListener {
	private Panel panel;
	private List list;
	private TextField txtField;
	private Button btnExit, btnOk;
	
	public Ex04Frame() {
		//객체 생성
		panel = new Panel();
		list = new List();
		txtField = new TextField(20);
		btnOk = new Button("OK");
		btnExit = new Button("EXIT");
		//객체 추가
		panel.add(new Label(""));
		panel.add(txtField);
		panel.add(btnOk);
		panel.add(btnExit);
		//위치 설정
		add(panel, BorderLayout.NORTH);	//panel을 레이아웃의 북쪽에 위치하게 해라
		add(list, BorderLayout.CENTER);
		//레이아웃 사이즈 위치 설정
		setVisible(true);
		setSize(new Dimension(400,200));
		setLocation(300,200);
		btnOk.addActionListener(this);
		btnExit.addActionListener(this);
		
	}
	
	public Ex04Frame(String title) {
		this();
		setTitle(title);
	}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getSource()==btnOk) {
			list.add(txtField.getText());
			txtField.setText("");
		}else if(e.getSource()==btnExit) {
			setVisible(false);
			dispose();
			System.exit(0);
		}	
	}
	
	public static void main(String[] args) {
		new Ex04Frame("구매리스트");
	}
	
}
