--17.PLSQLFunction.sql
/*
1.저장 함수(Function)
	-오라클 사용자 정의 함수 

2.문법
	create function 함수명
	return 리턴타입
	is
	begin
	end;
	/
	
3.주의
	-절대 기존 함수명들과 중복 불가
	-참고
		함수 종류 : 내장 함수 & 사용자 정의 함수
		
4.프로시저와 차이
	-선언구
	-리턴 타입 선언 + 리턴 값
	-return 키워드 활용
*/


--1.emp table의 사번으로 사원 이름 검색 함수 
CREATE OR REPLACE FUNCTION USER_FUNC(NO NUMBER)
RETURN VARCHAR2
IS
    V_ENAME EMP.ENAME%TYPE;
BEGIN
    SELECT ENAME
        INTO V_ENAME
    FROM EMP
    WHERE EMPNO = NO;
    
    RETURN V_ENAME;
END;
/

SELECT USER_FUNC(7369) FROM EMP;
SELECT USER_FUNC(7369) FROM DUAL;

--2.?%type 사용해서 사원명으로 해당 사원의 job 반환 함수 
--함수명 : emp_job

CREATE OR REPLACE FUNCTION EMP_JOB(NAME VARCHAR2)
RETURN VARCHAR2
IS
    V_JOB EMP.JOB%TYPE;
BEGIN
    SELECT JOB
        INTO V_JOB
    FROM EMP
    WHERE ENAME = NAME;
    
    RETURN V_JOB;
END;
/

--강사님 버전
CREATE FUNCTION EMP_JOB(NO NUMBER)
RETURN VARCHAR2
IS
   V_JOB EMP.JOB%TYPE;
BEGIN
   SELECT JOB
      INTO V_JOB
   FROM EMP
   WHERE EMPNO = NO;
   
   RETURN V_JOB;
END;
/


SELECT EMP_JOB('SMITH') FROM DUAL;

--3.?특별 보너스를 지급 함수
--급여 200% 인상해서 지급(sal*2)
--함수명 : cal_bonus
DESC EMP;
SELECT * FROM EMP;

CREATE OR REPLACE FUNCTION CAL_BONUS(NO NUMBER)
RETURN NUMBER
IS 
    V_SAL EMP.SAL%TYPE;
BEGIN
    SELECT SAL*2
        INTO V_SAL
    FROM EMP
    WHERE EMPNO = NO;
    
    RETURN V_SAL;
END;
/

--강사님 버전
CREATE FUNCTION CAL_BONUS(NO NUMBER)
RETURN NUMBER
IS
   V_BONUS NUMBER;
BEGIN
   SELECT SAL*2
      INTO V_BONUS
   FROM EMP
   WHERE EMPNO=NO;
   
   RETURN V_BONUS;
END;
/

SELECT CAL_BONUS(7369) FROM DUAL;
SELECT * FROM EMP;

--4.?부서 번호를 입력 받아 최고 급여액을 반환하는 함수
--함수명 : s_max_sal
DESC EMP;
SELECT  * FROM EMP;

CREATE OR REPLACE FUNCTION S_MAX_SAL(NO NUMBER)
RETURN NUMBER
IS
    V_SAL EMP.SAL%TYPE;
BEGIN
    SELECT SAL
        INTO V_SAL
    FROM (SELECT SAL
            FROM EMP
            WHERE DEPTNO = NO
            ORDER BY SAL DESC)
    WHERE ROWNUM = 1;

    
    RETURN V_SAL;
END;
/
-- ROWNUM 버전
--CREATE OR REPLACE FUNCTION S_MAX_SAL(NO NUMBER)
--RETURN NUMBER
--IS
--    V_SAL EMP.SAL%TYPE;
--BEGIN
--    SELECT MAX(SAL)
--        INTO V_SAL
--    FROM EMP
--    WHERE DEPTNO = NO;
--    RETURN V_SAL;
--END;
--/

--강사님 버전
CREATE OR REPLACE FUNCTION S_MAX_SAL(S_DEPTNO EMP.DEPTNO%TYPE)
RETURN NUMBER
IS
   V_MAX NUMBER;
BEGIN
   SELECT MAX(SAL)
      INTO V_MAX
   FROM EMP
   WHERE DEPTNO = S_DEPTNO;
   
   RETURN V_MAX;
END;
/


SELECT S_MAX_SAL(10) FROM DUAL;

--5.?부서 번호를 입력 받아 부서 평균 급여를 구해주는 함수
--함수명 : avg_sal
CREATE OR REPLACE FUNCTION AVG_SAL(NO NUMBER)
RETURN NUMBER
IS
    V_SAL EMP.SAL%TYPE;
BEGIN
    SELECT AVG(SAL)
        INTO V_SAL
    FROM EMP
    WHERE DEPTNO = NO;
    RETURN V_SAL;
END;
/

--GROUP BY 버전... 이게 맞나?
CREATE OR REPLACE FUNCTION AVG_SAL(NO NUMBER)
RETURN NUMBER
IS
    V_SAL EMP.SAL%TYPE;
BEGIN
    SELECT AVG(SAL)
        INTO V_SAL
    FROM EMP
    WHERE DEPTNO = NO
    GROUP BY DEPTNO;
    
    RETURN V_SAL;
END;
/

--강사님 버전
CREATE OR REPLACE FUNCTION AVG_SAL(S_DEPTNO EMP.DEPTNO%TYPE)
RETURN NUMBER
IS
   V_AVG NUMBER;
BEGIN
   SELECT AVG(SAL)
      INTO V_AVG
   FROM EMP
   WHERE DEPTNO = S_DEPTNO;
   
   RETURN V_AVG;
END;
/


SELECT AVG_SAL(10) FROM DUAL;
--6.존재하는 함수 삭제 명령어
--drop function 함수명;


--7.함수 내용 검색
desc user_source;
select text from user_source where type='FUNCTION';

--8.dept에 새로운 데이터 저장 함수
--함수명 : insert_dept
--dup_val_on_index : exception 활용
/*
1. 필요 SQL : INSERT INTO DEPT VALUES(?, ?, ?);
2. 실행
    - 정상 실행
        삽입 완료
    - 비정상 오류
        - 컴파일 오류
        - PK중복 에러
            - 어떻게 처리?
                - 입력한대로 데이터 값 + 1;
                - MAX -> +1;
                
*/

--step01
CREATE OR REPLACE PROCEDURE INSERT_DEPT
(
V_DEPTNO DEPT.DEPTNO%TYPE,
V_DNAME DEPT.DNAME%TYPE,
V_LOC DEPT.LOC%TYPE
)
IS
BEGIN
    INSERT INTO DEPT VALUES (V_DEPTNO, V_DNAME, V_LOC);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        INSERT INTO DEPT VALUES(V_DEPTNO + 1, V_DNAME, V_LOC);
END;
/

SELECT *FROM DEPT;
EXECUTE INSERT_DEPT(40, 'SIAT', 'PANGYO');

--step02
--MAX 함수를 활용
--PROCEDURE
SELECT MAX(DEPTNO)
FROM DEPT;


CREATE OR REPLACE PROCEDURE INSERT_DEPT2
(
V_DEPTNO DEPT.DEPTNO%TYPE,
V_DNAME DEPT.DNAME%TYPE,
V_LOC DEPT.LOC%TYPE
)
IS
BEGIN
    INSERT INTO DEPT VALUES (V_DEPTNO, V_DNAME, V_LOC);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        INSERT INTO DEPT VALUES((SELECT MAX(DEPTNO) + 1
                                    FROM DEPT), V_DNAME, V_LOC);
END;
/

SELECT *FROM DEPT;
EXECUTE INSERT_DEPT2(40, 'SIAT', 'PANGYO');

--FUNCTION
DESC DEPT;

CREATE OR REPLACE FUNCTION MAX_INSERT_DEPT
(
V_DEPTNO DEPT.DEPTNO%TYPE,
V_DNAME DEPT.DNAME%TYPE,
V_LOC DEPT.LOC%TYPE
)
RETURN NUMBER
IS
BEGIN
    INSERT INTO DEPT VALUES (V_DEPTNO, V_DNAME, V_LOC);
    RETURN V_DEPTNO;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
        INSERT INTO DEPT VALUES(MAX(V_DEPTNO) + 1, V_DNAME, V_LOC);
        RETURN MAX(V_DEPTNO) + 1;
END;
/

-- 함수 강사님 버전
--STEP02
CREATE OR REPLACE FUNCTION INSERT_DEPT
(V_DEPTNO DEPT.DEPTNO%TYPE, 
 V_DNAME DEPT.DNAME%TYPE, 
 V_LOC DEPT.LOC%TYPE)
RETURN DEPT.DEPTNO%TYPE
IS
   PRAGMA AUTONOMOUS_TRANSACTION;
   V_TMP DEPT.DEPTNO%TYPE;
BEGIN
   BEGIN
      INSERT
         INTO DEPT VALUES(V_DEPTNO, V_DNAME, V_LOC);
         COMMIT;
         RETURN V_DEPTNO;
         EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
               SELECT MAX(DEPTNO)
                  INTO V_TMP
                  FROM DEPT;
               V_TMP := V_TMP + 10;
   END;
   BEGIN
      INSERT
         INTO DEPT VALUES(V_TMP, V_DNAME, V_LOC);
      COMMIT;
      RETURN V_TMP;
   END;
END;
/

SELECT INSERT_DEPT(60, 'A', 'B') FROM DUAL;
SELECT INSERT_DEPT(60, 'A', 'B') FROM DUAL;


SELECT MAX_INSERT_DEPT(40, 'SIAT', 'PANGYO') FROM DUAL;