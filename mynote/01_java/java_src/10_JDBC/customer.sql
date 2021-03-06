DROP TABLE CUSTOMER;
CREATE TABLE CUSTOMER(
    ID NUMBER(9) PRIMARY KEY,
    PHONE VARCHAR2(30) NOT NULL,
    NAME VARCHAR2(30),
    POINT NUMBER(9)
);

DROP SEQUENCE CUSTOMER_ID_SQ;
CREATE SEQUENCE CUSTOMER_ID_SQ MAXVALUE 999999999 NOCYCLE NOCACHE;

-- 입력INSERT INTO CUSTOMER VALUES (CUSTOMER_ID_SQ.NEXTVAL, '010-9999-9999', '홍길동', 1000);
INSERT INTO CUSTOMER VALUES (CUSTOMER_ID_SQ.NEXTVAL, '010-9929-9929', '김길동', 2000);
INSERT INTO CUSTOMER VALUES (CUSTOMER_ID_SQ.NEXTVAL, '010-9939-9929', '박길동', 3000);
SELECT * FROM CUSTOMER;
commit;

-- 폰번호 조회
SELECT * FROM CUSTOMER WHERE PHONE LIKE '%'||'9999';

-- 출력
SELECT * FROM CUSTOMER;