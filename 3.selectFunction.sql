--3.selectFunction.sql
--함수(Function)
--특정 결과값을 얻기 위해 데이터를 입력할 수 있는 특수 명령어
/*
--종류
1. 내장함수(built-in function)
	- 단일행 함수(single-row function) : 한 행 -> 한 행
	- 다중행 함수(multiple-row function) : 여러 행 -> 한 행

2. 사용자 정의 함수(user-defined function)

--Oracle DB 지원 함수
	1. 숫자 함수
	2. 문자 함수
	3. 날짜 함수 
	4. ... 
*/

--오라클 dumy table 검색
SELECT 2+3 FROM DUAL;
SELECT SYSDATE FROM DUAL;

--숫자함수
--1.절대값 함수 : abs()
SELECT -2, ABS(-2) 
FROM DUAL;

--2.반올림 함수 : round(데이터 [, 반올림자릿수])
SELECT ROUND(34.56), ROUND(34.5654) 
FROM DUAL;

SELECT ROUND(34.56), ROUND(34.5654, 1) 
FROM DUAL;

SELECT ROUND(34.56), ROUND(34.5654, 0) 
FROM DUAL;

SELECT ROUND(34.56), ROUND(34.5654, -1) 
FROM DUAL;


--3.지정한 자리수 이하 버리는 함수 : trunc()
SELECT TRUNC(34.56), TRUNC(34.5654) FROM DUAL;
SELECT TRUNC(34.56), TRUNC(34.5654,-1) FROM DUAL;
SELECT TRUNC(34.56), TRUNC(34.5654, -1) FROM DUAL;
SELECT TRUNC(1234), TRUNC(1234,-2) FROM DUAL;

--4.나누고 난 나머지 값 연산 함수 : mod()
SELECT MOD(14, 3) FROM DUAL;

--5.? emp table에서 사번이 홀수인 사원의 이름, 사번 검색 
SELECT ENAME, EMPNO
FROM EMP
WHERE MOD(EMPNO, 2) = 1;

SELECT ENAME, EMPNO
FROM EMP
WHERE MOD(EMPNO, 2) != 0;

--6.제곱 함수 : power(X, Y) X의 3승
SELECT POWER(2, 3) FROM DUAL;

--문자함수
/* 
대문자 : upper
소문자 : lower
*/
--1.대소문자 변환 함수
--upper() : 대문자[uppercase]
--lower() : 소문자[lowercase]
SELECT 'AbCd', UPPER('AbCd')
FROM DUAL;

SELECT 'AbCd', LOWER('AbCd')
FROM DUAL;

--2.?소문자 manager로 일치되는 사원의 이름 검색 
SELECT ENAME, JOB
FROM EMP
WHERE JOB = UPPER('manager');

--3.문자열 길이 체크함수 : length()
SELECT 'ABC', LENGTH('ABC') FROM DUAL;
SELECT '가나다', LENGTH('가나다') FROM DUAL;

--4.byte수 체크함수 : lengthb()
SELECT 'ABC', LENGTHB('ABC') FROM DUAL;
SELECT '가나다', LENGTHB('가나다') FROM DUAL; -- 여기선 XE버전이라 3바이트로 출력

--5.문자열 추출함수 : substr(X, Y, Z) : X를 Y번 인덱스부터 Z개 출력
--                          substr(X, Y) : X를 Y번 인덱스부터 출력
--                          substr(X, -Y) : X를 뒤에서부터 Y개만큼 출력
--substr(데이터, 시작위치, 추출할 개수)
--SQL에서는 INDEX 1부터 시작
SELECT SUBSTR('ABCDE', 2) FROM DUAL;
SELECT SUBSTR('ABCDE', 2, 3) FROM DUAL;
SELECT SUBSTR('ABCDE', -1) FROM DUAL;

SELECT SUBSTR('ABCVDASFSAFQWEFZXCDVFQWERZSDFQWREFQAWRZXCVGSDSAFD', 
-LENGTH('ABCVDASFSAFQWEFZXCDVFQWERZSDFQWREFQAWRZXCVGSDSAFD')) 
FROM DUAL;

--6.?년도 구분없이 2월에 입사한 사원이름, 입사일 검색
SELECT *
FROM EMP
WHERE HIREDATE LIKE '%%/02/%%';

SELECT ENAME, HIREDATE
FROM EMP
WHERE SUBSTR(HIREDATE, 4, 2) = 02;

--7.문자열 앞뒤 여백 제거함수 : trim()
SELECT ' ABC ', LENGTH(' ABC '), TRIM(' ABC '), LENGTH(TRIM(' ABC '))  FROM DUAL;

SELECT LTRIM(' ABC '), LENGTH(LTRIM(' ABC ')) 
FROM DUAL;

SELECT RTRIM(' ABC '), LENGTH(LTRIM(' ABC ')) 
FROM DUAL;

SELECT '[' || LTRIM(' ABC ') || ']'
FROM DUAL;

--CONCAT()
SELECT CONCAT('ABC', '가나다')
FROM DUAL;

SELECT 'ABC' || '가나다'
FROM DUAL;

--8.특정 문자 대체 함수 : replace(ABBA, B, C) : ABBA에서 B를 C로 대체
--                               replace(ABBA, B) : ABBA에서 B를 삭제
SELECT '210209-1234567' 
FROM DUAL;

SELECT REPLACE('210209-1234567', '-') 
FROM DUAL;

--9. 특정 문자 채우기 함수 : lpad(A, B), rpad() : A글자를 B자리수만큼 채움
SELECT LPAD('Oracle', 10)
FROM DUAL;

SELECT LPAD('Oracle', 10, '*')
FROM DUAL;

--?개인정보
--'210209-1234567' -> '210209-********'
SELECT RPAD(REPLACE('210209-1234567', '1234567'), 14, '*')
FROM DUAL;

SELECT RPAD(RPAD('210209-1234567', 7), 14, '*')
FROM DUAL;

--?지금뭐하니?
SELECT RPAD(SUBSTR('210209-1234567', 1, 7), 14, '*')
FROM DUAL;

--날짜 함수
--현재 시스템 날짜 정보 : sysdate
--1.어제, 오늘, 내일 날짜 검색 
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-1 FROM DUAL;
SELECT SYSDATE+1 FROM DUAL;
SELECT SYSDATE + '10/10/10' FROM DUAL; --ERROR


--2.?emp table에서 근무일수 계산하기, 사번과 근무일수(반올림) 검색
SELECT ENAME, EMPNO, (ROUND(SYSDATE - HIREDATE)) AS 근무일수 -- +(더하기)는 에러
FROM EMP;


--3.특정 개월수 더하는 함수 : add_months() 
--6개월 이후 검색
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 6)
FROM DUAL;

--?사원들의 10주년 기념일
SELECT HIREDATE, ADD_MONTHS(HIREDATE, 120)
FROM EMP;

--4.?입사일 이후 3개월 지난 일수 검색
SELECT HIREDATE, ADD_MONTHS(HIREDATE, 3)
FROM EMP;

--5.두 날짜 사이의 개월수 검색 : months_between()
--오늘을 기준으로 2017-02-09
--months_between(기준날짜, 비교날짜) : 기준날짜가 최근이면 양수
SELECT MONTHS_BETWEEN(SYSDATE, '2017-02-09')
FROM DUAL;

--6.요일을 기준으로 특정 날짜 검색 : next_day()
SELECT SYSDATE, NEXT_DAY(SYSDATE, '화ㅋㅋㅋ')
FROM DUAL;

--7.주어진 날짜를 기준으로 해당 달의 가장 마지막 날짜 검색: last_day()
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM DUAL;

--8.?2017년 2월의 마지막 날짜
SELECT '2017-02-13', LAST_DAY('2017-03-01')
FROM DUAL;

--형변환 함수
/*
암시적 형변환
명시적 형변환

			-->					-->
숫자(Number) 		 문자(Chracter)  		 날짜(Date)
			<--					<--
*/
--사용 빈도 높음
--[1] to_char() : 날짜->문자, 숫자 -> 문자
--[2] to_date() : 날짜로 변경
--[3] to_number() : 문자열을 숫자로 변환


--[1] to_char()
--1. 오늘 날짜 'yyyy-mm-dd' 변환
SELECT SYSDATE
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-mm-dd')
FROM DUAL;

--dy : 요일
SELECT TO_CHAR(SYSDATE, 'YYYY-mm-dd DY', 'NLS_DATE_LANGUAGE = ENGLISH')
FROM DUAL;

--hh:mi:ss
SELECT TO_CHAR(SYSDATE, 'YYYY-mm-dd hh:mi:ss')
FROM DUAL;

--hh24:mi:ss
SELECT TO_CHAR(SYSDATE, 'YYYY-mm-dd hh24:mi:ss')
FROM DUAL;

--hh:mi:ss am 
SELECT TO_CHAR(SYSDATE, 'YYYY-mm-dd am hh:mi:ss ')
FROM DUAL;

--? 2.날짜(sysdate)의 round(), trunc()
-- 날짜 round()
-- 날짜 trunc()
SELECT SYSDATE, ROUND(SYSDATE), TRUNC(SYSDATE)
FROM DUAL;

--3. 숫자를 문자형으로 변환 : to_char()
--1. 숫자를 원하는 형식으로 변환 검색
--9 : 실제 데이터의 유효한 자릿수 숫자 의미(자릿수 채우지 않음)
--0 :	 "		(자릿수 채움)
--. : 소수점 표현
--, : 원단위 표현
--$ : 달러 
--L or l : L(Locale)지역화폐 표현

select to_char(1234, '$9999,99') , to_char(1234, '9999'), to_char(1234, '999,999'), to_char(1234, '99999'), to_char(1234, '00000'), to_char(1234, 'L99,999'), to_char(1234, 'l99,999') from dual;

select to_char(1234, '9999.99') from dual;
select to_char(1234, '$9999,99') from dual;
select to_char(1234, '9999') from dual;
select to_char(1234, '999,999') from dual;
select to_char(1234, '99999') from dual;
select to_char(1234, '00000') from dual;
select to_char(1234, 'L99,999') from dual;
select to_char(1234, 'l99,999') from dual;

--[2] to_date() : 날짜로 변경 시키는 함수
--1.? 올해 몇일이 지났는지 검색(포멧 yyyy/mm/dd)
SELECT SYSDATE - TO_DATE(20210101, 'YYYY/MM/DD')
FROM DUAL;

--2. 문자열로 date타입 검색
-- 1980년 12월 17일 입사한 직원이름 검색
SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE = '1980/12/17';

SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE = '80/12/17';

SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE = '1980-12-17';

SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE = '80-12-17';

SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE = '80   [  12  ]    17';

--[3] to_number() : 문자열을 숫자로 변환
--1.? '20,000'의 데이터에서 '10,000' 산수 연산하기 
SELECT 20000 - 10000 FROM DUAL;
SELECT '20000' - '10000' FROM DUAL;
SELECT '20000' - TO_NUMBER('10,000', 99999) FROM DUAL;


--조건식 함수
--decode()-if or switch
--decode(조건컬럼, 조건값1,  출력데이터1,
--			  조건값2,  출력데이터2,
--				...,
--			  default값) from table명;

--1.deptno에 따른 출력 데이터
SELECT *
FROM DEPT;

-- 10 -> 'A', 20 -> 'B', 나머지 부서는 'ETC'
SELECT DEPTNO, (DECODE(DEPTNO,
                                        10, 'A',
                                        20, 'B',
                                        'ETC') )AS 새로운부서이름
FROM DEPT;

--2.?emp table의 연봉(sal) 인상계산
--job이 ANALYST 5%인상(sal*1.05), SALESMAN은 10% 인상, MANAGER는 15%, CLERK 20% 이상 
--empno, job, sal, decode 출력
SELECT *
FROM EMP;

SELECT EMPNO, JOB, SAL, DECODE(JOB,
                                        'ANALYST', SAL*1.05,
                                        'SALESMAN', SAL*1.1,
                                        'MANAGER', SAL*1.15,
                                        'CLERK', SAL*1.2,
                                        SAL) AS 인상이후연봉
FROM EMP;

--3.?JOB : 'MANAGER' -> 'M', 'ANALYST' -> 'A', 나머지 -> 'ETC'
SELECT EMPNO, JOB, SAL, DECODE(JOB,
                                        'MANAGER', 'M',
                                        'ANALYST', 'A',
                                        'ETC') AS J
FROM EMP;

--case문
--case 조건컬럼
--		when 조건값1 then 출력데이터1
--		when 조건값2 then 출력데이터2
--		...
--		else default값
--end

--4.?2번 case문으로 바꾸기
--  DECODE 함수는 모두 CASE 문으로 바꿀 수 있다.
--  BUT, CASE문을 모두 DECODE 문으로 바꿀 수 없어
--      CASE문이 더 큰 가용성을 가진다.
--      가독성도 더 좋다.(DECODE가 필요할 때도 있으니 둘 다 익히자)
SELECT EMPNO, JOB, SAL, 
                                    CASE JOB 
                                        WHEN 'ANALYST' THEN SAL*1.05
                                        WHEN 'SALESMAN' THEN SAL*1.1
                                        WHEN 'MANAGER' THEN SAL*1.15
                                        WHEN 'CLERK' THEN SAL*1.2
                                        ELSE SAL 
                                    END AS 월급인상
FROM EMP;