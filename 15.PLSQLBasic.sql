--15.PLSQLBasic.sql
--https://docs.oracle.com/cd/E11882_01/timesten.112/e21639/intro.htm#TTPLS110
/* 
1.PL/SQL(Procedural Language extension to SQL) - 
	-avg() / count() .. 처럼 사용자 정의 함수를 개발하는 기술

	-개발 방식
        - 이름없이 개발 : 익명
		- '프로시저' 라는 타이틀로 개발 - 이름(재사용)
        - 함수라는 타이틀 개발 - 이름(재사용)
        
2.장점
    - 여러번 사용 또는 다수의 SQL 문장을 하나로 처리
    - DB 자체 언어로 컴파일(컴파일을 통해 실행속도 향상)
    - 예시
        회원가입 -> 활동 -> 탈퇴
        그러면 이때 탈퇴한 회원 정보는 어떻게 관리?
        경우의 수 1 : DB에서 완벽하게 삭제
        경우의 수 2 : 백업 테이블에 보관 -- PL/SQL로 고객 데이터를 삭제시 자동으로 백업 테이블에 저장하는 기능

3.필수 세팅
	-SET SERVEROUTPUT ON
	
4.필수 암기 
	- 할당 (대입)연산자 :=
    - 문법 (선언, 시작, 끝)
        DECLARE
        BEGIN
        END;
        /
	
5.에러메세지 확인하기
	- SHOW ERRORS;
    
*/
--1.실행 결과 확인을 위한 필수 설정 명령어
SET SERVEROUTPUT ON

--2.연산을 통한 문법 학습
--step01
DECLARE
    NO NUMBER; -- 프로시저내에서 사용되는 넘버
BEGIN
    NO := 10; -- 위에 선언한 변수에 할당할 값
    dbms_output.put_line(NO);
END;
/ -- 슬래쉬가 있어야 프로시저로 인식한다.
--step02	
DECLARE
    NO NUMBER;
BEGIN
    NO := 10;
    NO := NO / 2;
    dbms_output.put_line(NO);
END;
/
--step03
DECLARE
    NO NUMBER;
BEGIN
    NO := 10;
    NO := NO / 0;
    dbms_output.put_line('결과1' || NO);
    dbms_output.put_line('결과2');
    dbms_output.put_line('결과3');
    
END;
/

--step04
DECLARE
    NO NUMBER;
BEGIN
    BEGIN
        NO := 10;
        NO := NO / 0;
        dbms_output.put_line('결과1' || NO);
        EXCEPTION
            WHEN OTHERS THEN dbms_output.put_line('예외처리 성공');
    END;
    BEGIN
    dbms_output.put_line('결과2');
    dbms_output.put_line('결과3');
    END;
END;
/

--3.?연산을 통한 간단한 문법 습득 + 예외 처리


--4.중첩 block
/*
    중첩 블록 내부에서 선언된 변수 : 로컬 변수 - 선언된 BEGIN 구문 안에서만 사용 가능
*/
DECLARE
    V_GLOBAL VARCHAR2(10) := 'GLOBAL';
BEGIN
    DECLARE
        V_LOCAL VARCHAR2(10) := 'LOCAL';
    BEGIN
        dbms_output.put_line('G -' || V_GLOBAL);
        dbms_output.put_line('L -' || V_LOCAL);
    END;
        dbms_output.put_line('G2 -' || V_GLOBAL);
        --dbms_output.put_line('L2 -' || V_LOCAL);
END;
/

--5.emp01 table 컬럼 활용 %type 학습
DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
-- 사번으로 사원번호, 이름, 급여 검색 -> 출력
--SELECT EMPNO, ENAME, SAL FROM EMP01 WHERE EMPNO = 번호;
--선언구 -> 변수 3개
--BEGIN : SELECT 
--선언된 변수에 할당 -> 출력 -> 종료

DECLARE
    V_EMPNO emp01.empno%TYPE; -- E_EMPNO의 타입은 EMPNO가 된다
    V_ENAME EMP01.ename%TYPE;
    V_SAL EMP01.SAL%TYPE;
BEGIN
    SELECT EMPNO, ENAME, SAL
        INTO V_EMPNO, V_ENAME, V_SAL -- 할당
    FROM EMP01
    WHERE EMPNO = 7369;
    
    DBMS_OUTPUT.PUT_LINE(V_EMPNO || ' ' || V_ENAME || ' ' || V_SAL); --문자열의 CONCAT -> ||
END;
/


--5.emp01 table 컬럼 활용 %type 학습

DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
-- 사번으로 사원번호, 이름, 급여 검색 -> 출력 
-- SELECT EMPNO, ENAME, SAL FROM EMP01 WHERE EMPNO = 번호;
-- 선언구 -> 변수3개 -> BEGIN : SELECT -> 선언된 변수에 할당 -> 출력 -> 종료

DECLARE
    V_EMPNO EMP01.EMPNO%TYPE; -- EMP01의 EMPNO의 타입을 그대로 가져오겠다는 의미로 뒤에 %TYPE가 꼭 붙어야 함
    V_ENAME EMP01.ENAME%TYPE;
    V_SAL EMP01.SAL%TYPE;
BEGIN
    SELECT EMPNO, ENAME, SAL
        INTO V_EMPNO, V_ENAME, V_SAL -- 가져온 변수를 할당하기
    FROM EMP01
    WHERE EMPNO = 7369;
    
    DBMS_OUTPUT.PUT_LINE( V_EMPNO ||' '|| V_ENAME ||' '|| V_SAL );
END;
/

--6.이미 존재하는 table record의 모든 컬럼 활용 : %rowtype
--7369
DECLARE 
    V_ROWS EMP01%ROWTYPE; -- 하나의 행이 타입이 됨
BEGIN
    SELECT * INTO V_ROWS 
    FROM EMP01
    WHERE EMPNO = 7369;
    
    DBMS_OUTPUT.PUT_LINE(V_ROWS.ENAME);
END;
/

--7.?
--emp05 table을 데이터 없이 emp table로 부터 생성
--%rowtype을 사용, emp의 사번이 7369인 사원 정보를 emp05 table에 저장하기
--힌트 : begin 영역에 다수의 sql 문장 사용 가능

DROP TABLE EMP05;
CREATE TABLE EMP05 AS SELECT * FROM EMP WHERE 1 = 0;

-- 확인
SELECT * FROM EMP05;

-- 변수 일일이 다 지정해서 넣기
DECLARE
    V_ROWS EMP01%ROWTYPE;
BEGIN
    SELECT * INTO V_ROWS
    FROM EMP
    WHERE EMPNO = 7369;
    INSERT INTO EMP05 VALUES(V_ROWS.EMPNO, V_ROWS.ENAME, V_ROWS.JOB, V_ROWS.MGR, V_ROWS.HIREDATE, V_ROWS.SAL, V_ROWS.COMM, V_ROWS.DEPTNO);
END;
/

-- 한번에 넣기
DECLARE
    V_ROWS EMP01%ROWTYPE;
BEGIN
    SELECT * INTO V_ROWS
    FROM EMP
    WHERE EMPNO = 7369;
    INSERT INTO EMP05 VALUES V_ROWS;
END;
/

SELECT * FROM EMP05;

-- 강사님 강의안
DROP TABLE EMP05;
CREATE TABLE EMP05 AS SELECT * FROM EMP WHERE 1=0;

DECLARE
    V_ROWS EMP05%ROWTYPE;
BEGIN
    SELECT * 
        INTO V_ROWS
    FROM EMP01 
    WHERE EMPNO = 7369;
    
    INSERT INTO EMP05 VALUES V_ROWS;
    COMMIT;
END;
/

--8.조건식
/*  
1. 단일 조건식
	if(조건) then
		조건이 true인 경우 실행되는 블록
	end if;

2. 다중 조건
	if(조건1) then
		조건1이 true인 경우 실행되는 블록 
	elsif(조건2) then
		조건2가 true인 경우 실행되는 블록
	end if;  
*/


--emp01	
--사원(SMITH)의 연봉을 계산 PL/SQL 개발[comm이 null인 직원들은 0으로 변경]
--step 01

DECLARE
    V_EMP01 EMP%ROWTYPE;
    TOTAL_SAL NUMBER(7, 2);
BEGIN
    SELECT EMPNO,ENAME, SAL, COMM
        INTO V_EMP01.EMPNO, V_EMP01.ENAME, V_EMP01.SAL, V_EMP01.COMM
    FROM EMP01
    WHERE ENAME = 'SMITH';

    IF(V_EMP01.COMM IS NULL) THEN
        V_EMP01.COMM := 0;
    END IF;
    
    TOTAL_SAL := V_EMP01.SAL * 12 + V_EMP01.COMM;
    DBMS_OUTPUT.PUT_LINE(TOTAL_SAL);
END;
/

--step 02
SELECT *
FROM EMP01
WHERE EMPNO = &V;

SELECT * FROM EMP;


--9.?가변 데이터 적용해 보기
--emp table의 empno 입력시 해당하는 (v_empno || '의 부서명은 ' || v_dname) 출력
--deptno=10 : ACCOUNTING 출력, deptno=20 : RESEARCH 출력, 그 외는 알아서 생각해보기

SELECT * FROM TAB;
SELECT * FROM EMP;
SELECT * FROM DEPT;


DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;

DROP TABLE EMP06;
CREATE TABLE EMP06 AS SELECT * FROM EMP WHERE 1=0;
SELECT * FROM EMP06;

DECLARE
    V_EMP06 EMP01%ROWTYPE;
BEGIN
    SELECT E.EMPNO, D.DNAME
        INTO V_EMP06.EMPNO, V_EMP06.DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND E.EMPNO = &V;
    
    DBMS_OUTPUT.PUT_LINE(V_EMPNO || '의 부서명은 ' || V_DNAME);
END;
/


DECLARE
    V_EMP06 EMP01%ROWTYPE;
    V_EMPNO EMP01.EMPNO%TYPE;
    V_DNAME VARCHAR2(16);
BEGIN
    SELECT EMPNO, DEPTNO
        INTO V_EMP06.EMPNO, V_EMP06.DEPTNO
    FROM EMP
    WHERE EMPNO = &V;
    
    IF(V_EMP06.DEPTNO = 10) THEN 
        V_DNAME := 'ACCOUNTING';
    ELSIF(V_EMP06.DEPTNO = 20) THEN 
        V_DNAME := 'RESEARCH';
    END IF;
    
    V_EMPNO := V_EMP06.EMPNO;
    DBMS_OUTPUT.PUT_LINE(V_EMPNO || '의 부서명은 ' || V_DNAME);
END;
/

--강사님 버전
SET SERVEROUTPUT ON


DECLARE
    V_EMPNO EMP.EMPNO%TYPE;
    V_DEPTNO EMP.DEPTNO%TYPE;
    V_DNAME VARCHAR2(10);
BEGIN
    SELECT EMPNO, DEPTNO
        INTO V_EMPNO, V_DEPTNO
    FROM EMP
    WHERE EMPNO = &V;
    
    IF(V_DEPTNO = 10) THEN
        V_DNAME := 'ACCOUNTING';
    ELSIF(V_DEPTNO = 20) THEN
        V_DNAME := 'RESEARCH';
    ELSE
        V_DNAME := 'NONE';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_EMPNO || '의 부서명은 ' || V_DNAME);
END;
/


--10.반복문
/* 
1.기본 문법
loop 
	ps/sql 문장들
	exit 조건;
end loop;

2.while 문법
 while 조건식 loop
 	plsql 문장;
 end loop;

3.for 문법
for 변수 in [reverse] start ..end loop
	plsql문장
end loop;
*/


--1~5까지 출력
--loop 

--루프문안에서 변수를 할당해 줄 수 없어, 디클래어 비긴 사이에 해줘야 한다.
DECLARE
    NUM NUMBER(2) := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM := NUM + 1;
        EXIT WHEN NUM > 5;
    END LOOP;
END LOOP;
/

--while
DECLARE
    NUM NUMBER(2) := 1;
BEGIN
    WHILE NUM <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM := NUM + 1;
    END LOOP;
END LOOP;
/

--for (가장 많이 활용함)
DECLARE
BEGIN
    FOR NUM IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
    END LOOP;
END LOOP;
/
--11.?사번 입력시 해당하는 사원의 이름 음절 수 만큼 *로 표현하기 
--length() / 결합 연산자 : ||
/*
--참고
7369	SMITH
7499	ALLEN
7521	WARD
7566	JONES
7654	MARTIN
7698	BLAKE
7782	CLARK
7839	KING
7844	TURNER
7900	JAMES
7902	FORD
7934	MILLER

--예상 결과
SMITH님의 이름 길이 수는 *****
*/

--DECLARE
--    NUM NUMBER(2) := 1;
--BEGIN
--    WHILE NUM <= 5 LOOP
--        DBMS_OUTPUT.PUT_LINE(NUM);
--        NUM := NUM + 1;
--    END LOOP;
--END LOOP;

DECLARE
BEGIN
    FOR VAR IN 1..5 LOOP
             DBMS_OUTPUT.PUT_LINE('*');            
    END LOOP;
END LOOP;
/

DECLARE
    V_EMPNO EMP.EMPNO%TYPE;
    V_ENAME EMP.ENAME%TYPE;
BEGIN
    SELECT EMPNO, ENAME
        INTO V_EMPNO, V_ENAME
    FROM EMP
    WHERE EMPNO = &V;

    DBMS_OUTPUT.PUT(V_ENAME || '님의 이름 길이 수는 ');
    FOR VAR IN 1..LENGTH(V_ENAME) LOOP
        dbms_output.put('*');
    END LOOP;
    dbms_output.NEW_line;
END;
/

--강사님 버전
DECLARE
    V_EMPNO EMP.EMPNO%TYPE := &NO;
    V_ENAME EMP.ENAME%TYPE;
    V_NUMBER NUMBER;
    V_CHAR VARCHAR2(10);
BEGIN
    SELECT ENAME, LENGTH(ENAME)
        INTO V_ENAME, V_NUMBER
    FROM EMP
    WHERE EMPNO = V_EMPNO;

    FOR I IN 1..V_NUMBER LOOP
        V_CHAR := V_CHAR || '*';
    END LOOP;
    dbms_output.put_line(V_ENAME || '님의 이름 길이 수는 ' || V_CHAR);
END LOOP;
/

