-- goods 테이블 데이터 입력
INSERT INTO goods VALUES (1, '냉장고', 2, 850000);
INSERT INTO goods VALUES (2, '세탁기', 3, 550000);
INSERT INTO goods VALUES (3, '전자렌지', 2, 350000);
INSERT INTO goods VALUES (4, 'HDTV', 3, 1500000);

INSERT INTO goods(CODE, su, dan) VALUES (4, 3, 1500000); -- Error!!! : name column NOT NULL
INSERT INTO goods(name, su, dan) VALUES ('py', 3, 1500000); -- Error!!! : code column PRIMARY KEY(primary key 기본값:0, 중복불가)

SELECT * FROM goods;

INSERT INTO goods(CODE, NAME, su) VALUES (5, '드론', 1);
UPDATE goods SET dan = 1000000 WHERE CODE = 5;
DELETE FROM goods WHERE CODE = 5;
INSERT INTO goods VALUES (5, 'VR기기', 2, 1440000); -- 입력 필드를 지정하지 않으면 전체 필드 입력
INSERT INTO goods VALUES (6, 'Drone', 1, 890000);
INSERT INTO goods(CODE, NAME, su) VALUES (7, '고성능컴퓨터', 3);

# 이름이 냉장고이고, 단가가 750,000이상인 데이터 출력
SELECT * FROM goods WHERE NAME = '냉장고' AND dan >= 750000;

# 단가가 750,000이하인 제품 출력
SELECT * FROM goods WHERE dan <= 750000;

# 단가가 500,000이상이고 1,200,000이하인 제품 출력
SELECT * FROM goods WHERE dan >= 500000 AND dan <= 1200000;

# 판매 수량이 3개 이상인 제품명과 단가의 출력
SELECT NAME, dan FROM goods WHERE su >= 3;

-- student2 테이블 데이터 입력
INSERT INTO student2 VALUES(20120001, '고길동', 'm', 27, '선박', 'seoul', '010-000-4512', 5000);
INSERT INTO student2 VALUES(20120002, '최둘리', 'm', 22, '역사', 'pusan', '010-999-9999', 4500);
INSERT INTO student2 VALUES(20120003, '도우너', 'w', 15, '역사', 'daegu', '010-555-5555', 6500);
INSERT INTO student2 VALUES(20120004, '김만덕', 'w', 15, '유아', 'mokpo', '010-555-7777', 7000);
INSERT INTO student2 VALUES(20120005, '류현진', 'm', 22, '컴퓨터공학', 'seoul', '010-122-2222', 8000);
INSERT INTO student2 VALUES(20120006, '손흥민', 'm', 22, '컴퓨터공학', 'seoul', '010-999-9999', 8000);

SELECT * FROM student2;

-- 직업별로 급여의 합계
SELECT major, SUM(money) FROM student2 GROUP BY major;
-- 전체 학생 수
SELECT COUNT(*) FROM student2;
-- 이름이 최씨인 학생 수
SELECT COUNT(*) FROM student2 WHERE NAME LIKE '최%';
-- 주소가 서울이고 이름이 고씨인 학생 수
SELECT COUNT(*) FROM student2 WHERE addr = 'seoul' AND NAME LIKE '고%';
SELECT COUNT(*) "전체 행수", COUNT(money) '급여건수'
     , MAX(money) 최대급여, MIN(money) 최소급여, ROUND(AVG(money), 2) 평균급여
  FROM student2
  
SELECT COUNT(*), COUNT(money), MAX(money), MIN(money), ROUND(AVG(money), 2) FROM student2
SELECT MAX(money) - MIN(money) AS 급여구간 FROM student2; -- AS는 생략가능

# money에 대하여 min-max 정규화를 실행하시요. 111
# 그룹 함수이기 때문에 그룹값을 상수화해야 정상적으로 계산됨
# SELECT (money - MIN(money)) / (MAX(money) - MIN(money)) FROM student2;
SELECT s.num, (s.money - s1.min_money) / (s1.max_money - s1.min_money) AS '정규화값'
     , s.money
  FROM student2 s
     , (SELECT MIN(money) min_money, MAX(money) max_money FROM student2) s1;
 
SELECT num, money FROM student2;

# money에 대하여 min-max 정규화를 실행하시요. 222
# -> 프로그램으로 변경( @: 사용자변수, @@: 시스템변수)
SELECT MIN(money) INTO @minvalue FROM student2;
SELECT @minvalue;
SELECT MAX(money) - MIN(money) INTO @rangevalue FROM student2;
SELECT @rangevalue;
SELECT (money - @minvalue) / @rangevalue AS '정규화값', money FROM student2;