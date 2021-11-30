-- STUDY P.60 (41~
-- Searched Case Expression
-- LOC 조건에 따라 결과값을 리턴한다.
-- Q43
SELECT LOC, 
    CASE WHEN LOC = "NEW YORK" THEN "EAST"
        ELSE 'ETC'
    END as AREA
FROM DEPT;

-- Simple Case Expression
-- LOC의 해당 값에 따라 결과값을 리턴한다.
SELECT LOC, 
    CASE LOC WHEN "NEW YORK" THEN "EAST"
        ELSE 'ETC'
    END as AREA
FROM DEPT;

3  2  X
4  2 NULLIF

-- Q44 ⭐⭐⭐

-- Q45 : NULL의 올바른 특성 
--1. 공집합 아님
--2. 값이 NULL인 경우 숫자 데이터는 0, 문자 데이터는 X로 치환한다. -> 정답
--3. 실행결과는 모른다.
--4. 실행결과는 2다.

-- Q46 : 단일행 NULL 함수
SELECT ENAME, EMPNO, MGR, NULLIF(MGR, 7698) as NM FROM EMP;

-- Q47 : NULL 포함된 연산 
-- NULL 포함된 연산 결과는 NULL이다.
-- NULL 포함된 연산에서 부모가 0이 들어가는 경우 Error 발생함.
-- 문장 1 > 0 / 300 = 0
-- 문장 2 > 5000 / 0 = error
-- 문장 3 > 1000 / null = null

-- #48.
-- COALESCE 함수는 NULL이 아닌 값을 반환한다.
SELECT SUM(COALESCE(C1,C2,C3)) FROM TAB1;
-- COASLESCE(1,2,3) = 6

-- #49.
-- NVL(): 표현식의 결과값이 NULL이면 표현식 1 반환함.
-- NULLIF(): 표현식의 1이 표현식이 2와 같으면 NULL, 같지 않으면 표현식 1을 반환한다.
-- COALESCE(): NULL이 아닌 값을 반환한다.

-- #50.
SELECT AVG(COL3) FROM TABA;
SELECT AVG(COL3) FROM TABA WHERE COL1 > 0;
SELECT AVG(COL3) FROM TABA WHERE COL1 IS NOT NULL;
-- NULL이 포함된 연산의 결과는 NULL이다.
-- 문장 1> COL3(20, 0, NULL) ---> AVG(10)
-- 문장 2> AVG(20)
-- 문장 3> AVG(20)

-- #51
SELECT COUNT(GRADE) FROM EMPL
SELECT GRADE FROM EMP WHERE GRADE IN ("차장", "부장", "널");
SELECT GRADE COUNT(*) FROM EMP GROUP BY GRADE;

-- 문장 1> 500+ 100+ 30 + 10 + 5 = 645 (단 , NULL 제외)
-- 문장 2> 10 + 5 = 15 (단, NULL 제외)
-- 문장 3>  5 + NULL = 6건

-- #52 이해 필요.

-- #54
SELECT MAX(가) AS 가, SUM(다) AS 다
FROM A 
GROUP BY 나
HAVING COUNT(*) > 1
ORDER BY 다 DESC;

-- 가    나    다 
-- 009  A003  600
-- 005  A002  500
-- 002  A001  300
-- 010  A004  200
-- COUNT 2이상 인 경우 A003 ~ A001 까지임

--#56: 오류 발생하는 문장
--보기2 
SELECT 지역, 매출 금액
FROM 지역별 매출
ORDER BY  년 ASC;
-- ORACLE은 행기반 DBMS로 SELECT 절에 없는 칼럼도 정렬할 수 있다.
-- SQL 실행 순서는 SELECT 절 이후 ORDER BY 절 수행으로 논리적으로 맞지 않다.

-- #57: 0RDER BY 절 특성
-- 1. SQL 문장으로 조회된 데이터들을 다양한 목적에 맞게 특정 컬럼을 기준으로 정렬함.
-- 2. DBMS마다 NULL에 정의된 정렬 순서가 다를 수 있으므로 주의해야 한다.
-- 3. ORDER BY절에 ALIAS(별칭), 컬럼 순서 나타낸 정수를 혼용해서 사용 가능함.
-- 4. GROUP BY 절에 ORDER BY 절 집계 함수를 사용할 수 있다.

--#63: JOIN 설명
-- JOIN: 두 개 테이블 혼합하여 테이블 출력
-- 1. JOIN은 일반적으로 PK, FK 연관성에 의해 성립된다
-- 2. EQUI JOIN은 테이블 간 컬럼값들이 정확하게 일치하는 경우 성립된다.
-- 3. EQUI JOIN은 "="에 의해서만 수행되고 그 이외 연산자를 사용하는 경우
--    NONE EQUI JOIN이다.
-- 4. 대부분 NONE EQUI JOIN을 수행할 수 있지만, 때로는 설계상의 이유로
--   수행이 불가능한 경우도 있다.

--#65 순수 관계 연산자 설명
-- 순수 관계 연산자는 SELECT, JOIN, PROJECT, DIVIDE 로 구성된다.
-- SELECT는 WHERE 절로 구현함
-- JOIN은 다양한 JOIN으로 구현함
-- DIVIDE 연산은 현재 사용되지 않지만 순수 관계 연산자.

-- #68 JOIN
-- 정답은 맞췄지만 정확한 해설이 필요함.
-- 조건: 구매 이략이 있는 고객 중 구매 횟수가 3회 이상인
--       고객의 이름과 등급을 출력하시오.
-- 보기> TAB1: 고객(고객번호(PK), 이름, 등급)
--      TAB2: 구매정보(구매번호(PK), 구매금액, 고객번호(FK))
--  * 구매 정보 테이블의 고객번호는 고객 테이블의 고객 번호를 참조하는 외래키이다.
-- 스스로 생각한 답안 : LEFT OUTER JOIN은 왼쪽 테이블을 읽은 후 우측의 테이블 데이터 불러온다.
-- 조건에 따라 구매한 정보들이 고객 테이블에 동일한 값으로 담겨져야 하고 구매 횟수가 3회 이상으로
-- WHERE 절보다는 COUNT가 적합하다.
-- 해설: 구매 이력이 있어야 하므로 INNER JOIN, 구매 횟수이므로 COUNT 함수를 사용한다.

-- #74 LEFT , FULL, RIGHT 외부 조인에 대한 설명
-- FULL OUTER JOIN: 수행 시 좌측과 우측의 데이터를 합집합한 결과 -> 5건
-- ! 해당 줄 부터 이해되지 않음 ( 다시 이해 할 것)
-- RIGHT OUTER JOIN: 우측이 기준으로 우측의 데이터를 먼저 읽고 
--  좌측의 테이블데이터를 가져온다. 같은 값이 없을 시 가져오는 좌측 테이블 NULL로 채움 -> 4건
-- LEFT OUTER JOIN: 좌측 테이블의 데이터를 기준으로 데이터를 먼저 읽은 후 우측 테이블
-- 데이터를 읽은다. 같은 값이 없을 시 가져오는 우측 테이블 NULL -> 3건
-- 해설: 주키와 왜래키는 영향에 미치지 않는다.

-- #76 : OUTER JOIN
SELECT * FROM TAB1 LEFT OUTER JOIN TAB2 B 
    ON (A.C1 = B.C1 AND B.C2 BETWEEN 1 AND 3)
-- LEFT OUTER JOIN은 왼쪽 테이블의 데이터를 읽어 온 뒤 오른쪽 테이블의 데이터를 읽어온다.
-- 기준 테이블을 항상 표시하고 조건에 맞게 수행한다.

--#81 : SET OPERATOR
-- UNION: 합집합
-- INTERSECT : 교집합
-- MINUS: 차집합
-- EXCEPT: 차집합 

--#82 : 문제 자체를 풀지 못함
-- UNION ALL 사용 시 칼럼 별칭은 첫번째 모듈 기준으로 표시하며
-- ORDER BY 절은 집합 연산을 적용한 최종 결과에 대한 처리이고
-- 가장 마지막에 한번에 실행된다.

--#90 계층형 질문에 대한 설명
-- 1. SQL server 계층형 질문은 CTE를 재귀 호출함으로써 계층 구조를 전개한다.
-- 2. SQL server 계층형 질의문은 앵커 멤버를 실행하여 기본 결과 집합을 만들고
--  이후 재귀 멤버를 지속적으로 실행한다.
-- 3. ORACLE server 계층형 질의문에서 WEHREㅈ 절에서 모든 전개를 진행한 이후
-- 필터 조건으로 맞는 데이터만 추출하여 활용된다.
-- 4. ORACLE server 계층형 질의문에서 PRIOR 키워드는 SELECT, WHERE 절에서 사용한다.


