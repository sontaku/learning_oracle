--18.PLSQLCursor.sql
/* 
1.커서(Cursor)
	-여러 개의 행을 처리
			
2.문법
DECLARE
CURSOR <CURSOR_NAME> IS <SELECT STATEMENT>;
BEGIN
	FOR 변수 IN  <CURSOR_NAME> LOOP 
		PLSQL 실행
	END LOOP;  
END;
/
*/


--CURSOR FOR
--1.EMP TABLE 사번, 이름 검색
-- 아래 EMP_CURSOR에는 하나의 객체가 아닌
-- EMPNO, ENAME 값을 '여러 개' 갖고 있는 형태 이다.
DECLARE
	CURSOR EMP_CURSOR IS SELECT EMPNO, ENAME FROM EMP;
BEGIN
	FOR EMP_DATA  IN EMP_CURSOR LOOP
		DBMS_OUTPUT.PUT_LINE(EMP_DATA.EMPNO || ' ' || EMP_DATA.ENAME);
	END LOOP;
END;
/

--2.?DEPT의 모든 지역정보 검색
DECLARE
	CURSOR DEPT_CURSOR 
	IS 
	SELECT LOC FROM DEPT; 	
BEGIN
	FOR V_LOC IN DEPT_CURSOR LOOP	
		DBMS_OUTPUT.PUT_LINE('X ' || V_LOC.LOC);		
	END LOOP;	
END;
/	

--3.?부서 번호에 해당하는 사번, 사원명 검색
--프로시저명 : EMP_INFO


EXEC EMP_INFO(10)
EXEC EMP_INFO(20)
