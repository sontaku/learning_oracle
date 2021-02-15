OracleDB_Basic.txt
https://docs.oracle.com/en/database/oracle/oracle-database/19/cncpt/introduction-to-oracle-database.html#GUID-35C20601-E266-486E-987B-7F355DB10DD4

[학습]
1. DMBS와 DB
	- 데이터(Data) : 자료 -> 정보

	- DB(DataBase) : 데이터 저장 공간
	
	- DBMS(Database System) : 구조화된 데이터 집합
		'Relational Database' Management System

2. 오라클 DB 아키텍쳐(Oracle Database Architecture)
	- 오라클 인스턴스(Instance) : 메모리 + 프로세스
	- 오라클 데이터베이스(DB) : 데이터 저장 파일
	
	- 순서(간략)
		요청 -> 리스너 -> DB Connection -> 서버 프로세스 쿼리 실행	-> 세션 확인 -> 결과 반환

3. 모델
	- 데이터 모델(Data Model)
		계층형 - 트리 구조, 상하위개념
		네트워크형

	- 객체 지향형 모델(Object-Oriented Model) : 객체 개념 기반
	
	- 관계형 데이터 모델(Ralational Data Model)*
		현대 가장 많이 쓰이는 DB 모델
		데이터 간의 '관계' 초점
	
	- 구성 요소
		개체(Entity) : 사물, 개념 정보 단위 - 테이블(Table)
			
		속성(Attribute) :	최소 논리적 단위, 데이터 종류, 특성, 상태 ... , - 열(Column)
			
		관계(Relationship) : 개체 혹은 개체-속성 연관성 - 외래키(FK)

4. SQL(Structured Query Language)
	DB에서 데이터를 다루고 관리하는 질의 언어

[환경구축]
1. Oracle DB 설치
	00.sw - 03.RDBMS 
	OracleXE112_Win64.zip 압축해제
	OracleXE112_Win64\DISK1\setup.exe 실행
	Next -> I accept ... -> Next -> Next -> 경로확인 C:\
	-> manager -> Next -> Install -> Finish

2. 설치 확인 
	SQL Command Line
	CONNECT SYSTEM
	SHOW USER
	SELECT * FROM TAB;

	USER 세팅(SCOTT)
		@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
		SHOW USER
		alter user SCOTT identified by TIGER;
		CONNECT SCOTT/TIGER
		SHOW USER
		SELECT * FROM TAB;

3. Oracle SQL Developer : Oracle DB에서 SQL로 작업하기 위한 통합 개발 환경
	sqldeveloper-19.4.0.354.1759-x64 압축해제
	sqldeveloper\sqldeveloper.exe 실행
	아니오 -> 사용자 추적(옵션)
	감지된 데이터베이스 -> XE
	SYSTEM/manager
	좌측 상단 +
	SCOTT
	SCOTT/TIGER
	테스트 -> 저장
	왼쪽 접속 -> 클릭 -> TIGER