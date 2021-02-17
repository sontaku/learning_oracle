--10.integrity.sql
--DB 제약 사항 설정

/* 
dept : emp
1.공통 컬럼 : deptno
2.어떤 table의 deptno가 종속?
	

3.제약사항
	-dept의 deptno
		-unique : 
		-not null : 
		-primary key(기본키, pk) : 
		-용도 : 
		
	-emp의 deptno
		-empno : 
		-deptno : 
		
4.참고
	-create 방식
		-타입 명시에서 무 -> 유
		-유 -> 유 존재하는 table로 부터 복제
			
5.제약조건 설정
	-table 생성시
		-컬럼 명시 동시 설정
		-컬럼 기술후에 마지막에 설정
		
	-복제 직후 추가
		-alter
*/

/* 
학습
		
1.table 생성시 제약조건 설정

2.제약 조건 종류
	emp와 dept의 관계

	-PK[primary key] - 기본키, 중복불가, null불가, 데이터들 구분을 위한 핵심 데이터
			: not null + unique
	-not null - 반드시 데이터 존재
	-unique - 중복 불가 
	-check - table 생성시 규정한 범위의 데이터만 저장 가능 
	-default - insert시에 특별한 데이터 미저장시에도 자동 저장되는 기본 값
	-FK[foreign key] 
	
3.사용자 정의하는 제약 조건에 제약 조건명 명시
	-oracle engine이 기본적으로 설정
		-사용자가 제약 조건에 별도의 이름을 부여하지 않으면 오라클 자체적으로 SYS_시작하는 이름을 자동 부여
		-SYS_Xxxx

	-sql개발자가 직접 설정
		-table명_컬럼명_제약조건명등 기술, 단 순서는 임의 변경 가능
			: dept의 deptno이 제약조건명
				PK_DEPT
				pk_dept_deptno
	
4.제약조건 선언 위치
	-컬럼 레벨 단위
		-컬럼선언 라인 

	-테이블 레벨 단위 
		-모든 컬럼 선언 직후 별도로 제약조건 설정 
	
5.오라클 자체 특별한 table
	-user_constraints
		-제약조건 정보 보유 table
		-개발자가 table의 데이터값 직접 수정 불가
		-select constraint_name, constraint_type, table_name from user_constraints;

6.이미 존재하는 table의 제약조건 수정(추가, 삭제)명령어
	-제약조건 추가
		alter table 테이블명 add constraint 제약조건명 제약조건(컬럼명);
		
		
	-제약조건 삭제(drop)
		table 삭제 
		alter table 테이블명 cascade constraint;
		
		alter table 테이블명 drop 제약조건명;
		
	-제약조건 임시 비활성화
		alter table 테이블명 disable constraint 제약조건명;

	-제약조건 활성화
		alter table 테이블명 enable constraint 제약조건명;
	
*/
--1.오라클 db에 설정한 table의 제약조건 정보를 보유하고 있는
--오라클 자체 table 검색하기 :  user_constraints
--DB 자체적으로 사전과 같은 딕셔너리 table
--사용자가 insert/update/delete 불가 


/* 
constraint_type : 제약조건 정보 컬럼
-P : 기본키, Primary key, 주키
-R : 참조 or 관계(reference or relation), 외래키
*/


--사전 table에 저장되는 table 명들은 대문자로 변경되어 저장(upper())
select constraint_name, constraint_type, table_name 
from user_constraints;
--WHERE TABLE_NAME = 'EMP';

--2.사용자 정의 제약 조건명 명시하기
DROP TABLE EMP02;

CREATE TABLE EMP02(
    EMPNO NUMBER(4) CONSTRAINT EMP02_EMPNO_NN NOT NULL,
    ENAME VARCHAR2(10)
);

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE TABLE_NAME = 'EMP02';

INSERT INTO EMP02 VALUES(1, 'TESTER');
INSERT INTO EMP02 (ENAME) VALUES(1, 'TESTER'); --에러
SELECT * FROM EMP02;


--3.사용자 정의 제약조건명 설정 후 위배시 출력되는 메세지에 사용자정의 제약조건명


--4.제약조건명을 오라클 엔진이 자동적으로 지정
DROP TABLE EMP02;

CREATE TABLE EMP02(
    EMPNO NUMBER(4) UNIQUE,
    ENAME VARCHAR2(10)
);

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE TABLE_NAME = 'EMP02';

--5.pk설정 : 선언 위치
--컬럼 
DROP TABLE EMP02;

CREATE TABLE EMP02(
    EMPNO NUMBER(4) CONSTRAINT EMP02_PK, PRIMARY KEY,
    ENAME VARCHAR2(10)
);
INSERT INTO EMP02 VALUES(1, 'TESTER');
INSERT INTO EMP02 (ENAME) VALUES('TESTER');

--table 
DROP TABLE EMP02;
CREATE TABLE EMP02(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10)
     CONSTRAINT EMP02_PK, PRIMARY KEY(EMPNO)
);


--6.외래키(참조키)
--이미 제약 조건이 설정된 dept table의 pk컬럼인 deptno값을 기준으로 
--emp02의 deptno에도 반영(참조키, 외래키, fk)


--컬럼
DROP TABLE EMP02;
CREATE TABLE EMP02(
    EMPNO NUMBER(4) PRIMARY KEY, 
    ENAME VARCHAR(10) NOT NULL, 
    DEPTNO NUMBER(4) CONSTRAINT EMP02_DEPTNO_FK REFERENCES DEPT(DEPTNO)
);

DESC EMP02;

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE TABLE_NAME = 'EMP02';

INSERT INTO EMP02 VALUES(2, 'TESTER', 50);

--7.?6번의 내용을 table 단위에서 설정
DROP TABLE EMP02;
CREATE TABLE EMP02(
    EMPNO NUMBER(4) PRIMARY KEY, 
    ENAME VARCHAR(10) NOT NULL, 
    DEPTNO NUMBER(4), 
    CONSTRAINT EMP02_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);

--8.emp01과 dept01 table 생성
drop table dept01;
drop table emp01;
create table dept01 as select * from dept;
create table emp01 as select * from emp;

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE TABLE_NAME = 'EMP01';

--9.이미 존재하는 table에 제약조건 추가하는 명령어 
--DEPT01
ALTER TABLE DEPT01 ADD CONSTRAINT DEPT01_DEPTNO_PK PRIMARY KEY(DEPTNO);

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE TABLE_NAME = 'DEPT01';

--?emp01에 제약조건 추가해 보기
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY(EMPNO);
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT01(DEPTNO);


SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE TABLE_NAME = 'EMP01';

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE TABLE_NAME = 'DEPT01';

--10.참조 되는 key의 컬럼이라 하더라도 자식 table에서 미사용되는 데이터에 한해서는 삭제 가능
DROP TABLE DEPT01;
DROP TABLE DEPT01 CASCADE CONSTRAINT;

SELECT * FROM EMP01;
SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE TABLE_NAME = 'EMP01';

--11.참조되는 컬럼 데이터라 하더라도 삭제

	
--12.check : 점검 - 일정 조건에 따라서 해당하는 데이터를 제약, 제한함
--AGE 1~100
DROP TABLE EMP01;

CREATE TABLE EMP01(
    ENAME VARCHAR2(10),
    AGE NUMBER(3) CONSTRAINT EMP01_AGE_CK CHECK(AGE BETWEEN 1 AND 100)
);

INSERT INTO EMP01 VALUES('SIAT', 100);
SELECT  * FROM EMP01;

INSERT INTO EMP01 VALUES('SIAT3', 102);

INSERT ALL
    INTO EMP01 VALUES('SIAT2', 100)
    INTO EMP01 VALUES('SIAT3', 102)    
SELECT * FROM DUAL;

-- 13.?gender라는 컬럼에는 데이터가 M 또는 F만 저장되도록 설계
--emp01 table 생성 시 컬럼 : name varchar2(10), gender char(1)
DROP TABLE EMP01;
CREATE TABLE EMP01(
    NAME VARCHAR2(10),
    GENDER CHAR(1) CONSTRAINT EMP01_GENDER_CK CHECK(GENDER = 'M' OR GENDER = 'F')
--    GENDER CHAR(1) CONSTRAINT EMP01_GENDER_CK CHECK(GENDER IN('M', 'F'))
);

INSERT INTO EMP01 VALUES('SIAT', 'M');
SELECT  * FROM EMP01;

INSERT INTO EMP01 VALUES('SIAT', 'T');
SELECT * FROM EMP01;

--14.default
DROP TABLE EMP01;

CREATE TABLE EMP01(
    ID VARCHAR(10) PRIMARY KEY,
    GENDER CHAR(1) DEFAULT 'F' --NULL이면 'F'
);

INSERT INTO EMP01(ID) VALUES('SIAT');
SELECT * FROM EMP01;