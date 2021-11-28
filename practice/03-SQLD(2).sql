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