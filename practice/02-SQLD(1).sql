-- 02. SQLD 기본 오답노트

--#7 테이블 컬럼 정의 변경(ALERT)
-- 선택 답안:
ALTER TABLE 기관 분류 
    ALTER COLUMN (분류명 VARCHAR(30) NOT NULL,
                 등록일자 DATE NOT NULL;
-- -> 틀린 이유: SQL에서 동시 수정하는 구문은 지원하지 않음 (오류 발생)
-- -> 수정: 
ALTER TABLE 기관 분류 ALTER COLUMN (분류명 VARCHAR(30) NOT NULL
ALTER TABLE 기관 분류 ALTER COLUMN (등록일자 VARCHAR(30) NOT NULL;

-- #12. 부서가 정의되지 않은 사원은 기본부서(코드: '0000' 배치하고,
-- 입사일지(JOIN_DATE) 기준으로  많은 조회가 발생하므로 입사일지에 index 생성함

-- 1번 풀이
CREATE TABLE EMP
    (EMP_NO VARCHAR(10) PRIMARY KEY,
    EMP_NM VARCHAR2(30) NOT NULL,
    DEPT1_CODE VARCHAR(4) DEFAULT '0000' NOT NULL,
    JOIN DATE DATE NOT NULL,
    REGIST_DATE DATE NULL);
    CREATE INDEX IDX_EMP_01 ON EMP (JOIN_DATE);
    
-- 2번 풀이
CREATE TABLE EMP
    (EMP_NO VARCHAR(10) NOT NULL
    EMP_NM VARCHAR2(30) NOT NULL,
    DEPT1_CODE VARCHAR(4) DEFAULT '0000' NOT NULL,
    JOIN DATE DATE NOT NULL,
    REGIST_DATE DATE);
    ALTER TABLE EMP ADD CONSTRAINT EMP_PK PRIMARY KEY
    (EMP_NO);
    CREATE INDEX IDX_EMP_01 ON EMP (JOIN_DATE);
    
-- #28 DB 트랜잭션에 대한 격리성이 낮은 경우 발생할 수 있는 문제점
-- 1번: Dirty_Read -> 다른 트랜잭션에 의해 수정되었지만 아직 반영되지 않은 커밋 데이터.
-- 4번: isolation: 트랜잭션의 특징이므로 트랜잭션의 격리성이 낮은 경우의 문제점이 아니다.
-- * isolation: 트랜잭션 실행 도중 다른 트랜잭션에 의해 영향을 받지 않은 것.

-- #35. SELET COL1 + COL3 FROM table_A;
-- 해설: NULL이 포함된 4칙 연산 결과는 NULL 이므로
-- 30 + 20 = 50 , NULL + 40 = NULL, 50 + NULL = NULL 이다.

-- #36. COLUMN1 값이 NULL 아닌 경우
-- 올바른 답안: SELECT * FROM MYTABLE WHERE COLUMN1 IS NOT NULL;
-- 해설: NULL 값 조건절 사용하는 경우 IS NULL, IS NOT NULL로 사용한다.

--#37. SQL과 ORACLE DDL 문장 테이블 생성 시 차이
-- 보기: INSERT INTO 서비스 VALUES ('999', '', '2015-11-11');
-- 보기 처럼 데이터 입력시 ORACLE에서는 데이터 조회하려면 
SELECT * FROM 서비스 WHERE 서비스명 = IS NULL;
-- 보기처럼 데이터 입력시 SQL에서는 데이터 조회하려면
SELECT * FROM 서비스 WHERE 서비스명 = '';

--#41 ⭐⭐⭐⭐ 다시 이해할 것-> 이해하지 못함.
-- keyword: 단일행 문자형 함수 중 라인수 구하기
-- 해설
-- 1. LENGTH: 문자열 길이 반환 함수
-- 2. CHR : ASCII 코드의 문자 반환 함수 (CHR(10) -> 줄바꿈)
-- 3. REPLACE: 문자열 치환 함수 (REPLACE(C1, CHR(10) -> 줄바꿈 제거)
-- 기존 ROWNUM 1> LENGTH: 3, REPLACE 후: AA,  REPLACE(C1, CHR(10)) : 2
-- 기존 ROWNUM 2> LENGTH: 5, REPLACE 후: BBB,  REPLACE(C1, CHR(10)) : 3

-- #45 
-- ISNULL 함수 결과값이 NULL 일시 지정된 값 반환함.
-- <보기>는 실행 결과가 X를 반환한다.
--SELECT ISNULL(COL2, 'X') FROM TAB1 WHERE COL1 = 'a';
-- 왜 정답일까?
-- 결과값이 NULL이 아닌 다른 값을 얻고자 할 때 ISNULL을 확인하는 함수를 사용한다.
-- 칼럼의 NULL 값을 확인 시 ISNULL 함수 사용함.

-- #48 
-- Table1의 c1(1), c2(2,2), C3(3,3,3)
-- SLECT SUM((COALESCE (C1, C2, C3)) FROM TAB1;
-- COALESCE 함수는 임의 개수 표현식에서 NULL이 아닌 최초 표현식을 나타낸다.
-- -> 모든 표현식이 NULL, NULL을 반환함.
-- 왜 정답일까?
-- ROW 1행에서 COALESCE(C1,C2,C3) -> COALESCE(1,2,3) 이기에 수행 결과는 6이다.
-- 즉 한 행이라도 NULL이 있으면 수행 결과에 포함시키면 안된다.

-- #53 : 오류가 발생하는 문장
SELECT 메뉴ID, 사용유형코드, AVG(COUNT(*)) AS AVGCNT
FROM 시스템 사용 이력
GROUP BY 메뉴ID, 사용유형코드;
-- 틀린 이유: GROUP BY 절에서 실행 결과는 1건이 되야 하기에
-- SELECT 절에서 메뉴 ID와 사용유형코드는 사용할 수 없다.

-- GROUP BY 절 특성
-- 1. SELECT 절에 집계 함수 사용함 
-- 2. 해당 함수는 NULL 값 가진 행 제외하고 수행함
-- 3. SELECT 절과 달리 별칭명 사용하지 못함
-- 4. 집계함수는 WHERE 절 오지 못함
