--2.select_Qs
/*1.
부서번호가 10번인 부서의 사람 중 사원번호, 이름, 월급, +(부서번호)
*/
SELECT *
FROM EMP;

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

/*2.
사원번호가 7369인 사람 중 이름, 입사일, 부서 번호, +(사원번호)
*/

SELECT EMPNO, ENAME, HIREDATE , DEPTNO
FROM EMP
WHERE EMPNO = 7369;

/*3.
이름이 ALLEN인 사람의 모든 정보
*/

SELECT * 
FROM EMP
WHERE ENAME = 'ALLEN';

/*4.
입사일이 83/01/12인 사원의 이름, 부서번호, 월급
*/

SELECT *
FROM EMP;

SELECT ENAME, DEPTNO, SAL , HIREDATE
FROM EMP
WHERE HIREDATE = '83/01/12';

--입사일이 82/01/23인 사원의 이름, 부서번호, 월급

SELECT ENAME, DEPTNO, SAL , HIREDATE
FROM EMP
WHERE HIREDATE = '82/01/23';

/*5.
직업이 MANAGER가 아닌 사람의 모든 정보
*/

SELECT *
FROM EMP
WHERE NOT JOB = 'MANAGER';

/*6.
입사일이 81/04/02 이후에 입사한 사원의 정보
*/

SELECT *
FROM EMP
WHERE HIREDATE > '81/04/02';

/*7.
급여가 800이상인 사람의 이름, 급여, 부서번호
*/

SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL >= 800;

/*8.
부서번호가 20번 이상인 사원의 모든 정보
*/

SELECT *
FROM EMP
WHERE DEPTNO >= 20;

/*9.
이름이 K로 시작하는 사람의 모든 정보
*/

SELECT *
FROM EMP
WHERE ENAME LIKE 'K%';

/*10.
입사일이 81/12/09 보다 먼저 입사한 사람들의 모든 정보
*/

SELECT *
FROM EMP
WHERE HIREDATE < '81/12/09';

/*11.
사원번호가 7698보다 작거나 같은 사람들의 사원번호와 이름
*/

SELECT EMPNO, ENAME
FROM EMP
WHERE EMPNO <= 7698;

/*12.
입사일이 81/04/02보다 늦고 82/12/09보다 빠른 사원의 이름, 월급, 부서번호
*/

SELECT *
FROM EMP
WHERE HIREDATE BETWEEN '81/04/03' AND '82/12/08'
ORDER BY HIREDATE ASC;

/*13.
급여가 1600보다 크고[초과] 3000보다 작은[미만] 사람의 이름, 직업, 급여
*/

SELECT ENAME, JOB, SAL
FROM EMP
WHERE SAL > 1600 AND SAL < 3000;

/*14.
사원번호가 7654와 7782사이 이외의 사원의 모든 정보
*/

SELECT *
FROM EMP
WHERE NOT EMPNO BETWEEN 7654 AND 7782;

/*15.
직업이 MANAGER와 SALESMAN인 사람의 모든 정보
*/

SELECT *
FROM EMP
WHERE JOB IN('MANAGER', 'SALESMAN');

/*16.
부서번호와 20,30번을 제외한 모든 사람의 이름, 사원번호, 부서번호
*/

SELECT *
FROM EMP;

SELECT ENAME, EMPNO, DEPTNO
FROM EMP
WHERE NOT DEPTNO IN(20,30);

/*17.
이름이 S로 시작하는 사원의 사원번호, 이름, 입사일, 부서번호
*/

SELECT EMPNO, ENAME, HIREDATE, DEPTNO
FROM EMP
WHERE ENAME LIKE 'S%';

/*18.
이름중 S자가 들어가 있는 사람만 모든 정보
*/

SELECT *
FROM EMP
WHERE ENAME LIKE '%S%';

/*19.
S로 시작하고 마지막 글자가 H인 이름을 가진 사람의 모든 정보(단 이름은 전체 5자리)
*/
--있는 이름으로 수정했습니다.

SELECT *
FROM EMP
WHERE ENAME LIKE 'S___H' ;

/*20.
comm이 null인 사원의 정보
*/

SELECT *
FROM EMP
WHERE COMM IS NULL;

/*21.
comm이 null이 아닌 사원의 정보
*/

SELECT *
FROM EMP;

SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

/*22.
부서가 30번 부서이고 급여가 1500이상인 사람의 이름, 부서, 월급(sal)
*/

SELECT * 
FROM DEPT;

SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE DEPTNO = 30 AND SAL > 1500;

SELECT ENAME, EMP.DEPTNO, DNAME, SAL
FROM EMP, DEPT
WHERE DEPT.DEPTNO = EMP.DEPTNO AND EMP.DEPTNO = 30 AND SAL >= 1500;


/*23.
이름의 첫글자가 S로 시작하거나 부서번호가 30인 사람의 사원번호, 이름, 부서번호
*/
-- 문제가 K로 시작하는 이름? 이었던거 같은데 수정했습니다.
SELECT *
FROM EMP;

SELECT *
FROM EMP
WHERE ENAME LIKE 'S%' OR DEPTNO = 30;

/*23.
급여가 1500이상이고 부서번호가 30번인 사원중 직업이 MANAGER인 사람의 정보
*/

SELECT *
FROM EMP
WHERE SAL >= 1500 AND DEPTNO = 30 AND JOB = 'MANAGER';

/*24.
부서번호가 30인 사람중 사원번호 정렬
*/

SELECT *
FROM EMP;

SELECT *
FROM EMP
WHERE DEPTNO = 30
ORDER BY EMPNO ASC;

/*25.
급여가 많은 순으로 정렬
*/

SELECT *
FROM EMP
ORDER BY SAL DESC;

/*26.
부서번호로 오름차순 한 후 급여가 많은 사람 순
*/

SELECT *
FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

/*27.
부서번호로 내림차순 하고 급여순으로 내림차순
*/

SELECT *
FROM EMP
ORDER BY DEPTNO DESC, SAL DESC;

