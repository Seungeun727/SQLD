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
