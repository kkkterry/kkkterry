----------------------------------연습문제---------------------------------------

CREATE TABLE MY_DATA (
    ID NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(10),
    USEDID  VARCHAR2(30),
    SALARY NUMBER(10,2)
);

INSERT INTO MY_DATA VALUES (1,'SCOTT','SSCOTT',10000);
INSERT INTO MY_DATA VALUES (2, 'FORD', 'FFORD',13000);
INSERT INTO MY_DATA VALUES (3, 'PATEL', 'PPATEL',33000);
INSERT INTO MY_DATA VALUES (4, 'REPORT', 'RREPORT', 23500);
INSERT INTO MY_DATA VALUES (5, 'GOOD', 'GGOOD', 44450);

SELECT ID, NAME, USEDID, TO_CHAR(SALARY,'99,999.00') SALARY
    FROM MY_DATA;

UPDATE MY_DATA SET SALARY = 65000 WHERE ID=3;

DELETE FROM MY_DATA WHERE NAME ='FORD';

UPDATE MY_DATA SET SALARY = 15000 WHERE SALARY<=15000;

DROP TABLE MY_DATA;

---------------------------정리를  위해 적어둔 것 실행은 이 페이지에 적합지 않음 ------------------------
-- ★ ★ DCL(사용자 계정생성, 사용자권한부여, 권한박탈, 사용자계정삭제)
CREATE USER joeun IDENTIFIED BY tiger; -- joeun 계정 생성
-- 권한 부여(세션권한, scott.emp, scott.dept에 대한 모든 권한)
GRANT CREATE SESSION TO joeun;
GRANT ALL ON EMP TO joeun; -- 내계정의 emp테이블에 대한 모든 권한 부여
GRANT SELECT ON DEPT TO joeun; -- 내계정의 dept테이블에 대한 selete 권한 부여
SHOW USER;
-- 권한박탈(권한박탈할 ID가 접속해제 중)
REVOKE ALL ON EMP FROM joeun; -- 내계정의 emp 테이블에 대한 모든 권한 박탈
REVOKE ALL ON DEPT FROM joeun;
-- 사용자 계정 삭제(접속 중 계정삭제 불가)
DROP USER joeun CASCADE;

SHOW USER;
SELECT * FROM USER_TABLES; -- 내 계정이 소유한 테이블
SELECT * FROM ALL_TABLES WHERE TABLE_NAME IN ('DEPT', 'EMP'); -- 내 계정이 접근가능한 테이블
SELECT * FROM DBA_TABLES; -- 일반계정에서는 불가
SELECT ENAME, DNAME, LOC 
  FROM SCOTT.EMP E, SCOTT.DEPT D
  WHERE E.DEPTNO=D.DEPTNO;
SELECT * FROM SCOTT.EMP;
EXIT; -- 접속해제








