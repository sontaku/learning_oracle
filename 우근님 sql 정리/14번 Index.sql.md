# Index.sql



#### 빠른 검색을 위한 색인 기능

#### 	1.) 데이터에서 빠른 검색을 하기위한 Index가 존재한다.  

#### 	2.) 프라이머리키는 자동으로 인덱스가 설정 

#### 	3.) PK는 기본적으로 자동 INDEX로 설정 되어있음



#### 실행 속도 체크 옵션

**SET TIMING ON   => 얼마만큼 시킨이 걸렸는지 체크 (CMD)에서 확인 가능**



### 검색하는데 걸린 시간을 알려주는 SET TIMING ON

```D
SET TIMING ON  //이 문구를 실행시키면 생성 , 검색 , 출력 , 삭제할때 걸린 시간을 출력해준다.
```



### index test table 생성

```D
DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
SELECT * FROM EMP01; 
```



### 테스트를 위한 데이터값을 복사 붙여넣기

```D
INSERT INTO EMP01 SELECT * FROM EMP01;
SELECT * FROM EMP01 WHERE ENAME ='SMITH';
```



### 테스트를 위한 데이터값을 복사 붙여넣기

```D
INSERT INTO EMP01 SELECT * FROM EMP01;
SELECT * FROM EMP01 WHERE ENAME ='SMITH';
```



### emp01 table에 index 적용

```D
CREATE INDEX IDX_EMP01_EMPNO ON EMP01(EMPNO);  -- ON EMP01 테이블에 EMPNO에 INDEX 생성
SELECT * FROM EMP01;
DROP INDEX IDX_EMP01_EMPNO;
```

