# Rownum , 인라인 뷰

### Rownum

### 1.) rownum
2.) oracle 자체적으로 제공하는 컬럼
3.) table당 무조건 자동 생성
4.) 검색시 검색된 데이터 순서대로 rownum값 자동 반영(1부터 시작)



#### 문법 : SELECT ROWNUM, 컬럼 명 FROM 테이블 명 

```D
SELECT ROWNUM,EMPNO  //ROWNUM = ORDERBY를 사용해도 자동으로 1부터 시작 
FROM EMP 
ORDER BY EMPNO DESC;
```



#### 사용 문법 : Rownum

```D
--?deptno의 값이 오름차순으로 정렬하여 30번까지 rownum 포함하여 검색
SELECT ROWNUM, DEPTNO
FROM DEPT
WHERE DEPTNO < 40
ORDER BY DEPTNO ASC;
```



### 인라인 뷰(Inline View) : 하나의 테이블처럼 사용 (테이블 대체 용도)

####  InLineView 란?

**SELECT 의 FROM 절에 테이블이 바로 오는 것이 아니라, select절이 오는 방식**

**사용하는 이유 :**  **인라인 뷰**는 **SELECT 절의 결과를 FROM 절에서 하나의 테이블처럼 사용하고 싶을 때 사용**



#### 예제 )

```D
SELECT ROWNUM,DEPTNO
FROM(SELECT ROWNUM,DEPTNO   //FROM절에서 사용하는 서브쿼리를 인라인뷰라고 하는것 (ORDER BY)
FROM EMP
ORDER BY DEPTNO ASC)
WHERE ROWNUM <= 3;
```

