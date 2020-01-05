-- --------------------------------------------------------
-- 호스트:                          172.30.1.29
-- 서버 버전:                        5.5.64-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- homework1 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `homework1`;
CREATE DATABASE IF NOT EXISTS `homework1` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `homework1`;

-- 프로시저 homework1.delete_student 구조 내보내기
DROP PROCEDURE IF EXISTS `delete_student`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `delete_student`(
	IN `i_sid` INT,
	OUT `o_result` INT
)
BEGIN
	DECLARE cnt INT DEFAULT 0;
	
	SELECT count(*) INTO cnt FROM student WHERE s_id = i_sid;
	
	IF cnt > 0 THEN
		START TRANSACTION;
		
		DELETE FROM grade WHERE s_id = i_sid;
		DELETE FROM student WHERE s_id = i_sid;
		
		COMMIT;
		
		SET o_result = 1;
	
	ELSE
		SET o_result = 0;
	END IF;
END//
DELIMITER ;

-- 테이블 homework1.grade 구조 내보내기
DROP TABLE IF EXISTS `grade`;
CREATE TABLE IF NOT EXISTS `grade` (
  `s_id` int(11) DEFAULT NULL,
  `kor` int(11) DEFAULT '0',
  `eng` int(11) DEFAULT '0',
  `mat` int(11) DEFAULT '0',
  `total` int(11) DEFAULT '0',
  `avg` float DEFAULT '0',
  `grade` char(1) DEFAULT NULL,
  KEY `s_id` (`s_id`),
  CONSTRAINT `FK_grade_student` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='성적';

-- 테이블 데이터 homework1.grade:~0 rows (대략적) 내보내기
DELETE FROM `grade`;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */;
/*!40000 ALTER TABLE `grade` ENABLE KEYS */;

-- 프로시저 homework1.insert_student 구조 내보내기
DROP PROCEDURE IF EXISTS `insert_student`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `insert_student`(
	IN `i_name` VARCHAR(50),
	IN `i_class` CHAR(1),
	IN `i_birth` DATE,
	IN `i_gender` CHAR(1),
	IN `i_kor` INT,
	IN `i_eng` INT,
	IN `i_mat` INT,
	OUT `o_result` INT


)
BEGIN
	DECLARE in_sid INT DEFAULT NULL;
	
	INSERT INTO student(s_name, class, birth, gender)
     	  VALUES (i_name, i_class, i_birth, i_gender);
	

	SELECT last_insert_id() INTO in_sid;
		
	IF in_sid IS NULL THEN
		SET o_result = 0;
		ROLLBACK;
		
	ELSE
		INSERT INTO grade(s_id, kor, eng, mat)
		     VALUES (in_sid, i_kor, i_eng, i_mat);
		     
		SET o_result = 1;
		COMMIT;
	END IF;
END//
DELIMITER ;

-- 프로시저 homework1.select_student 구조 내보내기
DROP PROCEDURE IF EXISTS `select_student`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `select_student`()
BEGIN
	SELECT s.s_id, s.s_name, s.class, s.birth, s.gender, g.kor, g.eng, g.mat, g.total, g.avg, g.grade
	  FROM student s
	 INNER JOIN grade g ON s.s_id = g.s_id;
END//
DELIMITER ;

-- 테이블 homework1.student 구조 내보내기
DROP TABLE IF EXISTS `student`;
CREATE TABLE IF NOT EXISTS `student` (
  `s_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_name` varchar(20) NOT NULL,
  `class` char(1) NOT NULL,
  `birth` date DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='학생';

-- 테이블 데이터 homework1.student:~3 rows (대략적) 내보내기
DELETE FROM `student`;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
/*!40000 ALTER TABLE `student` ENABLE KEYS */;

-- 프로시저 homework1.update_student 구조 내보내기
DROP PROCEDURE IF EXISTS `update_student`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `update_student`(
	IN `i_sid` INT,
	IN `i_name` VARCHAR(50),
	IN `i_class` CHAR(1),
	IN `i_birth` DATE,
	IN `i_gender` CHAR(1),
	IN `i_kor` INT,
	IN `i_eng` INT,
	IN `i_mat` INT,
	OUT `o_result` INT


)
BEGIN
	DECLARE cnt INT DEFAULT 0;
	
	SELECT count(*) INTO cnt FROM student WHERE s_id = i_sid;
	
	IF cnt > 0 THEN
		START TRANSACTION;
		
		UPDATE student
		   SET s_name = i_name
		     , class = i_class
		     , birth = i_birth
		     , gender = i_gender
		 WHERE s_id = i_sid;
		 
		 UPDATE grade
		    SET kor = i_kor
		      , eng = i_eng
		      , mat = i_mat
		  WHERE s_id = i_sid;
		  
		COMMIT;
		
		SET o_result = 1;
	
	ELSE
		SET o_result = 0;
	END IF;
END//
DELIMITER ;

-- 트리거 homework1.grade_before_insert 구조 내보내기
DROP TRIGGER IF EXISTS `grade_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `grade_before_insert` BEFORE INSERT ON `grade` FOR EACH ROW BEGIN
	SET NEW.total = NEW.kor + NEW.eng + NEW.mat;
	SET NEW.avg = ROUND(NEW.total / 3, 2);
	IF     new.avg >= 90 THEN SET new.grade = 'A';
	ELSEIF new.avg >= 80 THEN SET new.grade = 'B';
	ELSEIF new.avg >= 70 THEN SET new.grade = 'C';
	ELSEIF new.avg >= 60 THEN SET new.grade = 'D';
	ELSE 							  SET new.grade = 'F';
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 트리거 homework1.grade_before_update 구조 내보내기
DROP TRIGGER IF EXISTS `grade_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `grade_before_update` BEFORE UPDATE ON `grade` FOR EACH ROW BEGIN
	SET NEW.total = NEW.kor + NEW.eng + NEW.mat;
	SET NEW.avg = ROUND(NEW.total / 3, 2);
	IF     new.avg >= 90 THEN SET new.grade = 'A';
	ELSEIF new.avg >= 80 THEN SET new.grade = 'B';
	ELSEIF new.avg >= 70 THEN SET new.grade = 'C';
	ELSEIF new.avg >= 60 THEN SET new.grade = 'D';
	ELSE 							  SET new.grade = 'F';
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
