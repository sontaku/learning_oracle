# PLSQL : 저장 함수



# Part 1 : 함수의 활용

#### 1.저장 함수(Function)  : 프로시저랑 함수랑차이점 프로시저는 리턴타입이 없고 함수는 리턴타입이 있다.
	-오라클 사용자 정의 함수 



#### 문법 :

```mariadb
	create function 함수명
	return 리턴타입
	is
	begin
	end;
	/
```



#### 주의 : 기존 함수명들과 중복 불가

```mariadb
'절대 기존 함수명들과 중복 불가'
```



#### 함수의 종류 :

```mariadb
함수 종류 : '내장 함수' & '사용자 정의 함수'
```



#### 프로시저와의 차이점 : 프로시저 = 리턴 X || 함수 =  리턴 OK

```mariadb
-선언구
-리턴 타입 선언 + 리턴 값
-return 키워드 활용
```





#### 저장 함수 활용 1 : 리턴할 변수의 데이터 출력

```mariadb
CREATE OR REPLACE FUNCTION USER_FUNC(NO NUMBER) -- 임으로 지정
RETURN VARCHAR2
IS
    V_ENAME EMP.ENAME%TYPE;
BEGIN
    SELECT ENAME
        INTO V_ENAME
    FROM EMP
    WHERE EMPNO = NO;   -- 반환받은 변수 타입을 지정 (NO NUMBER)
    
    RETURN V_ENAME;     -- 리턴 할 변수명 => V_ENAME; 변수를 리턴하기 때문에 
END;					-- USER_FUNC(7369)를 활용하여 참조된 프라이머리키인 ENAME 컬럼의 데이터값을 리턴(출력)함  
/

SELECT USER_FUNC(7369) FROM EMP;  -- 모든 행의 결과로 출력 (EMP = 12개)
SELECT USER_FUNC(7369) FROM DUAL; -- 과를 확인을 할수만 있다.
```



#### 저장함수 활용 2 :  1번과 똑같이 리턴할 컬럼의 데이터 출력

```mariadb
CREATE OR REPLACE FUNCTION emp_job(NO NUMBER)
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
SELECT emp_job(7369) FROM EMP;
SELECT emp_job(7369) FROM DUAL;
```



#### 저장함수 활용 3 :  WHERE문에서 새로운 조건을 제시

```mariadb
CREATE OR REPLACE FUNCTION CAL_BONUS(NO NUMBER)
RETURN NUMBER
IS
    V_SAL EMP.SAL%TYPE;
BEGIN
    SELECT SAL
        INTO V_SAL
    FROM EMP
    WHERE EMPNO = NO;
    V_SAL := V_SAL *2;   -- 여기서 조건을 건다 => 리턴할 데이터의 값을 조건을 걸어서 리턴(출력)을 한다.
    RETURN V_SAL;
END;
/
SELECT CAL_BONUS(7369) FROM DUAL;
```



#### 저장함수의 활용 4 : MAX와 MIN을 사용 

```mariadb
CREATE OR REPLACE FUNCTION S_MAX_SAL(S_DEPTNO EMP.DEPTNO%TYPE)
RETURN NUMBER
IS
   V_MAX NUMBER;
BEGIN
   SELECT MAX(SAL)
      INTO V_MAX
   FROM EMP
   WHERE DEPTNO = S_DEPTNO; -- 전역 변수를 활용해서 DEPTNO의 값으로 조건을 걸겠다.
   
   RETURN V_MAX;
END;
/
SELECT S_MAX_SAL(10) FROM DUAL; -- 함수를 사용한 쿼리. DEPTNO = 10번인 중에서 제일 급여가 높은 데이터 출력
DROP FUNCTION S_MAX_SAL;

-- 위 SELECT 문을 함수를 사용하지 않고 SELECT문으로 풀었을때 밑에 있는 SELECT문으로 가능
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 10; --함수를 사용하지 않은 쿼리.
```



#### 저장함수 활용 5 : avg 평균값을 구하는 함수

```mariadb
CREATE OR REPLACE FUNCTION AVG_SAL(S_DEPTNO EMP.DEPTNO%TYPE)
RETURN NUMBER
IS
   V_AVG NUMBER;
BEGIN
   SELECT AVG(SAL)			-- 평균을 구하는 avg()
      INTO V_AVG
   FROM EMP
   WHERE DEPTNO = S_DEPTNO;
   
   RETURN V_AVG;			-- 리턴값 출력
END;
/

SELECT AVG_SAL(10) FROM DUAL;					-- 밑에 문장과 동일
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 10;		-- 위에 문장과 동일
```



#### 함수 삭제 명령어 

```mariadb
drop function 함수명;
DROP FUNCTION USER_FUNC;
```



#### 함수 내용 검색

```mariadb
desc user_source;
select text from user_source where type='FUNCTION'; -- 현재 내가 사용중인 함수 내용 검색
```





# Part 2 : DEPT에 새로운 데이터 저장 함수

#### 함수명 : insert_dept

#### 1.필요 SQL : INSERT INTO DEPT VALUES(? , ? , ?)
#### 2.실행

   - 정상 실행
     삽입 완료
        - 비정상 실행
     - 컴파일 오류
     - PK중복 에러
       -어떻게 처리 할건가?
           -입력한대로 데이터 값 + 1;
           -MAX -> +1;



#### 예제 ) 미리 정의된 예외 종류 중 한개인 :  DUP_VAL_ON_INDEX (중복데이터 삽입시 오류 발생)

```mariadb
DROP TABLE DEPT01;
CREATE TABLE DEPT01 AS SELECT * FROM DEPT; -- DEPT 원본 테이블을 손상시키면 안되서 새로 DEPT테이블 하나 만듬
CREATE OR REPLACE PROCEDURE INSERT_DEPT(
V_DEPTNO DEPT.DEPTNO%TYPE,
V_DNAME DEPT.DNAME%TYPE,
V_LOC DEPT.LOC%TYPE)
IS -- 의미는 없고 문법상 쓰는것
BEGIN
    INSERT INTO DEPT01 VALUES(V_DEPTNO, V_DNAME, V_LOC); -- DEPT01 테이블의 데이터를 삽입
    EXCEPTION	-- 예외처리
    			-- DUP_VAL_ON_INDEX : UNIQUE 제약을 갖는 컬럼에 중복되는 데이터가 INSERT 될 때
        WHEN dup_val_on_index THEN -- 예외처리문 WHEN THEN
            INSERT INTO DEPT01 VALUES(V_DEPTNO+1, V_DNAME, V_LOC); -- 아 여기서 중복삽입이 되는구나
END;			-- 만약 예외처리를 하지않았다면 컴파일이되지 않고 오류가 났다.
/

CREATE TABLE DEPT01 AS SELECT * FROM DEPT01;
SELECT * FROM DEPT01;
DROP TABLE DEPT01;
```



### 마지막 강사님 문제 :

```mariadb
DROP PROCEDURE INSERT_DEPT;
DROP FUNCTION INSERT_DEPT;
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

DELETE FROM DEPT WHERE DEPTNO NOT IN (10, 20, 30, 40);
COMMIT;
SELECT * FROM DEPT;
```

