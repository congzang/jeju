-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.4.11-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- teamdb 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `teamdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `teamdb`;

-- 테이블 teamdb.recipe 구조 내보내기
CREATE TABLE IF NOT EXISTS `recipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '아이디',
  `label_no` int(11) DEFAULT NULL COMMENT '모델에서 라벨 번호',
  `food_name` varchar(200) NOT NULL COMMENT '음식명',
  `ingredient` varchar(1000) DEFAULT NULL COMMENT '요리재료',
  `ingredient_image_path` varchar(100) NOT NULL COMMENT '요리재료 이미지 경로',
  `recipe_text` varchar(5000) DEFAULT NULL COMMENT '조리법 텍스트',
  `recipe_image_path` varchar(300) DEFAULT NULL COMMENT '조리법 이미지 경로',
  `site_name` varchar(100) DEFAULT NULL COMMENT '참고 사이트명',
  `site_address` varchar(300) DEFAULT NULL COMMENT '참고 사이트 주소',
  `create_date` datetime NOT NULL DEFAULT sysdate() COMMENT '생성일자',
  `update_date` datetime DEFAULT sysdate() COMMENT '수정일자',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
