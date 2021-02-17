--11.view.sql
/*
가령, emp table 에서 comm 존재자체를 다른 직군들에게 모르게 해야 할 경우
과연 table의 데이터를 어떻게 활용 가능하게 할 것인가?

-실제 존재 하는 table 기반으로 가상의 논리적인 table

*view 사용을 위한 필수 선행 설정
    1단계 : ADMIN 계정 접속
    2단계 : 관리자에서 VIEW 생성 권한 부여

1.view
    - 물리적으로는 존재X, 논리적 존재
    - 물리적 (CREATE TABLE)
    - 논리적 (가상 TABLE)
    - TEST
        - 생성
        - CRUD

2.필요
	특정 컬럼 은닉, 다수 table 조인된 결과의 새로운 테이블 자체를 가상으로 db내에 생성

3.문법
	-create와 drop : create view/drop view
	-crud는 table과 동일

4.view 기반으로 crud 반영시 실제 원본 table에도 반영

5.종류
	-단일 view : 별도의 조인 없이 하나의 table로 부터 파생된 view
	-복합 view : 다수의 table에 조인 작업의 결과값을 보유하는 view
	-인라인 view : sql의 from 절에 view 문장

6.실습 table
	dept01 table생성 -> dept01_v view 를 생성 -> crud -> view select/dept01 select 
*/

--1.test table생성
DROP TABLE DEPT01 CASCADE CONSTRAINT; --테이블 자체를 삭제하기 위함
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;

--2.dept01 table상의 view를 생성
CREATE VIEW DEPT01_V AS SELECT * FROM DEPT01;

DESC DEPT01_V;
SELECT * FROM DEPT01_V;

DROP VIEW DEPT01_V;

--3.?emp table에서 comm을 제외한 emp01_v(empno, ename, sal)라는 view 생성
DROP TABLE EMP01 CASCADE CONSTRAINT;
CREATE TABLE EMP01 AS SELECT * FROM EMP;

CREATE VIEW EMP01_V AS SELECT EMPNO, ENAME, SAL FROM EMP01;

DESC EMP01_V;
SELECT * FROM EMP01_V;

--강사님 버전
DROP VIEW EMP01_V;
CREATE VIEW EMP01_V AS SELECT EMPNO, ENAME, SAL FROM EMP01;
SELECT * FROM EMP01_V;


--4.dept01_v에 crud : dep01_v와 dept01 table 변화 살펴보기
DROP TABLE DEPT01 CASCADE CONSTRAINT;
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;
CREATE VIEW DEPT01_V AS SELECT * FROM DEPT01;
DESC DEPT01_V;

SELECT * FROM DEPT01_V;

UPDATE DEPT01_V SET DEPTNO = 20 WHERE DNAME = 'SALES';
SELECT * FROM DEPT01_V;
SELECT * FROM DEPT;
SELECT * FROM DEPT01;

CREATE VIEW DEPT02_V AS SELECT * FROM DEPT01;
UPDATE DEPT02_V SET DEPTNO = 70 WHERE DNAME = 'SALES';
SELECT * FROM DEPT01;
SELECT * FROM DEPT01_V;
SELECT * FROM DEPT02_V;

-- 강사님 버전
DROP TABLE DEPT01 CASCADE CONSTRAINT;
DROP VIEW DEPT01_V;
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;
CREATE VIEW DEPT01_V AS SELECT * FROM DEPT01;



--5.?직원의 모든 정보 검색(empno, ename, deptno, loc)
SELECT * FROM EMP01_V;
SELECT EMPNO, ENAME, DEPTNO, LOC
FROM EMP01_V, DEPT01_V;


CREATE VIEW TMP AS 
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.LOC
FROM EMP01 E, DEPT01 D
WHERE E.DEPTNO = D.DEPTNO;

SELECT * FROM TMP;

