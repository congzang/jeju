-- 데이터 입력
INSERT INTO user_info
     VALUES ('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, 20130505);
INSERT INTO user_info
     VALUES ('EJW', '은지원', 1972, '경북', '011', '88888888', 174, 20140303);
INSERT INTO user_info
     VALUES ('JKW', '조관우', 1965, '경기', '018', '99999999', 172, 20101010);
INSERT INTO user_info
     VALUES ('JYP', '조용필', 1950, '경기', '011', '44444444', 166, 20090404);
INSERT INTO user_info
     VALUES ('KBS', '김범수', 1979, '경남', '011', '22222222', 173, 20120404);
INSERT INTO user_info
     VALUES ('KKH', '김경호', 1971, '전남', '019', '33333333', 177, 20070707);
INSERT INTO user_info
     VALUES ('LJB', '임재범', 1963, '서울', '016', '66666666', 182, 20090909);
INSERT INTO user_info
     VALUES ('LSG', '이승기', 1987, '서울', '011', '11111111', 182, 20080808);
INSERT INTO user_info
     VALUES ('SSK', '성시경', 1979, '서울', '', '', 186, 20131212);
INSERT INTO user_info
     VALUES ('YJS', '윤종신', 1969, '경남', '', '', 170, 20050505);

SELECT * FROM user_info;

INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('KBS', '운동화', '전자', 30, 2);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('KBS', '노트북', '전자', 1000, 1);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('JYP', '모니터', '전자', 200, 1);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('BBK', '모니터', '전자', 200, 5);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('KBS', '청바지', '의류', 50, 3);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('BBK', '메모리', '전자', 80, 10);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('SSK', '책', '서적', 15, 5);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('EJW', '책', '서적', 15, 2);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('EJW', '청바지', '의류', 50, 1);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('BBK', '운동화', '전자', 30, 2);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('EJW', '책', '서적', 15, 1);
INSERT INTO sales(userid, prodname, groupname, price, amount)
     VALUES ('BBK', '운동화', '서적', 30, 2);
SELECT * FROM sales;