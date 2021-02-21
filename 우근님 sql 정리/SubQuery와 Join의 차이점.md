# SubQuery의 종류와  Join과의 차이점



### 1 ) 서브 쿼리의 종류 :



#### 첫번째 : 인라인 뷰 : 프롬절에서 SELECT ,  ORDER BY를 이용해여 순서를 지정해줄수있다 / 보통 Rownum을 사용할때 주로 사용

#### 	FROM (SELECT ...)  

```D
SELECT ROWNUM, ENAME,HIREDATE
FROM(SELECT ROWNUM,ENAME,HIREDATE
FROM EMP
ORDER BY HIREDATE DESC)
WHERE ROWNUM < 6;
```



#### 두번째 :  일반 서브쿼리 : WHERE문에서 공통적인 컬럼을 사용해서 두 테이블을 연결 해주는 역활을 한다.

#### WHERE 컬럼 명= (SELECT 컬럼명 ....) 

```D
SELECT DNAME
FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'SMITH');
```





### 2 ) Join과 SubQuery의 차이점 : 내가 이것저것 해본 결과 SubQuery는 출력의 한계를 느낀다...



#### Join : 두 테이블을 Where 문에서 연결해서 데이터를 검색

```D
SELECT E.ENAME ,E.DEPTNO, D.DNAME					//SELECT에서는 어떤 테이블에서 컬럼을 가져왔는지 명시해줘야한다. EX ) E. or D.
FROM EMP E, DEPT D									//이렇게 FROM절에서 참조할 두 테이블을 구분하고
WHERE E.ENAME = 'SMITH' AND E.DEPTNO = D.DEPTNO;    //WHERE문에서 공통 컬럼을 찾아 연결해준다.
```



#### SubQuery : 두 테이블의 Where문에서 공통 컬럼을 찾아 연결 검색

```D
SELECT ENAME
FROM EMP 
WHERE DEPTNO = (SELECT DEPTNO          //EMP 테이블의 DEPTNO 와 DEPT 테이블의 DEPTNO를 공통 컬럼으로 WHERE문에서 연결
                FROM DEPT
                WHERE LOC = 'DALLAS');
```



#### 내가 느낀 차이점 : 출력의 한계 (검색 기능) 

Join은 WHERE절에서 두 테이블을 **공통 컬럼을 연결하여** **두 테이블의 모든 컬럼을 자유자제적으로 검색과 출력**을 할 수 있지만...

**SubQuery**는 WHERE절에서 두 테이블을 **공통 컬럼으로 연결해도 출력할수있는 한계**가 있다.. 모든 컬럼을 출력할수없었고 **두 테이블의 공통 컬럼만 출력 가능** 



#### 공식 차이점 : 속도의 한계 (최적화)

**Join과 SubQuery는 속도 차이가 있다**. Join은 빅데이터에서 사용하기는 SubQuery보다 조금 느린 편이 있고

SubQuery는 빅데이터에서 Join보다는 조금 빠르다.

하지만 데이터가 작다면 Join을 사용하는것이 더 좋다고 한다.   



**ps. 현업에서 주로 SubQuery 보다 Join을 더 많이 사용한다고 하니 Join을 중점으로 두되 SubQuery도 알고있어야 하고**

**두 차이점을 확실히 공부하는 편이 좋은것 같다.**