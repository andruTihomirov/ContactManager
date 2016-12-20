CREATE DATABASE  IF NOT EXISTS `contactmanager` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `contactmanager`;
-- MySQL dump 10.13  Distrib 5.7.16, for Win64 (x86_64)
--
-- Host: localhost    Database: contactmanager
-- ------------------------------------------------------
-- Server version	5.7.16-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_user`
--

DROP TABLE IF EXISTS `app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sso_id` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `state` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sso_id` (`sso_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_user`
--

LOCK TABLES `app_user` WRITE;
/*!40000 ALTER TABLE `app_user` DISABLE KEYS */;
INSERT INTO `app_user` VALUES (1,'user','user','Vasia','Pupkin','user@user.com','Active'),(2,'admin','admin','Andru','Tihomirov','admin@admin.com','Active');
/*!40000 ALTER TABLE `app_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_user_user_profile`
--

DROP TABLE IF EXISTS `app_user_user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_user_user_profile` (
  `user_id` bigint(20) NOT NULL,
  `user_profile_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`user_profile_id`),
  KEY `FK_USER_PROFILE` (`user_profile_id`),
  CONSTRAINT `FK_APP_USER` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`),
  CONSTRAINT `FK_USER_PROFILE` FOREIGN KEY (`user_profile_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_user_user_profile`
--

LOCK TABLES `app_user_user_profile` WRITE;
/*!40000 ALTER TABLE `app_user_user_profile` DISABLE KEYS */;
INSERT INTO `app_user_user_profile` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `app_user_user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persistent_logins`
--

DROP TABLE IF EXISTS `persistent_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persistent_logins` (
  `username` varchar(64) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persistent_logins`
--

LOCK TABLES `persistent_logins` WRITE;
/*!40000 ALTER TABLE `persistent_logins` DISABLE KEYS */;
INSERT INTO `persistent_logins` VALUES ('user','8t6P1K1J43WNFQteqSL6ag==','24fZVeEBYF/oFLbK3XfRYQ==','2016-12-08 11:44:35'),('andru','ANzVSFl2Bxr6brT+u4Rd4Q==','iLU6lfFKtFs4Co5AKPDUpQ==','2016-12-08 09:39:41'),('admin','b0diis1BLLWikqjyN7iB/Q==','krlE4CAarZ/m2YDO22O3vA==','2016-12-20 11:45:24'),('andru','g5kNCSZkIkkhzEDgyKh4cw==','7F0xHOkpJXxTD8QvIs6L8Q==','2016-12-08 07:58:27'),('andru','GzRyCZazrt4gibO2Q886Ig==','gnJg+Cts6OgbXPEyOYeWQA==','2016-12-08 10:14:54'),('andru','JhIW2YSTX38UW367gP1xPQ==','Z4mEida07UfdjzZvIP+suQ==','2016-12-08 09:20:29'),('user','kC0Nn8gdIrXm767JM4KJkw==','gfZ5ZU5nkbrOtXNvMAr6xw==','2016-12-08 14:31:07'),('user','MCDibijo04gddDwSR2PLEw==','iY0wgc4JteO5u/+a7yKZtg==','2016-12-08 14:26:46'),('andru','oGGs5MyWF/WrsjbeWlTDKg==','TF+2+Ak97J2nE55MhUP8RA==','2016-12-08 09:01:12'),('andru','oYa/e6qVvxf9CE07Vxz0KQ==','dwitNQ10z9rGB6OOHHaSbA==','2016-12-08 08:33:09'),('andru','p1UHGdbiR1OZcp7kguMNjA==','3wGF7FTFGv/r2dB0eE1ZjQ==','2016-12-08 10:06:02'),('andru','P6cQOu9vYyTFMDdNZPZG0Q==','IcSNr+eHXuhvJUeagEilxg==','2016-12-08 09:33:40'),('andru','QNrLCQGz8oy9t8IibkwZwQ==','YqMc7f2nka/zp+s5IcWS9g==','2016-12-08 09:57:19'),('user','QoeltzD3zic6nCzhyELHtA==','9h+dU3RbSEjvY3Y3mn2e8A==','2016-12-08 15:20:07'),('user','qWq0i1Pbb0ZtKuPBOEND0g==','5/9FiyO/9G8q0J2Fw/wKHA==','2016-12-08 14:32:53'),('andru','rdxYcdLP3nqU1UWDEF4I4A==','yTUqOEezhQCQztZQ/lLCPg==','2016-12-08 10:09:34'),('user','s2umwS+vcXivUqqTKKsiew==','7KcK7QRrhdVTxxtekeqdxA==','2016-12-08 10:15:53'),('user','sfNtQCFBZv0MhPYD5flHEQ==','f2PQ/N6F05EsC82efq8T6g==','2016-12-08 14:21:08'),('andru','TEROeufiOkmVyLr922qaOw==','UbsbaVncdjhS6F53oB3y7A==','2016-12-08 07:47:10'),('user','TgbRKdq+CPxUvfoETM0bNw==','mOenz49Si2xA77v5B885/A==','2016-12-09 08:43:44'),('andru','usHRmpB8SJQIunplV85gZg==','TqgowUbHjb99nN9k65fzmQ==','2016-12-08 08:47:55'),('user','vaIjrY5QWDecjK1gp43lMQ==','LkemgY6j8UntVpoCDgJtnA==','2016-12-08 15:20:14'),('andru','Wdvl6CH1tQ1Z3+sut+jcNw==','LquM2MBeL7yOO+ExXkW0eA==','2016-12-08 09:38:06'),('user','Xit4d8zIPS8+j6RGujo6dg==','eqtbkczvS8o9+VYz5Wg5wQ==','2016-12-13 07:38:08');
/*!40000 ALTER TABLE `persistent_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `patronymic` varchar(45) DEFAULT NULL,
  `phoneNumbers` varchar(45) DEFAULT NULL,
  `dob` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `imagePath` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (2,'Princess','Leia',' - ',NULL,'01/01/1992','address2','/ContactManager/static/img/leia.gif'),(3,'Luke','Skywalker',' - ','+093495757223','01/01/1993','address3','/ContactManager/static/img/luke.gif'),(4,'Chewbacca',' - ',' - ','+234923874567','01/01/1994','address4','/ContactManager/static/img/chewbacca.gif'),(82,'Darth','Vader',' - ',NULL,'01/01/1991','address1','/ContactManager/static/img/darth.gif');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_phone`
--

DROP TABLE IF EXISTS `person_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_phone` (
  `person_id` bigint(20) NOT NULL,
  `phones_id` bigint(20) NOT NULL,
  UNIQUE KEY `UK_2tqmqajark65okqtsv5cg32dm` (`phones_id`),
  CONSTRAINT `FK_2tqmqajark65okqtsv5cg32dm` FOREIGN KEY (`phones_id`) REFERENCES `phone` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_phone`
--

LOCK TABLES `person_phone` WRITE;
/*!40000 ALTER TABLE `person_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone`
--

DROP TABLE IF EXISTS `phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) DEFAULT NULL,
  `person_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone`
--

LOCK TABLES `phone` WRITE;
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
INSERT INTO `phone` VALUES (106,'+789589745935',2),(107,'+789523333333',2),(108,'+093495757223',3),(109,'+093423543456',3),(110,'+234923874567',4),(111,'+234923872345',4),(122,'12334235',82),(123,'456756758',82);
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
INSERT INTO `user_profile` VALUES (2,'ADMIN'),(1,'USER');
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-20 14:49:25
