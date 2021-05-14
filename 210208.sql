--1. 직업(job)이 MANAGER인 사원의 이름(ename)과 직업(job), 월급(sal)을 월급 내림차순으로 정렬.
SELECT ename, job, sal
FROM emp
WHERE job = 'MANAGER'
ORDER BY sal DESC;

--2. 이름(ename)에 'A'가 들어가는 사원 중 월급(sal)을 1000이상, 2000 이하로 받는 직원의 이름(ename), 월급(sal)
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 2000 AND ename LIKE '%A%';