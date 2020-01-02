-- school 데이터 입력
INSERT INTO school(schoolname, address, schoolcode, studentcount)
     VALUES ('충주여자고등학교', '충주시', 'CH00000001', 300);
INSERT INTO school(schoolname, address, schoolcode, studentcount)
     VALUES ('신성여자고등학교', '제주시', 'IC00000001', 560);
INSERT INTO school(schoolname, address, schoolcode, studentcount)
     VALUES ('종로여자고등학교', '종로구', 'JR00000001', 300);
INSERT INTO school(schoolname, address, schoolcode, studentcount)
     VALUES ('제주여자고등학교', '서울시', 'SE00000001', 300);
     
SELECT * FROM school;

-- student 데이터 입력
INSERT INTO student(NAME, kor, mat, eng, schoolcode)
     VALUES ('전공인', 81, 81, 81, 'SE00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode)
     VALUES ('전공이', 81, 81, 81, 'SE00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode)
     VALUES ('전공삼', 91, 100, 100, 'CH00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode)
     VALUES ('전공사', 100, 100, 100, 'CH00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode)
     VALUES ('고려인', 100, 81, 71, 'CH00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode)
     VALUES ('종로구', 100, 81, 71, 'IC00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode)
     VALUES ('종로구', 100, 81, 71, 'IC00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode)
     VALUES ('김만덕', 100, 81, 71, 'IC00000001');
     
SELECT * FROM school;
SELECT * FROM student;

SELECT * FROM school WHERE schoolcode = 'CH00000001';
SELECT * FROM student WHERE NAME = '고려인';
SELECT NAME, kor, eng, mat FROM student WHERE NAME = '전공인';
SELECT NAME AS '이름', kor AS '국어', mat AS '수학', eng AS '영어'
  FROM student
 WHERE NAME = '전공이';
 
-- subquery
SELECT name, kor, mat, eng 
  FROM student 
 WHERE schoolcode IN (SELECT schoolcode FROM school WHERE schoolname = '신성여자고등학교');
 
SELECT name, kor, mat, eng FROM student WHERE name LIKE '전공%';
SELECT name, kor, mat, eng FROM student WHERE name LIKE '%공%';
SELECT name, kor, mat, eng FROM student WHERE name LIKE '_려_';

SELECT * FROM student WHERE kor > 90 AND mat > 90 AND eng > 90;
SELECT * FROM student WHERE kor > 90 OR mat > 90 OR eng > 90;
SELECT * FROM student WHERE kor >= 80 AND kor <= 100;
SELECT * FROM student WHERE kor between 80 AND 100;

SELECT * FROM student LIMIT 1;

SELECT * FROM student ORDER BY NAME DESC; -- DESC: Descending 내림차순
SELECT * FROM student ORDER BY NAME ASC;  -- ASC: Ascending 오름차순

-- join
SELECT sc.schoolname, sc.schoolcode, st.name, st.average
  FROM student st
 INNER JOIN school sc ON st.schoolcode = sc.schoolcode; -- inner join : 두 개의 조건이 완전 만족

SELECT NAME AS '이름', kor AS '국어', mat AS '수학', eng AS '영어'
  FROM student WHERE NAME = '전공이';
-- CONCAT: 문자 연결 CONCAT(문자열, 연결할 문자1, 연결할 문자2, 연결할 문자3, ...)
SELECT CONCAT(NAME, '님') AS '이름', kor AS '국어', mat AS '수학', eng AS '영어'
  FROM student WHERE NAME = '전공인';
SELECT CONCAT(NAME, '님') AS '이름', LPAD(kor, 10, '*') AS '국어', mat AS '수학', eng AS '영어'
  FROM student WHERE NAME = '전공삼';
-- REPLACE: 문자 대체 REPLACE(문자열, 대체할(old) 문자, 대체될(new) 문자)
SELECT REPLACE(CONCAT(NAME, '님'), '님', '형') AS '이름', LPAD(kor, 10, '*') AS '국어', mat AS '수학', eng AS '영어'
  FROM student WHERE NAME = '전공삼';
-- SUBSTR: 문자 추출 SUBSTR(문자열, 시작INDEX, 추출개수)
SELECT SUBSTR(REPLACE(CONCAT(NAME, '님'), '님', '형'), 1, 2) AS '이름', LPAD(kor, 10, '*') AS '국어', mat AS '수학', eng AS '영어'
  FROM student WHERE NAME = '전공삼';
-- LENGTH: 길이(영문,숫자length = 1, 한글length = 3), CHAR_LENGTH: 문자 개수
SELECT LENGTH(SUBSTR(REPLACE(CONCAT(NAME, '님'), '님', '형'), 1, 2)) AS '이름', LPAD(kor, 10, '*') AS '국어', mat AS '수학', eng AS '영어'
  FROM student WHERE NAME = '전공삼';
  
# 문제
-- 전공인의 국어 80, 영어 90으로 변경하고, 합계, 평균, grade를 수정
   -- 계산을 수동으로 하고 변화만 적용하시요.
UPDATE student
   SET kor = 80
     , eng = 90
     , total = kor + eng + mat
     , average = round(total/3, 2)
     , grade = (CASE WHEN average >= 90 THEN 'A'
	                  WHEN average >= 80 THEN 'B'
						   WHEN average >= 70 THEN 'C'
						   WHEN average >= 60 THEN 'D'
						   ELSE 'F' END)
 WHERE NAME = '전공인';
SELECT * FROM student WHERE NAME = '전공인';

-- student 중 kor, mat 점수만 출력하시요.
SELECT kor, mat FROM student;

-- student 중 average가 90 이상인 사람의 name, schoolname 출력하시요.
SELECT st.NAME, sc.schoolname 
  FROM student st
 INNER JOIN school sc ON st.schoolcode = sc.schoolcode AND st.average >= 90;
 
-- student 중 eng 점수를 출력하되 그 이름을 '영어'로 하시요.
SELECT eng AS '영어' FROM student;

-- 이름 가운데 자가 '공'인 사람을 모두 출력하시요.
SELECT * FROM student WHERE NAME LIKE '%공%';

-- 학교 이름이 충주여자고등학교인 사람의 name, total을 출력하시요.
SELECT st.name, st.total
  FROM student st
 INNER JOIN school sc ON st.schoolcode = sc.schoolcode AND sc.schoolname = '충주여자고등학교';
 
-- student에서 total을 이용하여 정렬하고 상위 2명만 출력하세요.
-- SELECT문 실행(작성)순서 : WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT
SELECT * FROM student ORDER BY total DESC LIMIT 2;


-- stored procedure(저장 프로시져) : CALL 프로시져명();
CALL student_select();
CALL student_insert("제주도", 100, 100, 100, "TT00000001", @res)
SELECT @res; -- 위 프로시져 결과값 확인

# 문제. 이름을 변경하는 프로시져를 작성하시오.
SELECT * FROM student;
CALL student_update_name("제주도", "제주도2", @res);
SELECT @res; -- 위 프로시져 결과값 확인

-- 학생 성적 합계 테이블 생성하여 출력
CALL student_sum();
SELECT * FROM sungjuk_hab;

-- 학생 점수 +1
CALL student_updateone();
SELECT * FROM student;