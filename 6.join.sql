--6.join.sql
SELECT *
FROM TAB;

/*
1. 조인(Join)이란?
	다수의 table간에  공통된 데이터를 기준으로 검색하는 명령어
	다수의 table이란?
		동일한 table을 논리적으로 다수의 table로 간주
			- self join
		물리적으로 다른 table간의 조인

2. table 관계 
	- emp & dept 
	  : deptno 컬럼으로 연관

	- emp & salgrade
	  : sal 컬럼으로 연관


3. table 별칭 사용 
	- 컬럼명이 다름 : table별칭 사용 불필요 
	- 컬럼명이 중복 : 구분을 위해 정확한 table 소속 명시
	- table명 또는 table별칭
	- 주의 사항 : 컬럼별칭 as[옵션], table별칭 as 사용 불가


4. 조인 종류 
	1. equi 조인(inner join, simple 조인) - 동등 조인
		 = 동등비교 연산자
		 : 사용 빈도 가장 높음
		 : 테이블에서 같은 조건이 존재할 경우의 값 검색 

	2. not-equi 조인
		: 100% 일치하지 않고 특정 범위내의 데이터 조인시에 사용
		: between ~ and(비교 연산자)

	3. self 조인 
		: 동일 테이블 조인
		: 동일 테이블 내 다른 컬럼 참조
			emp의 empno[사번]과 mgr[사번] 관계

	4. outer 조인 
		: 두 개 이상의 테이블이 조인될때 특정 데이터가 모든 테이블에 존재하지 않고 컬럼은 존재하나 null값을 보유한 경우
		  검색되지 않는 문제를 해결하기 위해 사용되는 조인
		  null 값이기 때문에 배제된 행을 결과에 포함 할 수 있으며 (+) 기호를 조인 조건에서 정보가 부족한 컬럼쪽에 적용
		
		: 데이터가 null인 table에 + 기호 표기 
*/


--1.dept table 구조
SELECT * FROM TAB;

DESC DEPT;

SELECT *
FROM DEPT;

DESC SALGRADE;

SELECT *
FROM SALGRADE;

--동등 조인
--= 동등 비교
--2.SMITH 의 이름, 사번, 근무지역(부서위치) 정보 검색
SELECT ENAME, EMPNO , DEPTNO
FROM EMP
WHERE ENAME = 'SMITH';

SELECT DEPTNO , LOC
FROM DEPT
WHERE DEPTNO = 20;

SELECT ENAME, EMPNO , LOC, EMP.DEPTNO
FROM EMP, DEPT
WHERE ENAME = 'SMITH' AND EMP.DEPTNO = DEPT.DEPTNO;

--별칭사용가능
SELECT ENAME, EMPNO , LOC, E.DEPTNO
FROM EMP E, DEPT D
WHERE ENAME = 'SMITH' AND E.DEPTNO = D.DEPTNO;

--3.deptno가 동일한 모든 데이터 검색
--emp & dept
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--4.2+3 번 항목 결합해서 SMITH에 대한 모든 정보(ename, empno, sal, comm, deptno, loc) 검색
SELECT ENAME, EMPNO, SAL, COMM, D.DEPTNO, LOC
FROM EMP E, DEPT D
WHERE ENAME = 'SMITH' AND E.DEPTNO = D.DEPTNO;

--5.SMITH에 대한 이름과 부서번호, 부서명(dname) 검색
SELECT ENAME, D.DEPTNO, DNAME
FROM EMP E, DEPT D
WHERE ENAME = 'SMITH' AND E.DEPTNO = D.DEPTNO;

--6.?뉴욕에 근무하는 사원의 이름과 급여를 검색 
SELECT ENAME,  SAL, LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND LOC = 'NEW YORK';

--7.?ACCOUNTING 부서에 소속된 사원의 이름과 입사일 검색
SELECT * 
FROM DEPT;

SELECT ENAME, HIREDATE, DNAME
FROM EMP E, DEPT D
WHERE DNAME = 'ACCOUNTING' AND E.DEPTNO = D.DEPTNO;

--8.?job이 MANAGER인 사원의 이름, 부서명 검색
SELECT *
FROM EMP;

SELECT ENAME, DNAME, JOB
FROM EMP E, DEPT D
WHERE JOB = 'MANAGER' AND E.DEPTNO = D.DEPTNO;

--not-equi join
--급여(salgrade) table(급여 등급)
--9.사원의 급여 등급 검색
--between ~ and : 포함
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

SELECT ENAME, GRADE
FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL;

--?등급이 3등급인 사원의 이름과 급여 검색
SELECT GRADE, ENAME, SAL
FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL
    AND GRADE = 3;

--?10.사원테이블의 부서 번호로 부서 테이블을 참조하여 사원명, 부서번호, 부서의 이름검색
SELECT ENAME, E.DEPTNO, DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--self join
--FROM EMP E, EMP M -> 같은 테이블을 참조하지만, 별칭으로 구분짓는다
-- 가정) E : 사원의 테이블
--         M : 관리자 테이블
--11.SMITH의 관리자(MGR) 이름 검색
SELECT * FROM EMP;

SELECT E.EMPNO, E.ENAME, E.MGR, M.EMPNO, M.ENAME
FROM EMP E, EMP M
WHERE E.ENAME = 'SMITH' AND E.MGR = M.EMPNO;

--?SMITH의 관리자 부서번호 검색
SELECT * FROM EMP;

SELECT M.DEPTNO, M.ENAME
FROM EMP E, EMP M
WHERE E.ENAME = 'SMITH' AND E.MGR = M.EMPNO;

--12.?관리자가 KING인 사원들의 이름과 직급 검색

SELECT * FROM EMP WHERE MGR = 7839;

SELECT E.ENAME, E.JOB
FROM EMP E, EMP M
WHERE M.ENAME = 'KING' AND E.MGR = M.EMPNO;

--13.?SMITH와 동일한 근무지에서 근무하는 사원의 이름 검색
SELECT * FROM EMP;

SELECT M.ENAME , M.DEPTNO
FROM EMP E, EMP M -- E : SMITH, M : Other
WHERE E.ENAME = 'SMITH' AND E.EMPNO != M.EMPNO AND E.DEPTNO = M.DEPTNO;

--outer join
--14.모든 사원이름, 관리자 이름 검색(단 관리자가 없는 사원도 검색)
/*
EMPNO 사번 : 12개 - 사원 수만큼 존재
MGR 관리자 번호 11개 - 실제 사용 가능한 데이터의 개수
*/
SELECT * FROM EMP;

SELECT E.ENAME, M.ENAME
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+);

--15.?모든 사원이름, 부서번호, 부서명 검색
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT E.ENAME, E.DEPTNO,D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

--HR/HR 계정 test
--16.?직원의 이름(LAST_NAME)과 직책(JOB_TITLE) 검색
--단, 사용되지 않는 직책이 있다면 그 직책이 정보도 검색에 포함
--검색 정보 이름(2개 : LAST_NAME, First_NAME)과 job_title(직책)


--17.?직원들의 이름(First_NAME), 입사일, 부서명(DEPARTMENT_NAME) 검색

