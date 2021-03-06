-- ?? ???????? 1
DROP TABLE CUSTOMER;
DROP TABLE CUS_LEVEL;
DROP SEQUENCE CUS_SQ;
CREATE TABLE CUS_LEVEL(
    LEVELNO   NUMBER(1) PRIMARY KEY,
    LEVELNAME VARCHAR2(20) NOT NULL);
CREATE SEQUENCE CUS_SQ MAXVALUE 999999 NOCACHE NOCYCLE;
CREATE TABLE CUSTOMER(
    CNO      NUMBER(6)    PRIMARY KEY,
    CNAME    VARCHAR2(50) NOT NULL,
    JOINDATE DATE         DEFAULT SYSDATE,
    PHONE    VARCHAR2(30) UNIQUE,
    POINT    NUMBER(10),
    LEVELNO  NUMBER(1)    REFERENCES CUS_LEVEL(LEVELNO));
INSERT INTO CUS_LEVEL VALUES (1, 'VVIP');
INSERT INTO CUS_LEVEL VALUES (2, 'VIP');
INSERT INTO CUS_LEVEL VALUES (3, 'NORMAL');
INSERT INTO CUS_LEVEL VALUES (4, 'BLACK');
INSERT INTO CUSTOMER VALUES (CUS_SQ.NEXTVAL, 'ȫ?浿', 
        TO_DATE('21/06/10','RR/MM/DD'),'010-9999-9999',300,1);
INSERT INTO CUSTOMER VALUES (CUS_SQ.NEXTVAL, '??ö??', 
        TO_DATE('20/11/12','RR/MM/DD'),'010-8888-8888',NULL,2);
SELECT * FROM CUSTOMER;
-- TEST
SELECT CNO, CNAME, TO_CHAR(JOINDATE,'YYYY-MM-DD'), 
                    PHONE, POINT, LEVELNAME
    FROM CUS_LEVEL L, CUSTOMER C
    WHERE L.LEVELNO=C.LEVELNO;




















