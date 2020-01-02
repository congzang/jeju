-- BBK가 구매한 데이터 출력
SELECT *
  FROM sales
 WHERE userid = 'BBK';
 
-- 김씨인 사람 중 이름과 키를 기준으로 이름, 키, 주소를 내림차순 출력(이름 뒤에는 '님'을 붙여서 출력)
SELECT concat(name, '님') AS name, height, addr
  FROM user
 WHERE name LIKE '김%'
 ORDER BY name DESC, height DESC;
 
-- user를 출생년도별 오름차순으로 이름, 주소, 키, 출생년도 출력(이름은 성을 빼고 출력)
SELECT substr(name, 2) AS name, addr, height, birthyear
  FROM user
 ORDER BY birthyear ASC;

-- 모바일번호가 011로 시작하는 사람 몇 명인지 출력
SELECT COUNT(*)
  FROM user
 WHERE mobile1 = '011';

-- 출생년도가 1960~1979년에 태어난 사람들이 구매한 품목 출력
SELECT s.prodname
  FROM sales s
 INNER JOIN user u ON u.birthYear BETWEEN 1960 AND 1979 AND u.userid = s.userid;

-- UserID별로 구매한 price, amount 합계 출력(이 때 UserID는 name으로 출력)
SELECT u.name, sum(s.price), sum(s.amount)
  FROM sales s
 INNER JOIN user u ON s.userid = u.userid
 GROUP BY u.userid;

-- 주소가 서울인 사람이 구매한 총액
SELECT SUM(s.price * s.amount)
  FROM sales s
 INNER JOIN user u ON s.userid = u.userid AND u.addr = '서울';

-- 품목별 판매 총액을 출력
SELECT prodname, SUM(price * amount) AS '판매총액'
  FROM sales
 GROUP BY prodname;

-- 출생년도가 1970년도 이상인 사람을 대상으로 구매한 개수가 2개 이상인 것의 판매 총합계
SELECT SUM(s.price * s.amount) AS '판매총합계'
  FROM sales s
 INNER JOIN user u ON s.userid = u.userid AND u.birthYear >= 1970 AND s.amount >= 2;

-- 모든 유저를 출력(이름 중에 김씨와 조씨는 모두 컬씨로 변경하여 출력)
SELECT (CASE WHEN name LIKE '김%' OR name LIKE '조%' THEN CONCAT('컬', SUBSTR(name, 2)) ELSE name END) AS name
     , userid, birthyear, addr, mobile1, mobile2, height, mdate
  FROM user;

-- 책을 구매한 사람의 이름, 출생년도, 주소 출력
SELECT u.name, u.birthyear, u.addr
  FROM sales s
 INNER JOIN user u ON s.userid = u.userid AND s.prodName = '책'
 GROUP BY u.name;