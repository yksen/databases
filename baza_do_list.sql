-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: oly_test_zamow
-- ------------------------------------------------------
-- Server version	5.7.21-0ubuntu0.16.04.1

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
-- Table structure for table `detal_zamow`
--

DROP TABLE IF EXISTS `detal_zamow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detal_zamow` (
  `idd` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `z_id` int(10) unsigned DEFAULT NULL,
  `p_id` int(10) unsigned DEFAULT NULL,
  `sztuk` int(11) DEFAULT NULL,
  PRIMARY KEY (`idd`),
  KEY `z_ind` (`z_id`),
  KEY `p_ind` (`p_id`),
  CONSTRAINT `detal_zamow_ibfk_1` FOREIGN KEY (`z_id`) REFERENCES `zamow` (`idz`) ON UPDATE CASCADE,
  CONSTRAINT `detal_zamow_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `produkty` (`idp`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detal_zamow`
--

LOCK TABLES `detal_zamow` WRITE;
/*!40000 ALTER TABLE `detal_zamow` DISABLE KEYS */;
INSERT INTO `detal_zamow` VALUES (1,2,3,3),(2,2,1,1),(3,3,1,5),(4,3,3,2),(5,4,6,5),(6,5,7,1),(7,5,4,7),(8,5,1,2),(11,21,4,2),(14,15,1,1),(15,15,5,2),(16,39,7,1),(18,41,1,2),(20,43,4,2),(22,45,5,2),(24,48,8,1),(25,52,18,2),(26,52,34,1),(27,52,32,1),(28,51,17,2),(29,51,4,2),(30,50,34,1),(31,50,33,1),(32,50,32,2),(33,49,15,3),(34,49,17,3),(35,41,18,3);
/*!40000 ALTER TABLE `detal_zamow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `klienci`
--

DROP TABLE IF EXISTS `klienci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `klienci` (
  `idk` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(50) NOT NULL,
  `miasto` varchar(25) NOT NULL,
  `adres` varchar(50) DEFAULT NULL,
  `telefon` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idk`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `klienci`
--

LOCK TABLES `klienci` WRITE;
/*!40000 ALTER TABLE `klienci` DISABLE KEYS */;
INSERT INTO `klienci` VALUES (1,'Astro','Wrocław','Cybulskiego 12/2','0713229563'),(2,'BCA','Wrocław','ul. Pomorska 321/12','0719563372'),(3,'XYZ','Wrocław','Pl. Borna 5/1','0713753372'),(4,'ERE','Warszawa','Marszałkowska 1 /2','0221122563'),(5,'OCY','Łódź','ul. Piotrkowska 111/1 ','0427213372'),(6,'ATest','Wrocław','Nozownicza 1','606753717'),(7,'JAFO','Toruń','Wirtualna ','765092123'),(8,'Cesoft','Wrocław','Rynek 0','456789765'),(12,'INNOV','Warszawa','Marszałkowska 1','0223456712'),(24,'Jan Kowalczyk','Wrocław','Opolska 119c','666777888'),(27,'SP201','Wrocław','Borna 4','567321555');
/*!40000 ALTER TABLE `klienci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkty`
--

DROP TABLE IF EXISTS `produkty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkty` (
  `idp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) NOT NULL,
  `cena` float(10,2) DEFAULT NULL,
  `ilosc` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idp`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkty`
--

LOCK TABLES `produkty` WRITE;
/*!40000 ALTER TABLE `produkty` DISABLE KEYS */;
INSERT INTO `produkty` VALUES (1,'laptop',1999.00,12),(2,'plazma48',2199.00,3),(3,'Samsung Galaxy S7',1799.99,10),(4,'tablet',999.00,21),(5,'smartfon',499.00,13),(6,'Iphone_6',1529.00,10),(7,'Iphone_6_plus',2899.00,2),(8,'Asus R75VJ',2009.00,8),(15,'laptop asus',1599.00,8),(17,'HUAWEI P9',1105.00,13),(18,'Samsung Galaxy J5',889.00,12),(32,'laptop dell',2999.00,5),(33,'Apple Iphone 8',3152.00,2),(34,'Apple Watch 3',1590.00,7);
/*!40000 ALTER TABLE `produkty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zamow`
--

DROP TABLE IF EXISTS `zamow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zamow` (
  `idz` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `k_id` int(10) unsigned DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idz`),
  KEY `k_ind` (`k_id`),
  KEY `kid` (`k_id`),
  CONSTRAINT `zamow_ibfk_1` FOREIGN KEY (`k_id`) REFERENCES `klienci` (`idk`) ON UPDATE CASCADE,
  CONSTRAINT `zamow_ibfk_2` FOREIGN KEY (`k_id`) REFERENCES `klienci` (`idk`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zamow`
--

LOCK TABLES `zamow` WRITE;
/*!40000 ALTER TABLE `zamow` DISABLE KEYS */;
INSERT INTO `zamow` VALUES (2,1,'2017-03-24 11:26:22'),(3,3,'2017-03-24 11:32:54'),(4,4,'2017-03-30 10:16:02'),(5,4,'2017-04-05 14:45:34'),(15,7,'2017-05-23 09:56:52'),(21,4,'2017-05-29 14:04:29'),(39,27,'2017-05-30 09:39:33'),(41,24,'2017-05-30 09:51:37'),(43,2,'2017-08-28 09:59:30'),(45,7,'2017-09-17 10:21:58'),(48,8,'2017-10-30 17:19:36'),(49,5,'2017-11-16 16:40:02'),(50,12,'2017-10-02 15:41:12'),(51,8,'2017-06-24 15:47:22'),(52,2,'2017-05-05 15:48:40');
/*!40000 ALTER TABLE `zamow` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-14 18:54:32
