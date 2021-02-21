# 제약조건 : CONSTRAINTS



# Part 1 : 제약조건의 Key의 종류

#### 제약조건의 종류 :

 **PK[primary key] - 기본키, 중복불가, null불가, 데이터들 구분을 위한 핵심 데이터**
			**: not null + unique**
	**not null - 반드시 데이터 존재**
	**unique - 중복 불가** 
	**check - table 생성시 규정한 범위의 데이터만 저장 가능** 
	**default - insert시에 특별한 데이터 미저장시에도 자동 저장되는 기본 값**
	**FK[foreign key]** 



#### DB 제약 사항 설정

#### 제약사항

#### DEPT의 DEPTNO

#### 	unique Key = 중복된 값을 넣을수가 없다 넣을 시 오류가 뜸 

#### 예제 )

```D
DROP TABLE EMP02;
CREATE TABLE EMP02 (
    EMPNO NUMBER(4) UNIQUE, //EMPNO에 중복된 값이 없다는걸 말해주기 위해 UNIQUE를 사용 중복된값이 있을시 오류
    ENAME VARCHAR2(10)
);

INSERT INTO EMP02 VALUES(1, 'TESTER');      //EMPNO = 1값 , ENAME = TESTER로 값을 집어넣었고
INSERT INTO EMP02 (ENAME) VALUES('TESTER'); //EMPNO는 지정하지 않았으니 NULL , ENAME = TESTER로 지정 
--INSERT INTO EMP02 VALUES (1, 'TESTER2');  //추가가 되지않는 이유는 EMP02테이블을 생성할때
                                            //--EMPNO에 UNIQUE 제약을 걸어 두었기 때문에 UNIQUE(고유)
```



#### DEPT의 DEPTNO

#### 	not null = NULL을 사용시 오류

#### 예제 )

```D
DROP TABLE EMP02;  --EMP02 테이블이 있는지 없는지 확인
CREATE TABLE EMP02 (
    EMPNO NUMBER(4) CONSTRAINT EMP02_EMPNO_NN NOT NULL,   //EMPNO를 NUMBER타입으로 제약조건은 NULL값이 없어야한다.
    ENAME VARCHAR2(10)
);
SELECT * FROM EMP02;
INSERT INTO EMP02 VALUES(1,'TEST');
INSERT INTO EMP02 VALUES(0,'TEST');
INSERT INTO EMP02 VALUES(NULL,'TEST'); //오류 : cannot insert NULL into ("SCOTT"."EMP02"."EMPNO")
DROP TABLE EMP02;
```



#### DEPT의 DEPTNO

#### 	primary Key(기본키 , PK) = primary key(기본키, pk) : 중복된값과 NULL값을 사용할수가없게 

#### 예제 )

``` D
DROP TABLE EMP02;
CREATE TABLE EMP02(
    EMPNO NUMBER(4) CONSTRATINT EMP02_PK PRIMARY KEY, //EMPNO라는것은 프라이머리키 선언 EMPNO = 중복 불가 , NULL값 안됨 , 고유키
    ENAME VARCHAR2(10)	
);
SELECT * FROM EMP02;      
INSERT INTO EMP02 VALUES(1, 'TESTER');  //첫번째 INSERT INTO 에서 EMPNO = 1 , ENAME = 'TESTER' 첫번째는 고유 데이터라 삽입 가능  
INSERT INTO EMP02 VALUES(1, 'TESTER'); 	//두번째 INSERT INTO 에서 EMPNO에서 똑같은 값인 1 이들어가기 때문에 EMPNO는 PK라 에러가 뜸 
SELECT * FROM EMP02;
```



#### 참조 키 FK = FOREIGN = 외래키 => 고유 데이터를 가져오는 (프라이머리 키)

#### 	참조 키 설정시, 다른 테이블에 먼저 프리이머리키가 선언되어야 가능하다.

#### 예제 )

```D
CREATE TABLE EMP02 (
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10) NOT NULL,
    DEPTNO NUMBER(4) CONSTRAINT EMP02_DEPTNO_FK REFERENCES DEPT(DEPTNO) 
    //EMP02테이블에 있는 DEPTNO를 FK를 사용해서 DEPT에 있는 DEPTNO를 참조해서 데이터를 갖고온다
    //FK는 참조된 테이블 컬럼의 데이터만 가져올수있다. 
    //데이터 중복이 가능하고 , NULL값인 데이터도 삽입할수 있다.
    //하지만 참조된 컬럼의 데이터만 사용할수있고 다른 데이터는 제약이 걸린다.
);
```



#### Check - Table 생성시 규정한 범위의 데이터만 저장 가능

####  예제 )

```D
DROP TABLE EMP01;
CREATE TABLE EMP01(
    NAME VARCHAR2(10),
    GENDER CHAR(1) CONSTRAINT EMP01_GENDER CHECK(GENDER IN('M','F')) //CHECK, IN으로 저장한 데이터만 사용할수있게 해준다. 제약조건
);
INSERT INTO EMP01 VALUES('TEST1','M');
INSERT INTO EMP01 VALUES('TEST2','D');  -- CHECK조건에 맞지 않아서 오류가 발생
INSERT INTO EMP01 VALUES('TEST3','F');
SELECT * FROM EMP01;
```



#### default - insert시에 특별한 데이터 미저장시에도 자동 저장되는 기본 값 

#### 예제 )

``` D
DROP TABLE EMP01;
CREATE TABLE EMP01(
    ID VARCHAR2(10) PRIMARY KEY,
    GENDER CHAR(1) DEFAULT 'F'  
);
INSERT INTO EMP01 (ID) VALUES ('SIAT');
INSERT INTO EMP01 (ID) VALUES ('SIAT', 'M');  //M은 안들어감,GENDER의 타입을 DEFAULT로 기본값으로  F값으로 했기 때문에
SELECT * FROM EMP01; //출력은 'SIAT','F'가 출력이 된다.
Drop Table EMP01;
```





# Part2 : 이미 존재하는 table의 제약조건 수정(추가, 삭제)명령어



#### 제약조건 추가

####       alter table 테이블명 add constraint 제약조건명 제약조건(컬럼명);  

#### 예제 )

``` D
Drop TABLE DEPT01;
CREATE TABLE DEPT01(
    DATA1 NUMBER(10)CONSTRAINT DEPT01_DEPTNO_UK unique,
    DATA2 NUMBER(10)
);
ALTER TABLE DEPT01 ADD CONSTRAINT DEPT01_DATA2_PK PRIMARY KEY(DATA2);
INSERT INTO DEPT01 VALUES(1,2);
INSERT INTO DEPT01 VALUES(2,2);         //여기서 2번째 데이터인 DATA2에 PK로 변수를 지정해줘서 중복된값이 있어서 오류가 발생
INSERT INTO DEPT01 VALUES(3,NULL);		//여기서 2번째 데이터인 DATA2에 PK로 변수를 지정해줘서 NULL값이 있어서 오류가 발생
SELECT * FROM DEPT01;
Drop TABLE DEPT01;
```



#### 제약조건 삭제(Drop) 

#### 	Table 삭제 

#### 	alter table 테이블 명 CASCADE CONSTRAINT

#### 만약에 DEPT01 에 참조된 FK Key가 있다면 그 어떤 테이블은 삭제가 불가능하다. Drop Table DEPT01; 이 안된다. 

#### 삭제를 하려면 DROP TABLE DEPT01 CASCADE CONSTRAINT;를 해줘야 삭제를 할수 있다.

#### 예제 )

``` D
DROP TABLE DEPT01 CASCADE CONSTRAINT;  // 제약을 무시하고 삭제해버리는 CASCADE
                                       // CASCADE CONSTRAINT = 제약을 무시
```





# Part3 : 제약조건 임시 비활성화 or 활성화



#### 제약조건 임시 비활성화

		alter table 테이블명 disable constraint 제약조건명;



#### 제약조건 활성화
		alter table 테이블명 enable constraint 제약조건명;