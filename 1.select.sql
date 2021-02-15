--1.select
/*
1.기본 검색
1-1.단순 검색
	select절 속성명[ , ..]
	from절 table명;
	- 실행 순서 : from 절 -> select 절

1-2.정렬 포함 검색
	select절
	from절
	order by절
	- 실행 순서 : from절 -> select절 -> order by절
	
1-3.조건식 포함 검색
	select절
	from절
	where절
	- 실행 순서 : from절 -> where절-> select절
	
1-4.조건식과 정렬 포함 검색
	select절
	from절
	where절
	order by절
	- 실행 순서 : from절 -> where절 -> select절 -> order by절

2.참고 - 오라클 버전에 따른 이름의 변천사
	1. 8i, 9i
	2. 10g, 11g,...
	3. 12c, ...
*/

--1.cmd 창 조절


--2.계정 모든 table 검색
/*
SELECT *
FROM TAB;
*/
--3.emp table의 모든 정보 검색
SELECT *
FROM emp;

--4.emp table의 구조 보기
DESC EMP;
DESC DEPT;
DESC sal;
/*
    1. VARCHAR2(10)
       - 가변적인 문자열 타입
        - 소괄호 의 값은 최대 크기
       - 영어는 1byte, 한글은 2byte
       - 자바의 String
    
    2. NUMBER(2)
       - 괄호 안의 값은 최대 자리수
          - 소수점이 있다면 소수점 이하 몇자리 포함하는지
    
    3. DATE
        - 날짜를 표기하는 타입
*/
--5.emp table의 사번(empno)과 이름(ename) 검색
--검색되는 컬럼명에 별칭을 부여한다.
--문법 : 컬럼명 별칭 or 컬럼명 AS 별칭
--          쌍따옴표를 통해서도 가능하지만 자바와 충돌이 발생할 수 있다.
SELECT empno, ename 
FROM emp;

SELECT empno AS 사번, ename AS 이름 
FROM emp;

--6.emp table의 입사일(hiredate) 검색
DESC emp;
    -- DATA 표기방법 : yy/mm/dd -> yy-mm-dd
SELECT hiredate
FROM emp;


--7.emp table의 검색(empno -> 사번 별칭 부여)
SELECT empno AS 사번
FROM emp;

--8.emp table에서 부서번호 검색시 중복 데이터 제거 후 검색
SELECT * 
FROM emp;

SELECT deptno
FROM emp;

SELECT DISTINCT deptno /* DISTINCT : 중복 제거 */
FROM emp;

--순서 : order
--9.데이터를 오름차순(asc)으로 검색(정렬)
--키워드 : order by
--ASC : 오름차순(기본), DESC: 내림차순

SELECT DISTINCT deptno 
FROM emp
ORDER BY deptno ASC;

SELECT *
FROM emp
ORDER BY ename ASC;


--?사고력
--order by 절이 정말 가장 마지막에 실행되는 걸까? 힌트 : 컬럼 별칭
SELECT ename AS 이름
FROM emp
ORDER BY 이름 ASC;

--?사번을 오름차순으로 정렬해서 사번만 검색
SELECT empno
FROM emp
ORDER BY empno ASC;

--10.emp table에서 deptno 내림차순 정렬 적용하여 ename과 deptno 검색
SELECT ename, deptno
FROM emp
ORDER BY deptno DESC;

--?empno와 deptno 검색(단, deptno는 오름차순)
SELECT ename, deptno
FROM emp
ORDER BY deptno, ename ASC; /* orderby 앞에 있는 값 먼저 정렬 */

--11. 입사일(date 타입의 hiredate) 검색 - 경력일이 오래된 직원부터 검색
SELECT hiredate
FROM emp
ORDER BY hiredate ASC;

--연산
--12. emp table의 모든 직원명(ename), 월급여(sal), 연봉(comm 제외) 검색
--단 sal 컴럼값은 comm을 제외한 sal만으로 연봉 검색
SELECT ename, sal, (sal*12) AS YEARSAL
FROM emp;

--13.comm 포함 연봉 검색(년 급여 + comm) 검색
--NULL 값을 보유한 컬럼은 -> 연산 시, 데이터 존재 무시
--NULL 값을 0으로 수치화 하여 연산 : NVL(컬럼명, 변경하고자 하는 수치값)
SELECT empno, (sal*12), (sal*12 + comm) AS YEARSAL
FROM emp;

SELECT comm, NVL(comm,0) AS COMM
FROM emp;

SELECT empno, sal, (sal*12 + NVL(comm,0)) 
FROM emp;

--조건식 : where
--14.comm이 null인 사원 검색(ename, comm)
--IS NULL or IS NOT NULL
SELECT ename, comm
FROM emp
WHERE comm IS NULL;

--15.comm이 null이 아닌 사원 검색(ename, comm)
SELECT ename, comm
FROM emp
WHERE comm IS NOT NULL;

--16.?ename, 전체연봉(comm제외), 전체연봉(comm포함) 검색


--17.emp table에서 deptno 값이 20인 직원 모든 정보 출력
SELECT *
FROM emp
WHERE deptno = 20;

--?검색 결과 sal 내림차순으로 정렬검색
SELECT *
FROM emp
WHERE deptno = 20
ORDER BY sal DESC;

--18.?emp table에서 ename이 smith(SMITH)에 해당하는 deptno값은?
SELECT deptno
FROM emp 
WHERE ename = 'SMITH';

--19.sal가 900이상(>=)인 직원들의 이름(ename), sal 검색
SELECT ename, sal 
FROM emp
WHERE sal >= 900;

--20.deptno가 10이고(and) job이 매니저(MANAGER)인 사원이름 검색 
--AND 연산자
SELECT ename 
FROM emp 
WHERE deptno = 10 AND job = 'MANAGER';

--21.?deptno가 10이거나 job이 매니저(MANAGER)인 사원이름(ename) 검색
--OR 연산자
SELECT ename
FROM emp
WHERE deptno = 10 OR job = 'MANAGER';

--22. deptno가 10이 아닌 모든 사원명(ename) 검색
--아니다 : not, !=, <>
SELECT ename
FROM emp
WHERE deptno != 10;

SELECT ename
FROM emp
WHERE NOT deptno = 10;

--23.sal이 2000 이하(sal<=2000)이거나 3000 이상인(sal>=3000) 사원명(ename) 검색
SELECT ename, sal
FROM emp
WHERE sal <= 2000 OR sal >= 3000;

--24.comm이 300 or 500 or 1400인 사원명, comm 검색
SELECT ename, comm
FROM emp
WHERE comm = 300 OR comm = 500 OR comm = 1400;

--IN 연산자
SELECT ename, comm
FROM emp
WHERE comm IN (300, 500, 1400);

--25.?comm이 300 or 500 or 1400이 아닌(not) 사원명, comm 검색
SELECT ename, comm
FROM emp
WHERE NOT NVL(comm,0) IN (300, 500, 1400);

--26.81년도에 입사한 사원 이름 검색
--DATE는 대소비교가 가능함
SELECT ename, hiredate
FROM emp
WHERE hiredate >= '81/01/01' AND hiredate < '82/01/01';

--BETWEEN ~ AND ~

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN '81/01/01' AND '82/01/01';

--27.ename이 M으로 시작되는 모든 사원번호(empno), 이름(ename) 검색  
--  LIKE : 음절단위로 자리수 표기 /  _ : 한 음절, /  % : 음절 개수 무관
SELECT empno, ename
FROM emp
WHERE ename LIKE 'M%';

--28.ename이 M으로 시작되는 전체 자리수가 두음절의 사원번호, 이름 검색
SELECT empno, ename
FROM emp
WHERE ename LIKE 'M_';

--29.두번째 음절의 단어가 M인 모든 사원명 검색 
SELECT empno, ename
FROM emp
WHERE ename LIKE '_M%';

--30.단어가 M을 포함한 모든 사원명 검색 
SELECT empno, ename
FROM emp
WHERE ename LIKE '%M%';

--CUSTOM QUESTION(2문제)
SELECT * 
FROM emp;

--1. 직업(job)이 MANAGER인 사원의 이름(ename)과 직업(job), 월급(sal)을 월급 내림차순으로 정렬.
SELECT ename, job, sal
FROM emp
WHERE job = 'MANAGER'
ORDER BY sal DESC;

--2. 이름(ename)에 'A'가 들어가는 사원 중 월급(sal)을 1000이상, 2000 이하로 받는 직원의 이름(ename), 월급(sal)
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 2000 AND ename LIKE '%A%';