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

