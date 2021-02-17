--14.index.sql
/*
1.빠른 검색을 위한 색인 기능
    -PK는 기본적으로 자동 INDEX로 설정 되어있음

2.실행 속도 체크 옵션
SET TIMING ON
SET TIMING OFF

3.index
오라클 DB 자체의 객체로서 명령문 검색을 할 때 속도 처리를 향상시키는 개체

4.주의사항



*/

--1.index test table 생성
DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
SELECT * FROM EMP01;

--2.테스트를 위한 데이터값을 복사 붙여넣기
INSERT INTO EMP01 SELECT * FROM EMP01;

SELECT * FROM EMP01 WHERE ENAME = 'SMITH';

--3.emp01 table에 index 적용
CREATE INDEX IDX_EMP01_EMPNO ON EMP01(EMPNO);

--4.SMITH 사번 검색
SELECT * FROM EMP01 WHERE EMPNO = 7369;

--5.index 삭제
DROP INDEX IDX_EMP01_EMPNO;
DROP TABLE EMP01;


SELECT *
FROM ALL_IND_COLUMNS
WHERE TABLE_NAME = 'EMP'; 
-- 어떤 컬럼을 인덱스로 지정하였는지에 주의하여야 한다.
-- 인덱스는 빠르게 검색할 수 있게 해주는 객체이다.

SET TIMING ON;
SET TIMING OFF;