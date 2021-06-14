show databases;
show tables;
use mysql;
create table emp(
	empno numeric(4) primary key,
    ename varchar(20) not null,
    nickname varchar(20) unique,
    sal numeric(7,2) check(sal>0),
    hiredate DATETIME default now(),
    comm numeric(7,2) default 0
);
INSERT INTO EMP (EMPNO, ENAME, NICKNAME, SAL) VALUES(1111,'홍', '홍홍', 7000.71);
SELECT * FROM EMP;
COMMIT;

DROP TABLE IF EXISTS MAJOR;
CREATE TABLE MAJOR(
	MAJOR_CODE INT PRIMARY KEY auto_increment,
    MAJOR_NAME VARCHAR(30)
);
INSERT INTO MAJOR(MAJOR_NAME) VALUES ('경영정보');
INSERT INTO MAJOR(MAJOR_NAME) VALUES ('컴퓨터공학');
INSERT INTO MAJOR(MAJOR_NAME) VALUES ('통계학');
INSERT INTO MAJOR(MAJOR_NAME) VALUES ('빅데이터');
SELECT * FROM MAJOR;
create table STUDENT(
	stu_id int not null primary key,
	name varchar(15),
	major_code int references major (major_code)
);
insert into student values (1001, '홍길동', 1);
insert into student values (1002, '김길동', 2);
insert into student values (1003, '신길동', 3);
SELECT * FROM STUDENT;

SELECT * FROM STUDENT S, MAJOR M 
	WHERE S.MAJOR_CODE=M.MAJOR_CODE;					-- JOIN

insert into student values (1009, '홍', 9);

SELECT STU_ID, NAME, MAJOR_NAME 
FROM STUDENT S LEFT OUTER JOIN MAJOR M 
ON S.major_code=M.major_code;							-- LEFT OUTER JOIN : 왼쪽행을 다 나타내 준다

select s.stu_id, s.name, major_name 
	from student s right outer join major m 
		on s.major_code = m.major_code;						-- RIGHT OUTER JOIN : 오른쪽행을 다 나타내 준다.

---------------------------------------------------------------------------------------------------------------------------
-- JAVA 
SHOW TABLES;
drop table if exists division;
create table division(
	DNO int not null primary key,
    dname varchar(20),
    phone varchar(20),
    position varchar(20));
show tables;
drop table if exists personal;
create table personal (
	pno int primary key,
	pname varchar(10) not null,
    job varchar(15) not null,
    manager int,
    startdate date,
    pay int, 
    bonus int,
    dno int ,
    foreign key(dno) references division(dno));
show tables;
desc division;
insert into division values (10, 'finance','02-777-7777','종로');
insert into division values (20, 'research','041-888-7777','대전');
insert into division values (30, 'sales','02-999-7777','인천');
insert into division values (40, 'marketing','02-555-7777','강남');
select * from division;

load data local infile 'C:\bigdata\src\02_DBMS\MY_SQL\division.txt' replace into table division;
select * from personal;
select pno, pname '이름'  from personal;
truncate personal;
load data local infile 'C:\bigdata\src\02_DBMS\MY_SQL\personal.txt' replace into table personal;
insert into personal values (1111,'smith','manager', 1001, '1990-12-17', 1000, null, 10);
insert into personal values (1112,'ally','salesman',1116,'1991-02-20',1600,500,30);
insert into personal values (1113,'word','salesman',1116,'1992-02-24',1450,300,30);
insert into personal values (1114,'james','manager',1001,'1990-04-12',3975,null,20);
insert into personal values (1001,'bill','president',null,'1989-01-10',7000,null,10);
insert into personal values (1116,'johnson','manager',1001,'1991-05-01',3550,null,30);
insert into personal values (1118,'martin','analyst',1111,'1991-09-09',3450,null,10);
insert into personal values (1121,'kim','clerk',1114,'1990-12-08',4000,null,20);
insert into personal values (1123,'lee','salesman',1116,'1991-09-23',1200,0,30);
insert into personal values (1226,'park','analyst',1111,'1990-01-03',2500,null,10);
delete from personal where pno=1001;







































