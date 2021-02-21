# 뷰 : View 

### Part 1 : View의 사용이유와 생성 방법

#### View를 사용하는 이유 :

가령, emp table 에서 **comm 존재자체를 다른 직군들에게 모르게 해야 할 경우**
과연 table의 데이터를 어떻게 활용 가능하게 할 것인가?

***모든 사람이 select로 다 볼 수 있다면, 보안에 문제가 생길 수 있다**.
추가적인 커미션을 다른 사람들이 확인할 수 없게 하려면, 테이블 구성을 달리 해야한다.

실제 존재 하는 table 기반으로 가상의 논리적인 table  이게 정의



**필요 :**
	**특정 컬럼 은닉, 다수 table 조인된 결과의 새로운 테이블 자체를 가상으로 db내에 생성**



**view 사용을 위한 필수 선행 설정**

    1. **ADMIN 계정 접속**
        2. **관리자에서 VIEW 생성 권한 부여**
        **Run SQL Commandline 에서 작성***

![image-20210220225433005](C:\Users\user\AppData\Roaming\Typora\typora-user-images\image-20210220225433005.png)

**이미지를 첨부했지만 혹시 몰라서 Command 정의**

    > CONNECT SYSTEM/manager
    > GRANT CREATE VIEW TO SCOTT;
    > CONNECT SCOTT/TIGER;


### View의 정의

  1. 물리적으로는 존재하지 않되, 논리적으로 존재함. 
  2. 물리적(CREATE TABLE)  
  3. **논리적(가상 TABLE, CREATE를 사용하지 않음)**
    **=> 이중쿼리를 사용할때 테이블을 가지고 오는게 아닌 그 테이블의 데이터의 값을 가지고오는 존재 (인라인뷰도 포함)**
  4. TEST

- VIEW 생성
- CRUD QUERY
- VIEW의 영향에 대해 알아볼 필요가 있다.

  5.계속 계속 조인하려면 시간이 많이 걸려서 VIEW로 만든다.



#### View : 문법 
	Create와 Drop : Create View/Drop View
	CRUD는 Table과 동일 

#### View 생성 예제 )

``` D
//1.test table생성
DROP TABLE DEPT01 CASCADE CONSTRAINTS;
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;

//뷰 생성 권한획득을 해야함 (CMD 에서 커맨드 작성)

//2.dept01 table상의 view를 생성 => View를 생성하기 전 생성할 View의 Table이 존재해야 View를 생성할수 있다. 
CREATE VIEW DEPT01_V AS SELECT * FROM DEPT01;
DROP VIEW DEPT01_V;
```



# Part2 : View Update하기 (변화 살펴보기)

## 주의할점 : ★★★★★

#### View 생성하고 Update할시 원본 테이블도 함께 Update가 되기 때문에 

#### 반드시 Table도 새로 하나 만들어서 View를 만드는것이 안전하다.

#### 따라서 뷰 내에서 CRUD하면 원본테이블에도 영향 가기에, SELECT만 쓰도록 하자!

#### 예제 )

```D
DROP TABLE DEPT01;			
DROP VIEW DEPT01_V;			

CREATE TABLE DEPT01 AS SELECT * FROM DEPT;       //View를 생성하기 전 Update를 하면 원본 테이블도 바뀌기 때문에 새로 테이블을 하나 만든다.
CREATE VIEW DEPT01_V AS SELECT * FROM DEPT01; 	 //DEPT01을 참조해서 만든 DEPT01_V , View 생성

SELECT * FROM DEPT01;
SELECT * FROM DEPT01_V;

UPDATE DEPT01_V SET LOC = 'NEW YORK';					//View Update
UPDATE DEPT01_V SET LOC = 'SEOUL' WHERE DEPTNO = 50;	//View Update 하려하지만 DEPTNO = 50인 데이터가 없어서 업데이트 0행 변경이됨
ROLLBACK; //데이터 롤백
//CRUD 는 전부다 롤백이 가능 C = CREATE , R = READ => SELECT , U = Update , D = Delete
//Create는 롤백을 하지못한다 
Drop Table DEPT01;
Drop View DEPT01_V;
```



#### Update 문법 :

```D
UPDATE '테이블 명' SET '변경할 컬럼' = 변경할 데이터 값;
UPDATE 'View 명' SET '변경할 컬럼' = 변경할 데이터 값;
```



