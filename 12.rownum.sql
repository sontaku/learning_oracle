--12.rownum.sql
--rownum
--oracle 자체적으로 제공하는 컬럼
--table당 무조건 자동 생성
--검색시 검색된 데이터 순서대로 rownum값 자동 반영(1부터 시작)

--인라인뷰 프롬절에 위치함
SELECT ROWNUM, EMPNO FROM EMP
ORDER BY EMPNO DESC;

--?dept의 deptno를 내림차순(desc)으로 rownum과 함께 검색
SELECT ROWNUM, DEPTNO
FROM DEPT
ORDER BY DEPTNO DESC;

--?deptno의 값이 오름차순으로 정렬하여 30번까지 rownum 포함하여 검색
--fwghso
SELECT ROWNUM, DEPTNO
FROM DEPT
WHERE DEPTNO != 40
ORDER BY DEPTNO ASC;

SELECT ROWNUM, DEPTNO
FROM DEPT
WHERE DEPTNO <= 30
ORDER BY DEPTNO ASC;

--emp table
--?deptno의 값이 오름차순으로 정렬해서 상위 3개의 데이터만 검색, rownum 포함해서 검색
SELECT ROWNUM, DEPTNO
FROM DEPT;

SELECT ROWNUM
FROM (SELECT ROWNUM, DEPTNO
        FROM EMP
        ORDER BY DEPTNO DESC);

SELECT ROWNUM, DEPTNO
FROM (SELECT ROWNUM, DEPTNO
        FROM EMP
        ORDER BY DEPTNO DESC);
        
--프롬절에서 사용하는 서브쿼리를 '인라인뷰'라고 한다.
SELECT ROWNUM, DEPTNO
FROM(SELECT DEPTNO
    FROM EMP
    ORDER BY DEPTNO DESC)
WHERE ROWNUM < 4;

--1.?emp table의 입사일이 최신인 사원의 이름과 입사일 검색(최신 5명) 
SELECT * FROM EMP
ORDER BY HIREDATE DESC;

SELECT ENAME, HIREDATE
FROM (SELECT ENAME, HIREDATE
    FROM EMP
    ORDER BY HIREDATE DESC)
WHERE ROWNUM <= 5;

--2.?급여를 많이 받는 순서대로 이름과 급여 검색(상위 3명)
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC;

SELECT ENAME, SAL
FROM (SELECT ENAME, SAL
        FROM EMP
        ORDER BY SAL DESC)
WHERE ROWNUM <= 3;