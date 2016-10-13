-- MySQL dump 10.13  Distrib 5.7.12, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: wall
-- ------------------------------------------------------
-- Server version	5.7.15

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` longtext,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `update` datetime DEFAULT CURRENT_TIMESTAMP,
  `message_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comment_message_idx` (`message_id`),
  KEY `fk_comment_user1_idx` (`user_id`),
  CONSTRAINT `fk_comment_message` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'This is my first  Comment','2016-10-12 20:13:03','2016-10-12 20:13:03',1,3),(2,'This is Awsome','2016-10-12 20:14:05','2016-10-12 20:14:05',2,3),(3,'So what!!!!','2016-10-12 20:14:25','2016-10-12 20:14:25',5,3),(4,'Thta it so awsome that you like my Wall','2016-10-13 07:44:10','2016-10-13 07:44:10',1,1),(5,'i forgot to tell you this is awesome i am doing this for the first time.','2016-10-13 07:44:45','2016-10-13 07:44:45',1,1),(6,'I fort to tell you this need a little bit of css','2016-10-13 08:01:28','2016-10-13 08:01:28',2,3),(7,'Awsome!!!!!!!!','2016-10-13 08:12:00','2016-10-13 08:12:00',1,3),(8,'That is awsome','2016-10-13 10:40:13','2016-10-13 10:40:13',1,8),(9,'Hi','2016-10-13 11:00:23','2016-10-13 11:00:23',1,11);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` longtext,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_message_user1_idx` (`user_id`),
  CONSTRAINT `fk_message_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'Hello world \r\n\r\nthis is my first message','2016-10-12 16:56:31','2016-10-12 16:56:31',1),(2,'This database is not that big. What do you think....','2016-10-12 16:59:28','2016-10-12 16:59:28',1),(3,'Hi this is Diego. \r\nI like it this wall','2016-10-12 17:37:10','2016-10-12 17:37:10',3),(4,'Hola felipe como estas\r\n','2016-10-12 17:39:27','2016-10-12 17:39:27',3),(5,'Good afternoon\r\n\r\nthis is the administrator of this wall','2016-10-12 18:17:31','2016-10-12 18:17:31',1),(6,'This is my First message','2016-10-13 10:59:49','2016-10-13 10:59:49',11);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) DEFAULT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Francisco','Trujillo','franciscoj.trujillo@papelex.net','$2b$12$XxOYNINVhpZDDwQWOl3DJeGGKGSFcMNZEvzpMiB4xMrcxixb3.idC','2016-10-12 14:07:49','2016-10-12 14:07:49'),(3,'Diego','Trujillo','trujillodiegoa@gmail.com','$2b$12$L6qKLUTdUVExYYDRkCItqOctaiYKuM/BhyWScY4ut5mjNIW.h6va6','2016-10-12 14:15:23','2016-10-12 14:15:23'),(4,'Felipe','Velez','elcaliente@hotmail.com','$2b$12$JY08JPd6bP81gAqr.r/sv.dRF5wB5gHEW4t8.E7d8228cmH9BymDC','2016-10-13 10:19:35','2016-10-13 10:19:35'),(5,'Gonzalo','Smith','gonzo@gmail.com','$2b$12$1AG.cdnK0ci/6CXSj1i6ZeRq2PFbYHyU8./Jkfa7z9s8TfTEXoDLG','2016-10-13 10:21:49','2016-10-13 10:21:49'),(6,'Antonio','Gomez','gm@gmail.com','$2b$12$4fJtFvFY3Dx9zpwL.GsVJOfCkFvcHoJgSOiGQ3gBT4rXHD9IUAKL6','2016-10-13 10:29:31','2016-10-13 10:29:31'),(7,'Lore','Vera','vlvlv1@gmail.com','$2b$12$rGu8iaTf/sCphCOfPISmpO2US8Uxx9NbOENT/T0dBcdHHJ1.1DSe.','2016-10-13 10:33:35','2016-10-13 10:33:35'),(8,'Lorena','Soto','sot@www.com','$2b$12$37j0LOW/UvOj9QIHK5Ff9eNTYaEv6dE7aVejgNhjLwYUUYeAw1m3i','2016-10-13 10:38:20','2016-10-13 10:38:20'),(9,'Rob','Bob','aa@aa.co','$2b$12$hoiwMAvsE2/y6D2gUm0O7eD07zKr1YGH4ClHppNb6qiaijCkEbajC','2016-10-13 10:49:08','2016-10-13 10:49:08'),(10,'xxx','qwe','11@qe.cv','$2b$12$U7YBsBYZu2mb8sEHW.IjVu7YXnav5fORKQRH7nOhZAbS4BXYrkA86','2016-10-13 10:52:34','2016-10-13 10:52:34'),(11,'Velex','aaa','aa@jj.com','$2b$12$rBUqBbvD2ikEN7IUARsayu1MNyYsjyLm5PkqvZjS4mZ2aE/kyGCuS','2016-10-13 10:57:11','2016-10-13 10:57:11');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-13 13:14:19
