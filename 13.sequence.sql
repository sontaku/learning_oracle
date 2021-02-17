--13.sequence.sql
/*
1.시퀀스
    -순차적 데이터 자동으로 반영
    -기본은 1씩 증가
    -문법(create, drop, nextval, currval)

2.활용
    -게시글 글번호에 주로 활용

3.특징
	-절대 중복 불가능
    
*/	
	     
--1.sequence 생성
DROP SEQUENCE SEQ_TEST_NO1;
CREATE SEQUENCE SEQ_TEST_NO1;

--2.sequence를 활용한 insert
DROP TABLE SEQ_TEST;

CREATE TABLE SEQ_TEST(
    NO1 NUMBER(2),
    NO2 NUMBER(2)
);

INSERT INTO SEQ_TEST VALUES(SEQ_TEST_NO1.NEXTVAL,10);
SELECT * FROM SEQ_TEST;

--다수 table에서 하나의 sequence 공동 사용?
CREATE TABLE SEQ_TEST2(
    NO1 NUMBER(2),
    NO2 NUMBER(2)
);

INSERT INTO SEQ_TEST2 VALUES(SEQ_TEST_NO1.NEXTVAL,10);
SELECT * FROM SEQ_TEST2; --공동 시퀀스 이기때문에 번호는 2부터 이어짐

INSERT INTO SEQ_TEST VALUES(SEQ_TEST_NO1.NEXTVAL,10);
SELECT * FROM SEQ_TEST;

--3.sequence 데이터 확인
SELECT SEQ_TEST_NO1.CURRVAL FROM DUAL;

--4.시작 index 지정 및 증가치 지정 sequence 생성
DROP SEQUENCE SEQ_TEST_NO1;
CREATE SEQUENCE SEQ_TEST_NO1
START WITH 10 --시작 번호
--INCREMENT BY -2 --증가 폭
MAXVALUE 100; -- 최대 값

SELECT * FROM SEQ_TEST;
INSERT INTO SEQ_TEST VALUES(SEQ_TEST_NO1.NEXTVAL,10);
SELECT * FROM SEQ_TEST;

--5.sequence 삭제
DROP SEQUENCE SEQ_TEST_NO1;
