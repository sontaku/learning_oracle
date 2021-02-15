--8.DDL.sql

--DDL(Data Definition Language)

--Oracle 데이터 타입 : 자바 타입
--varchar2,char : String
--number(전체자리수[, 소수점이하자리]) : 정수, 실수
--date : java.util.Date, java.sql.Date, String


/* 참고 : 
문자열 표현하는 타입
- varchar2[최대 메모리] : char[고정사이즈메모리] 
- varchar2(10)의 타입에 - abc 저장(실제 메모리는? 3byte만 사용)
- char(5)로 선언 - a 저장(실제 메모리는 5byte 소진)	

  * varchar2
	- 범위 설정없이 선언시 자동 점유 사이즈(오라클은 4000 byte)
	- oracle 8i까지 문자열 표현 : varchar
	- 11g : varchar로 선언시 자동으로 varchar2로 변경

  * number 
	- 자릿수 제한없이 선언시 38자리로 자동 할당 

[1] table 생성
    create table table명(
		칼럼명1 칼럼타입[(사이즈)] [제약조건] ,
		칼럼명2....
    ); 

[2] table 삭제
	drop table table명;

[3] table 구조 수정
*/

-- TEST 테이블(TEST)
DROP TABLE TEST;

CREATE TABLE TEST(
    NAME VARCHAR(10), 
    NAME2 CHAR(10)
);

DESC TEST;

SELECT * FROM TEST;

--존재하는 table 삭제


--새로운 데이터 저장 -> 컬럼의 byte 확인 함수(lengthb())
INSERT INTO TEST VALUES('SIAT', 'SIAT2');

SELECT * FROM TEST;

--varchar2와 char의 메모리 사이즈 확인 : 데이터 저장된 이후 확인
SELECT LENGTH(NAME), LENGTH(NAME2) FROM TEST;

--1. table삭제 
DROP TABLE TEST;

SELECT * FROM TEST;
DESC TEST;
SELECT * FROM TAB;

--2. table 생성
--people table 생성 : name(varchar2), age(number)
DROP TABLE PEOPLE;

CREATE TABLE PEOPLE(
    NAME VARCHAR2(20),
    AGE NUMBER(3)
);

DESC PEOPLE;

--3. table 생성(이미 존재하는 table 기반) : emp01 
--emp table의 모든 데이터로 emp01 생성
DROP TABLE EMP01;

SELECT * FROM EMP;

CREATE TABLE EMP01 AS SELECT * FROM EMP;

DESC EMP;
DESC EMP01;

SELECT * FROM EMP01;

--4.emp02 table 생성(특정 컬럼(empno)만 참조)
DROP TABLE EMP02;
CREATE TABLE EMP02 AS SELECT EMPNO FROM EMP;
SELECT * FROM EMP02;

--5.?emp03 table 생성(참조 컬럼 : empno, ename, deptno, 조건 : deptno=10) 
DROP TABLE EMP03;
CREATE TABLE EMP03 AS SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP03;

--6.?emp04 table 생성(table 구조만 복제)
--사용되는 조건식 : where=거짓
DROP TABLE EMP04;
CREATE TABLE EMP04 AS SELECT * FROM EMP WHERE 1 = 0;
SELECT * FROM EMP04;


--table 수정 : alter
/*
데이터 구조 변경
1. 미존재하는 컬럼 추가
2. 존재하는 컬럼 삭제
3. 존재하는 컬럼의 타입(사이즈) 변경
	경우의 수 1 : 기존 사이즈보다 작게 수정
			
	경우의 수 2 : 기존 사이즈보다 크게 수정
		
	경우의 수 3 : 타입 수정
*/

--emp01 table로 실습

--7.emp01 table 생성(empno, ename 참조) 후, job 컬럼 추가(job varchar2(10))
--컬럼 추가
--add

DROP TABLE EMP01;

CREATE TABLE EMP01 AS SELECT EMPNO, ENAME FROM EMP;

DESC EMP01;

ALTER TABLE EMP01 ADD(JOB VARCHAR2(10));

DESC EMP01;
SELECT * FROM EMP01;


--8.emp01 job 컬럼 사이즈 변경(varchar2(20))
--데이터 미존재 컬럼 사이즈 변경
--modify
DESC EMP01;

ALTER TABLE EMP01 MODIFY(JOB VARCHAR2(20));

DESC EMP01;

--9.?emp01(empno, ename, job 컬럼 참조) 생성 후, job 컬럼 사이즈 변경 
SELECT * FROM TAB;

DROP TABLE EMP01;

CREATE TABLE EMP01 AS SELECT EMPNO, ENAME, JOB FROM EMP;
ALTER TABLE EMP01 MODIFY(JOB VARCHAR2(18));

DESC EMP01;


--?job컬럼 데이터의 최고 사이즈 확인
SELECT MAX(LENGTH(JOB)) FROM EMP01;

ALTER TABLE EMP01 MODIFY(JOB VARCHAR2(4000));
DESC EMP01;

--?데이터 사이즈보다 작게 수정 시도
ALTER TABLE EMP01 MODIFY(JOB VARCHAR2(2));
DESC EMP01;

--10.job 컬럼 삭제 
--데이터 존재시에도 자동 삭제 
--drop 
ALTER TABLE EMP01 DROP COLUMN JOB;

DESC EMP01;

--11.emp01을 test01로 table 이름 변경
--rename
DROP TABLE TEST01;
RENAME EMP01 TO TEST01;
SELECT * FROM TEST01;
SELECT * FROM EMP01;

SELECT * FROM TAB;

PURGE RECYCLEBIN;

--12.table의 순수 데이터만 완벽하게 삭제하는 명령어 
--commit 불필요
SELECT * FROM TEST01;

TRUNCATE TABLE TEST01; --자주 쓰이진 않음

SELECT * FROM TEST01;

