--9.DML.sql
/* 
-DML : Data Mainpulation Language, 데이터 조작 언어
		이미 존재하는 table 데이터 저장, 수정, 삭제, 검색
-CRUD
	-C : CREATE, 데이터 삽입 INSERT

	-R : READ, 존재하는 데이터 검색 SELECT

	-U : UPDATE, 존재하는 데이터 수정 UPDATE

	-D : DELETE, 존재하는 데이터 삭제 DELETE
		
-commit : 영구저장, rollback : 복원 문장 필수
-- INSERT 이후 COMMIT을 해야 저장이 된다.


-영구 저장 조건				

	
1.insert 
	1-1.모든 컬럼 데이터 저장 
		table 구조상의 컬럼 순서에 맞게 데이터 저장
		insert into table명 values(데이터값1, ...)

	1-2.특정 컬럼 데이터 저장
		명확하게 컬럼명 기술 
		insert into table명(컬럼명1,...) values(컬럼매핑 데이터1...)

	1-3.다수 데이터 저장
		insert all 
			into table명 [(컬럼명,...)] values(데이터,,,)		
		select 검색컬럼 from....;

2.update
	2-1.table 모든 행 데이터 수정
		where 조건문 없음
		update table명 set 컬럼명 = 수정데이터;

	2-2.특정 row만 수정
		where 조건문으로 처리
		update table명 set 컬럼명 = 수정데이터 where 조건;
*/

DROP TABLE PEOPLE;

CREATE TABLE PEOPLE(
    NAME VARCHAR2(20),
    AGE NUMBER(3)
);

DESC PEOPLE;

--insert
--1.컬럼명 기술없이 데이터 입력
INSERT INTO PEOPLE VALUES('SIAT', 25);

SELECT * FROM PEOPLE;

--2.컬럼명 기술후 데이터 입력 
INSERT INTO PEOPLE (NAME, AGE) VALUES('SIAT2', 26);

--지정 순서대로 입력하면 알아서 재배열
INSERT INTO PEOPLE (AGE, NAME) VALUES(25, 'SIAT3');

--3.다중 table에 한번에 데이터 입력 
--이미 존재하는 table의 데이터를 기반으로 다수의 table에 insert하기
--존재하는 emp table로 부터 서로 다른 table에 동시 insert
DROP TABLE EMP01;
DROP TABLE EMP02;

CREATE TABLE EMP01 AS SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE 1=0;
CREATE TABLE EMP02 AS SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE 1=0;

INSERT ALL
    INTO EMP01 (EMPNO, ENAME, DEPTNO) VALUES(EMPNO, ENAME, DEPTNO)
    INTO EMP02 (EMPNO, ENAME) VALUES(EMPNO, ENAME)
SELECT EMPNO, ENAME, DEPTNO FROM EMP;

SELECT * FROM EMP01;
SELECT * FROM EMP02;

--4.?부서 번호가 10인 데이터 emp01에 저장, 
--부서 번호가 20 or 30인 데이터는 emp02에 저장
--조건 표현 : when~then
TRUNCATE TABLE EMP01;
TRUNCATE TABLE EMP02;

SELECT * FROM EMP01;
SELECT * FROM EMP02;

INSERT ALL
    WHEN DEPTNO = 10 THEN INTO EMP01 (EMPNO, ENAME, DEPTNO) VALUES (EMPNO, ENAME, DEPTNO)
    WHEN DEPTNO = 20 OR DEPTNO = 30 THEN INTO EMP02 (EMPNO, ENAME, DEPTNO) VALUES (EMPNO, ENAME, DEPTNO)
SELECT * FROM EMP;

--데이터만 삭제(truncate) - rollback으로 복구 불가능한 데이터 삭제 명령어


--update
--1.테이블의 모든 행 데이터 변경


--이전의 데이터로 복원


--2.?emp01 table의 모든 사원의 급여를 10%(sal*1.1) 인상


--3.?emp01의 모든 사원의 입사일을 오늘로 변경


-- 4.?급여가 3000이상인 사원의 급여만 10%인상


--5.?사원의 급여가 1000이상인 사원들의 급여만 500원씩 삭감 


--6.?DALLAS(dept의 loc)에 위치한 부서의 소속 사원들의 급여를 1000인상


--7.?emp01 table의 SMITH 사원의 부서 번호를 30으로, 직급은 MANAGER 수정
drop table emp01;
create table emp01 as select * from emp;


--delete
--8.table의 모든 데이터 삭제


--9.?특정 row 데이터 삭제(where 조건식 기준)
--emp01에서 deptno가 10번인 데이터만 삭제


--10.?emp01 table에서 comm 존재 자체가 없는 사원 삭제


--11.?emp01 table에서 comm이 null이 아닌 사원 모두 삭제


--12.?emp01 table에서 부서명이 RESEARCH 부서에 소속된 사원 삭제 


--13.table내용 삭제

