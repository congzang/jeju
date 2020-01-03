-- --------------------------------------------------------
-- 호스트:                          192.168.1.237
-- 서버 버전:                        5.5.64-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- acornschool 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `acornschool`;
CREATE DATABASE IF NOT EXISTS `acornschool` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `acornschool`;

-- 테이블 acornschool.pet 구조 내보내기
DROP TABLE IF EXISTS `pet`;
CREATE TABLE IF NOT EXISTS `pet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `owner` varchar(20) DEFAULT NULL,
  `species` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `death` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- 테이블 데이터 acornschool.pet:~7 rows (대략적) 내보내기
DELETE FROM `pet`;
/*!40000 ALTER TABLE `pet` DISABLE KEYS */;
INSERT INTO `pet` (`id`, `name`, `owner`, `species`, `sex`, `birth`, `death`) VALUES
	(3, '돌이', 'acorn', '곰', 'f', '2014-08-01', '2018-02-01'),
	(4, '대한', '민주', 'cat', 'f', '2001-02-04', NULL),
	(5, '민국', '자유', 'cat', 'f', '2010-03-17', NULL),
	(6, '만세', '민주', 'cat', 'f', '2010-05-13', NULL),
	(7, '하자', '민주', 'cat', 'm', '2015-08-27', NULL),
	(8, '성공', '자유', 'cat', 'm', '2017-08-31', '2018-04-29'),
	(11, '마음', 'acorn', '백구', 'f', '2018-01-02', '2018-11-04');
/*!40000 ALTER TABLE `pet` ENABLE KEYS */;

-- 프로시저 acornschool.pet_delete 구조 내보내기
DROP PROCEDURE IF EXISTS `pet_delete`;
DELIMITER //
CREATE PROCEDURE `pet_delete`(
	IN `inname` VARCHAR(50),
	OUT `res` INT
)
BEGIN
	DECLARE cnt INT DEFAULT 0;
	
	SELECT COUNT(*) INTO cnt FROM pet WHERE NAME = inname;
	
	IF cnt > 0 THEN
		DELETE FROM pet WHERE NAME = inname;
		
		SET res = 0;
		
	ELSE
		SET res = 2;
		
	END IF;
		
END//
DELIMITER ;

-- 프로시저 acornschool.pet_insert 구조 내보내기
DROP PROCEDURE IF EXISTS `pet_insert`;
DELIMITER //
CREATE PROCEDURE `pet_insert`(
	IN `name` VARCHAR(50),
	IN `owner` VARCHAR(50),
	IN `species` VARCHAR(50),
	IN `sex` CHAR(1),
	IN `birth` DATE,
	IN `death` DATE
)
BEGIN
	INSERT INTO pet(name, owner, species, sex, birth, death)
	     VALUES (name, owner, species, sex, birth, death);
END//
DELIMITER ;

-- 프로시저 acornschool.pet_select 구조 내보내기
DROP PROCEDURE IF EXISTS `pet_select`;
DELIMITER //
CREATE PROCEDURE `pet_select`()
BEGIN
	SELECT * FROM  pet;
END//
DELIMITER ;

-- 프로시저 acornschool.pet_update 구조 내보내기
DROP PROCEDURE IF EXISTS `pet_update`;
DELIMITER //
CREATE PROCEDURE `pet_update`(
	IN `old_name` VARCHAR(50),
	IN `new_name` VARCHAR(50),
	OUT `res` INT
)
BEGIN
	DECLARE cnt INT DEFAULT 0; -- cnt = 0
	
	SELECT COUNT(*) INTO cnt FROM pet WHERE NAME = old_name;
	
	IF cnt > 0 THEN
		UPDATE pet
	   	SET NAME = new_name
	 	 WHERE NAME = old_name;
	 	 
	 	COMMIT;
	 	
		SET res = 0;
		
	ELSE 
		SET res = 2;
	END IF;
END//
DELIMITER ;

-- 테이블 acornschool.sungjuk 구조 내보내기
DROP TABLE IF EXISTS `sungjuk`;
CREATE TABLE IF NOT EXISTS `sungjuk` (
  `bunho` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `kor` int(11) DEFAULT NULL,
  `eng` int(11) DEFAULT NULL,
  `mat` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `average` float DEFAULT NULL,
  `grade` char(1) DEFAULT NULL,
  PRIMARY KEY (`bunho`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 테이블 데이터 acornschool.sungjuk:~1 rows (대략적) 내보내기
DELETE FROM `sungjuk`;
/*!40000 ALTER TABLE `sungjuk` DISABLE KEYS */;
INSERT INTO `sungjuk` (`bunho`, `name`, `kor`, `eng`, `mat`, `total`, `average`, `grade`) VALUES
	(2, '홍길동', 90, 45, 80, NULL, NULL, NULL),
	(3, '김둘리', 67, 100, 56, NULL, NULL, NULL),
	(4, '최또치', 90, 60, 70, NULL, NULL, NULL),
	(5, '도우너', 10, 30, 20, NULL, NULL, NULL);
/*!40000 ALTER TABLE `sungjuk` ENABLE KEYS */;

-- 프로시저 acornschool.sungjuk_delete 구조 내보내기
DROP PROCEDURE IF EXISTS `sungjuk_delete`;
DELIMITER //
CREATE PROCEDURE `sungjuk_delete`(
	IN `in_name` VARCHAR(50),
	OUT `out_res` INT
)
BEGIN
	DECLARE cnt INT DEFAULT 0;
	SELECT COUNT(*) INTO cnt FROM sungjuk WHERE NAME = in_name;
	
	IF cnt > 0 THEN
		DELETE FROM sungjuk WHERE NAME = in_name;
		
		SET out_res = 0;
		
	ELSE
		SET out_res = 2;
	END IF;

END//
DELIMITER ;

-- 프로시저 acornschool.sungjuk_insert 구조 내보내기
DROP PROCEDURE IF EXISTS `sungjuk_insert`;
DELIMITER //
CREATE PROCEDURE `sungjuk_insert`(
	IN `in_name` VARCHAR(50),
	IN `in_kor` INT,
	IN `in_mat` INT,
	IN `in_eng` INT
)
BEGIN
	INSERT INTO sungjuk(NAME, kor, mat, eng)
	     VALUES (in_name, in_kor, in_mat, in_eng);
END//
DELIMITER ;

-- 프로시저 acornschool.sungjuk_select 구조 내보내기
DROP PROCEDURE IF EXISTS `sungjuk_select`;
DELIMITER //
CREATE PROCEDURE `sungjuk_select`()
BEGIN
	SELECT * FROM sungjuk;
END//
DELIMITER ;

-- 프로시저 acornschool.sungjuk_update 구조 내보내기
DROP PROCEDURE IF EXISTS `sungjuk_update`;
DELIMITER //
CREATE PROCEDURE `sungjuk_update`(
	IN `in_name` VARCHAR(50),
	IN `up_name` VARCHAR(50),
	OUT `out_res` INT
)
BEGIN
	DECLARE cnt INT DEFAULT 0;
	
	SELECT COUNT(*) INTO cnt FROM sungjuk WHERE name = in_name;
	
	IF cnt > 0 THEN	
		UPDATE sungjuk
	   	SET name = up_name
	 	 WHERE name = in_name;
	 	 
	 	SET out_res = 0;
	ELSE
		SET out_res = 2;
	END if;
END//
DELIMITER ;


-- jeju 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `jeju`;
CREATE DATABASE IF NOT EXISTS `jeju` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jeju`;

-- 테이블 jeju.authors 구조 내보내기
DROP TABLE IF EXISTS `authors`;
CREATE TABLE IF NOT EXISTS `authors` (
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.authors:~2 rows (대략적) 내보내기
DELETE FROM `authors`;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` (`name`, `address`) VALUES
	('대한민국', '서울시'),
	('민국이', '대전시');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;

-- 테이블 jeju.goods 구조 내보내기
DROP TABLE IF EXISTS `goods`;
CREATE TABLE IF NOT EXISTS `goods` (
  `code` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `su` int(11) DEFAULT NULL,
  `dan` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Primary key : 중복 불가, 외부에서 참조가 가능한 키';

-- 테이블 데이터 jeju.goods:~7 rows (대략적) 내보내기
DELETE FROM `goods`;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` (`code`, `name`, `su`, `dan`) VALUES
	(1, '냉장고', 2, 850000),
	(2, '세탁기', 3, 550000),
	(3, '전자렌지', 2, 350000),
	(4, 'HDTV', 3, 1500000),
	(5, 'VR기기', 2, 1440000),
	(6, 'Drone', 1, 890000),
	(7, '고성능컴퓨터', 3, NULL);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;

-- 테이블 jeju.sales 구조 내보내기
DROP TABLE IF EXISTS `sales`;
CREATE TABLE IF NOT EXISTS `sales` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `userID` char(3) NOT NULL,
  `prodName` varchar(50) DEFAULT NULL,
  `groupName` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `userID` (`userID`),
  CONSTRAINT `FK__user_info` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.sales:~12 rows (대략적) 내보내기
DELETE FROM `sales`;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` (`num`, `userID`, `prodName`, `groupName`, `price`, `amount`) VALUES
	(1, 'KBS', '운동화', '전자', 30, 2),
	(2, 'KBS', '노트북', '전자', 1000, 1),
	(3, 'JYP', '모니터', '전자', 200, 1),
	(4, 'BBK', '모니터', '전자', 200, 5),
	(5, 'KBS', '청바지', '의류', 50, 3),
	(6, 'BBK', '메모리', '전자', 80, 10),
	(7, 'SSK', '책', '서적', 15, 5),
	(8, 'EJW', '책', '서적', 15, 2),
	(9, 'EJW', '청바지', '의류', 50, 1),
	(10, 'BBK', '운동화', '전자', 30, 2),
	(11, 'EJW', '책', '서적', 15, 1),
	(12, 'BBK', '운동화', '서적', 30, 2);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;

-- 테이블 jeju.school 구조 내보내기
DROP TABLE IF EXISTS `school`;
CREATE TABLE IF NOT EXISTS `school` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `schoolname` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `schoolcode` char(10) NOT NULL,
  `studentcount` int(11) DEFAULT NULL,
  PRIMARY KEY (`schoolcode`),
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.school:~4 rows (대략적) 내보내기
DELETE FROM `school`;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` (`no`, `schoolname`, `address`, `schoolcode`, `studentcount`) VALUES
	(1, '충주여자고등학교', '충주시', 'CH00000001', 300),
	(2, '신성여자고등학교', '제주시', 'IC00000001', 560),
	(3, '종로여자고등학교', '종로구', 'JR00000001', 300),
	(4, '제주여자고등학교', '서울시', 'SE00000001', 300);
/*!40000 ALTER TABLE `school` ENABLE KEYS */;

-- 테이블 jeju.student 구조 내보내기
DROP TABLE IF EXISTS `student`;
CREATE TABLE IF NOT EXISTS `student` (
  `bunho` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `kor` tinyint(4) DEFAULT NULL,
  `mat` tinyint(4) DEFAULT NULL,
  `eng` tinyint(4) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `average` float DEFAULT NULL,
  `grade` char(2) DEFAULT NULL,
  `schoolcode` char(10) DEFAULT NULL,
  PRIMARY KEY (`bunho`),
  KEY `schoolcode` (`schoolcode`),
  CONSTRAINT `FK__school` FOREIGN KEY (`schoolcode`) REFERENCES `school` (`schoolcode`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.student:~9 rows (대략적) 내보내기
DELETE FROM `student`;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` (`bunho`, `name`, `kor`, `mat`, `eng`, `total`, `average`, `grade`, `schoolcode`) VALUES
	(1, '전공인', 81, 82, 91, 254, 84.67, 'B', 'SE00000001'),
	(2, '전공이', 82, 82, 82, 246, 82, 'B', 'SE00000001'),
	(3, '전공삼', 92, 101, 101, 294, 98, 'A', 'CH00000001'),
	(4, '전공사', 101, 101, 101, 303, 101, 'A', 'CH00000001'),
	(5, '고려인', 101, 82, 72, 255, 85, 'B', 'CH00000001'),
	(6, '종로구', 101, 82, 72, 255, 85, 'B', 'IC00000001'),
	(7, '종로구', 101, 82, 72, 255, 85, 'B', 'IC00000001'),
	(8, '김만덕', 101, 82, 72, 255, 85, 'B', 'IC00000001'),
	(9, '제주도2', 101, 101, 101, 303, 101, 'A', 'IC00000001');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;

-- 테이블 jeju.student2 구조 내보내기
DROP TABLE IF EXISTS `student2`;
CREATE TABLE IF NOT EXISTS `student2` (
  `num` int(11) NOT NULL,
  `name` varchar(10) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `major` varchar(20) DEFAULT NULL,
  `addr` varchar(15) DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.student2:~6 rows (대략적) 내보내기
DELETE FROM `student2`;
/*!40000 ALTER TABLE `student2` DISABLE KEYS */;
INSERT INTO `student2` (`num`, `name`, `sex`, `age`, `major`, `addr`, `tel`, `money`) VALUES
	(20120001, '고길동', 'm', 27, '선박', 'seoul', '010-000-4512', 5000),
	(20120002, '최둘리', 'm', 22, '역사', 'pusan', '010-999-9999', 4500),
	(20120003, '도우너', 'w', 15, '역사', 'daegu', '010-555-5555', 6500),
	(20120004, '김만덕', 'w', 15, '유아', 'mokpo', '010-555-7777', 7000),
	(20120005, '류현진', 'm', 22, '컴퓨터공학', 'seoul', '010-122-2222', 8000),
	(20120006, '손흥민', 'm', 22, '컴퓨터공학', 'seoul', '010-999-9999', 8000);
/*!40000 ALTER TABLE `student2` ENABLE KEYS */;

-- 테이블 jeju.students 구조 내보내기
DROP TABLE IF EXISTS `students`;
CREATE TABLE IF NOT EXISTS `students` (
  `name` varchar(50) DEFAULT NULL,
  `kor` float DEFAULT NULL,
  `eng` float DEFAULT NULL,
  `math` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `avg` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.students:~3 rows (대략적) 내보내기
DELETE FROM `students`;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` (`name`, `kor`, `eng`, `math`, `total`, `avg`) VALUES
	('대한이', 90, 90, 90, NULL, NULL),
	('민국이', 80, 80, 81, NULL, NULL),
	('만세', 100, 100, 100, NULL, NULL);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;

-- 프로시저 jeju.student_insert 구조 내보내기
DROP PROCEDURE IF EXISTS `student_insert`;
DELIMITER //
CREATE PROCEDURE `student_insert`(
	IN `name` VARCHAR(50),
	IN `kor` INT,
	IN `mat` INT,
	IN `eng` INT,
	IN `schoolcode` CHAR(10),
	OUT `result` INT
)
BEGIN
	DECLARE exit handler for SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SET result = -1;
	END;
	
	START TRANSACTION;
		INSERT INTO student(name, kor, mat, eng, schoolcode)
	        VALUES (name, kor, mat, eng, schoolcode);
	COMMIT;
	
	SET result = 0;
END//
DELIMITER ;

-- 프로시저 jeju.student_select 구조 내보내기
DROP PROCEDURE IF EXISTS `student_select`;
DELIMITER //
CREATE PROCEDURE `student_select`()
BEGIN
	SELECT * FROM student;
END//
DELIMITER ;

-- 프로시저 jeju.student_sum 구조 내보내기
DROP PROCEDURE IF EXISTS `student_sum`;
DELIMITER //
CREATE PROCEDURE `student_sum`()
BEGIN
	DROP TABLE IF EXISTS sungjuk_hab;
	
	CREATE TABLE sungjuk_hab(korhab float, mathab float, enghab float) AS
			SELECT sum(kor) AS korhab, sum(mat) AS mathab, sum(eng) AS enghab 
			  FROM student;
		
	INSERT INTO sungjuk_hab(korhab, mathab, enghab)
		  SELECT round(avg(kor), 2), round(avg(mat), 2), round(avg(eng), 2) 
		    FROM student;
		  
	SELECT * FROM sungjuk_hab;
END//
DELIMITER ;

-- 프로시저 jeju.student_updateone 구조 내보내기
DROP PROCEDURE IF EXISTS `student_updateone`;
DELIMITER //
CREATE PROCEDURE `student_updateone`()
BEGIN
	DECLARE _done INT DEFAULT FALSE; -- 무한루프 종료조건
	DECLARE name_var VARCHAR(20);    -- 하나의 데이터를 처리하기 위한 변수
	DECLARE kor_var INT;
	DECLARE mat_var INT;
	DECLARE eng_var INT;
	
	-- CURSOR : 데이터를 가리키는 위치
	DECLARE cursor_student CURSOR FOR
		SELECT name, kor, mat, eng FROM student;
	
	DECLARE continue handler FOR NOT FOUND
		SET _done = TRUE;
		
	OPEN cursor_student;
		
		REPEAT
			-- FETCH : cursor에서 1개의 record를 가져옴
			FETCH cursor_student INTO name_var, kor_var, mat_var, eng_var; -- INTO 이후 변수에 cursor에 있는 값을 넣음
			
			IF NOT _done THEN
				UPDATE student
				   SET kor = kor_var + 1
				     , mat = mat_var + 1
				     , eng = eng_var + 1
				 WHERE name = name_var;
				
				 SET _done = FALSE;
			END IF;
			
			UNTIL _done -- 종료조건 _done=TRUE가 될 때까지 무한루프
		END REPEAT;
	
	CLOSE cursor_student;
	
END//
DELIMITER ;

-- 프로시저 jeju.student_update_name 구조 내보내기
DROP PROCEDURE IF EXISTS `student_update_name`;
DELIMITER //
CREATE PROCEDURE `student_update_name`(
	IN `old_name` VARCHAR(50),
	IN `new_name` VARCHAR(50),
	OUT `result` INT


)
BEGIN
	DECLARE cnt int default 0; -- cnt = 0;
	BEGIN 
		SELECT COUNT(*) INTO cnt FROM student WHERE name = old_name;
	END;
	
	IF cnt > 0 THEN
			UPDATE student
			   SET name = new_name
			 WHERE name = old_name;

		 SET result := 0;
	ELSE 
		SET result := -1;
	END IF;
END//
DELIMITER ;

-- 테이블 jeju.sungjuk_hab 구조 내보내기
DROP TABLE IF EXISTS `sungjuk_hab`;
CREATE TABLE IF NOT EXISTS `sungjuk_hab` (
  `korhab` float DEFAULT NULL,
  `mathab` float DEFAULT NULL,
  `enghab` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.sungjuk_hab:~2 rows (대략적) 내보내기
DELETE FROM `sungjuk_hab`;
/*!40000 ALTER TABLE `sungjuk_hab` DISABLE KEYS */;
INSERT INTO `sungjuk_hab` (`korhab`, `mathab`, `enghab`) VALUES
	(852, 786, 755),
	(94.67, 87.33, 83.89);
/*!40000 ALTER TABLE `sungjuk_hab` ENABLE KEYS */;

-- 테이블 jeju.user 구조 내보내기
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userID` char(3) NOT NULL DEFAULT 'AAA',
  `name` varchar(10) DEFAULT NULL,
  `birthYear` int(11) DEFAULT NULL,
  `addr` varchar(50) DEFAULT NULL,
  `mobile1` char(3) DEFAULT NULL,
  `mobile2` char(8) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `mDate` date DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.user:~10 rows (대략적) 내보내기
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`userID`, `name`, `birthYear`, `addr`, `mobile1`, `mobile2`, `height`, `mDate`) VALUES
	('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-05-05'),
	('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-03-03'),
	('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10'),
	('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-04-04'),
	('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-04-04'),
	('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-07-07'),
	('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-09-09'),
	('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-08-08'),
	('SSK', '성시경', 1979, '서울', '', '', 186, '2013-12-12'),
	('YJS', '윤종신', 1969, '경남', '', '', 170, '2005-05-05');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- 트리거 jeju.student_before_insert 구조 내보내기
DROP TRIGGER IF EXISTS `student_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `student_before_insert` BEFORE INSERT ON `student` FOR EACH ROW BEGIN
	SET new.total   = new.kor + new.mat + new.eng; -- old.: 입력된 데이터, new.: 새로운 데이터, SET : 변수에 값을 대입할 때 대입문 앞에 씀
	SET new.average = round(new.total/3, 2);
	
	IF     new.average >= 90 THEN SET new.grade = 'A';
	ELSEIF new.average >= 80 THEN SET new.grade = 'B';
	ELSEIF new.average >= 70 THEN SET new.grade = 'C';
	ELSEIF new.average >= 60 THEN SET new.grade = 'D';
	ELSE 									SET new.grade = 'F';
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 트리거 jeju.student_before_update 구조 내보내기
DROP TRIGGER IF EXISTS `student_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `student_before_update` BEFORE UPDATE ON `student` FOR EACH ROW BEGIN
	SET new.total   = new.kor + new.mat + new.eng; -- old.: 입력된 데이터, new.: 새로운 데이터, SET : 변수에 값을 대입할 때 대입문 앞에 씀
	SET new.average = round(new.total/3, 2);
	
	IF     new.average >= 90 THEN SET new.grade = 'A';
	ELSEIF new.average >= 80 THEN SET new.grade = 'B';
	ELSEIF new.average >= 70 THEN SET new.grade = 'C';
	ELSEIF new.average >= 60 THEN SET new.grade = 'D';
	ELSE 									SET new.grade = 'F';
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
