--7.subQuery.sql
--select문 내 또 다른 select문 
--참  고 : join 또는 subquery로 동일한 결과값 검색
--실행순서 : sub query -> main 쿼리


--1.SMITH 부서명 검색
SELECT DEPTNO
FROM EMP
WHERE ENAME = 'SMITH';

SELECT DNAME
FROM DEPT
WHERE DEPTNO=20;

--?join
SELECT E.DEPTNO, DNAME 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND ENAME = 'SMITH';

--서브쿼리
SELECT  DNAME
FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO 
                            FROM EMP
                            WHERE ENAME = 'SMITH');

--2.?SMITH와 동일한 job을 가진 사원 검색(SMITH 포함)
SELECT E.ENAME, E.JOB
FROM EMP E, EMP M
WHERE E.JOB = M.JOB AND E.ENAME = 'SMITH';

SELECT ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB
                        FROM EMP
                        WHERE ENAME = 'SMITH');

--3.?SMITH와 급여가 동일하거나 더 많은(>=) 사원과 급여 검색
--SMITH 제외
SELECT E.ENAME, E.SAL
FROM EMP E, EMP M
WHERE E.SAL >= M.SAL AND M.ENAME = 'SMITH' AND E.ENAME != 'SMITH';

SELECT ENAME, SAL
FROM EMP
WHERE ENAME != 'SMITH' AND SAL >= (SELECT SAL
                                                            FROM EMP
                                                            WHERE ENAME = 'SMITH');
                                                            
--4.?DALLAS에 근무하는 사원의 이름, 부서 번호 검색
SELECT ENAME, E.DEPTNO
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.LOC = 'DALLAS';

SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                            FROM DEPT
                            WHERE LOC = 'DALLAS');

--5.?평균 급여보다 더 많이 받는 사원 모든정보 검색
SELECT *
FROM  EMP
WHERE SAL > (SELECT AVG(SAL)
                        FROM EMP);

--다중행 서브 쿼리(sub query의 결과값이 하나 이상)
--6.sal이 3000이상 사원이 소속된 부서에 속한 사원 이름, 급여 검색
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL >= 3000;

SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (10, 20);

SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO
                                FROM EMP
                                WHERE SAL >= 3000);

--7.?in 연산자를 이용하여 부서별로 가장 급여를 많이 받는 사원의 정보(사번, 사원 이름, 급여, 부서번호) 검색
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP;

SELECT DEPTNO, MAX(SAL)
FROM EMP 
GROUP BY DEPTNO;

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                                                FROM EMP 
                                                 GROUP BY DEPTNO);

--8.?job이 MANAGER인 사람이 속한 부서의 부서 번호와 부서명과 지역검색
SELECT E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.JOB = 'MANAGER' AND E.DEPTNO = D.DEPTNO;

SELECT DEPTNO, DNAME, LOC
FROM DEPT
WHERE DEPTNO IN (SELECT DEPTNO
                                FROM EMP
                                WHERE JOB = 'MANAGER');
