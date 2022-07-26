-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: 172.20.0.3    Database: espocrm
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(249) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `industry` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `sic_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_NAME` (`name`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('62e03bfb479a14e0a','Hans Krüger MBA.',0,'www.test.de','Customer','Advertising',NULL,'Stresemannstrasse 8','Hanau','Hesse','63450',NULL,'Stresemannstrasse 8','Hanau','Hesse',NULL,'63450','Discover','2022-07-26 19:09:47','2022-07-26 19:09:47',NULL,'1',NULL,'1');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_contact`
--

DROP TABLE IF EXISTS `account_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_inactive` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ACCOUNT_ID_CONTACT_ID` (`account_id`,`contact_id`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_contact`
--

LOCK TABLES `account_contact` WRITE;
/*!40000 ALTER TABLE `account_contact` DISABLE KEYS */;
INSERT INTO `account_contact` VALUES (1,'62e03bfb479a14e0a','62e03c4b7dcb1e8c8','',0,0);
/*!40000 ALTER TABLE `account_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_document`
--

DROP TABLE IF EXISTS `account_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_document` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ACCOUNT_ID_DOCUMENT_ID` (`account_id`,`document_id`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_DOCUMENT_ID` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_document`
--

LOCK TABLES `account_document` WRITE;
/*!40000 ALTER TABLE `account_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_portal_user`
--

DROP TABLE IF EXISTS `account_portal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_portal_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ID_ACCOUNT_ID` (`user_id`,`account_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_ACCOUNT_ID` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_portal_user`
--

LOCK TABLES `account_portal_user` WRITE;
/*!40000 ALTER TABLE `account_portal_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_portal_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_target_list`
--

DROP TABLE IF EXISTS `account_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_target_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ACCOUNT_ID_TARGET_LIST_ID` (`account_id`,`target_list_id`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_target_list`
--

LOCK TABLES `account_target_list` WRITE;
/*!40000 ALTER TABLE `account_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_target_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `action_history_record`
--

DROP TABLE IF EXISTS `action_history_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action_history_record` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `number` int unsigned NOT NULL AUTO_INCREMENT,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `ip_address` varchar(39) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_token_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_log_record_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_TARGET` (`target_type`,`target_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_AUTH_TOKEN_ID` (`auth_token_id`),
  KEY `IDX_AUTH_LOG_RECORD_ID` (`auth_log_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_history_record`
--

LOCK TABLES `action_history_record` WRITE;
/*!40000 ALTER TABLE `action_history_record` DISABLE KEYS */;
INSERT INTO `action_history_record` VALUES ('62e03b2c37c1c4cf6',0,1,'User',NULL,'create','2022-07-26 19:06:20','172.20.0.1','62e03b2c309ae86c7','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03b2c51c9552e8',0,2,'User',NULL,'read','2022-07-26 19:06:20','172.20.0.1','62e03b2c309ae86c7','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03b5c7cfefe85f',0,3,'Team',NULL,'create','2022-07-26 19:07:08','172.20.0.1','62e03b5c795a9cec6','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03b5c94123f804',0,4,'Team',NULL,'read','2022-07-26 19:07:08','172.20.0.1','62e03b5c795a9cec6','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03bfb590c7df02',0,5,'Account',NULL,'create','2022-07-26 19:09:47','172.20.0.1','62e03bfb479a14e0a','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03bfb7316d817f',0,6,'Account',NULL,'read','2022-07-26 19:09:47','172.20.0.1','62e03bfb479a14e0a','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03c03b17425d1a',0,7,'Team',NULL,'read','2022-07-26 19:09:55','172.20.0.1','62e03b5c795a9cec6','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03c05b7746815f',0,8,'User',NULL,'read','2022-07-26 19:09:57','172.20.0.1','62e03b2c309ae86c7','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03c4b9285f09be',0,9,'Contact',NULL,'create','2022-07-26 19:11:07','172.20.0.1','62e03c4b7dcb1e8c8','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03c4baa2e2515d',0,10,'Contact',NULL,'read','2022-07-26 19:11:07','172.20.0.1','62e03c4b7dcb1e8c8','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03eb0f13b2d1b3',0,11,'Lead',NULL,'create','2022-07-26 19:21:20','172.20.0.1','62e03eb0e440675fe','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03eb117147ace6',0,12,'Lead',NULL,'read','2022-07-26 19:21:21','172.20.0.1','62e03eb0e440675fe','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03eca41b948b32',0,13,'Lead',NULL,'update','2022-07-26 19:21:46','172.20.0.1','62e03eb0e440675fe','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03ed194eaffd27',0,14,'Lead',NULL,'update','2022-07-26 19:21:53','172.20.0.1','62e03eb0e440675fe','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03f05a7c0b55aa',0,15,'Opportunity',NULL,'create','2022-07-26 19:22:45','172.20.0.1','62e03f059a3ffb7a9','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03f05bd8392360',0,16,'Opportunity',NULL,'read','2022-07-26 19:22:45','172.20.0.1','62e03f059a3ffb7a9','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03f29b1dfb4d2f',0,17,'Case',NULL,'create','2022-07-26 19:23:21','172.20.0.1','62e03f29a380cbb50','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03f29caca3b7cd',0,18,'Case',NULL,'read','2022-07-26 19:23:21','172.20.0.1','62e03f29a380cbb50','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03f9a63ece2592',0,19,'EmailAccount',NULL,'create','2022-07-26 19:25:14','172.20.0.1','62e03f9a5b757a6fe','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03f9a808db624d',0,20,'EmailAccount',NULL,'read','2022-07-26 19:25:14','172.20.0.1','62e03f9a5b757a6fe','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03fb59980b709e',0,21,'EmailAccount',NULL,'read','2022-07-26 19:25:41','172.20.0.1','62e03f9a5b757a6fe','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03fe039666a586',0,22,'Call',NULL,'create','2022-07-26 19:26:24','172.20.0.1','62e03fe028552cd3a','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03ff63b05e217a',0,23,'Meeting',NULL,'create','2022-07-26 19:26:46','172.20.0.1','62e03ff62a78e58a1','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03ff654f25c97b',0,24,'Meeting',NULL,'read','2022-07-26 19:26:46','172.20.0.1','62e03ff62a78e58a1','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e03ffa446129585',0,25,'Meeting',NULL,'read','2022-07-26 19:26:50','172.20.0.1','62e03ff62a78e58a1','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040079da5b1a9c',0,26,'Meeting',NULL,'update','2022-07-26 19:27:03','172.20.0.1','62e03ff62a78e58a1','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e0402d9e791949b',0,27,'Task',NULL,'create','2022-07-26 19:27:41','172.20.0.1','62e0402d9225477e6','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e0402db33c8e0cc',0,28,'Task',NULL,'read','2022-07-26 19:27:41','172.20.0.1','62e0402d9225477e6','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e0405c05b91a212',0,29,'Attachment',NULL,'create','2022-07-26 19:28:28','172.20.0.1','62e0405c021518ded','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e0405e9253385b4',0,30,'Document',NULL,'create','2022-07-26 19:28:30','172.20.0.1','62e0405e8c05a53c5','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e04068556fd32e7',0,31,'Document',NULL,'read','2022-07-26 19:28:40','172.20.0.1','62e0405e8c05a53c5','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e04099ba60f0968',0,32,'Campaign',NULL,'create','2022-07-26 19:29:29','172.20.0.1','62e04099b15ac572c','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e04099d3ac75d61',0,33,'Campaign',NULL,'read','2022-07-26 19:29:29','172.20.0.1','62e04099b15ac572c','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040ace8028d87b',0,34,'KnowledgeBaseArticle',NULL,'create','2022-07-26 19:29:48','172.20.0.1','62e040ace2f561261','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040c04f333c488',0,35,'Opportunity',NULL,'read','2022-07-26 19:30:08','172.20.0.1','62e03f059a3ffb7a9','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040d381f2adb9c',0,36,'Opportunity',NULL,'update','2022-07-26 19:30:27','172.20.0.1','62e03f059a3ffb7a9','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040db2857f37ef',0,37,'Case',NULL,'read','2022-07-26 19:30:35','172.20.0.1','62e03f29a380cbb50','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040e36c0a689a5',0,38,'Case',NULL,'update','2022-07-26 19:30:43','172.20.0.1','62e03f29a380cbb50','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040ea7eee15342',0,39,'Meeting',NULL,'read','2022-07-26 19:30:50','172.20.0.1','62e03ff62a78e58a1','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040f62f3aaf3ba',0,40,'Meeting',NULL,'update','2022-07-26 19:31:02','172.20.0.1','62e03ff62a78e58a1','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040f8f2592cb00',0,41,'Call',NULL,'read','2022-07-26 19:31:04','172.20.0.1','62e03fe028552cd3a','1','62e03abc78c52dabb','62e03abc7a695da3a'),('62e040fd5cd394b86',0,42,'Call',NULL,'update','2022-07-26 19:31:09','172.20.0.1','62e03fe028552cd3a','1','62e03abc78c52dabb','62e03abc7a695da3a');
/*!40000 ALTER TABLE `action_history_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `array_value`
--

DROP TABLE IF EXISTS `array_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `array_value` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_TYPE_VALUE` (`entity_type`,`value`),
  KEY `IDX_ENTITY_VALUE` (`entity_type`,`entity_id`,`value`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `array_value`
--

LOCK TABLES `array_value` WRITE;
/*!40000 ALTER TABLE `array_value` DISABLE KEYS */;
INSERT INTO `array_value` VALUES ('62e03f9a60466b529',0,'INBOX','monitoredFolders','62e03f9a5b757a6fe','EmailAccount');
/*!40000 ALTER TABLE `array_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachment` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int DEFAULT NULL,
  `source_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `role` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_file_path` varchar(260) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `global` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_PARENT` (`parent_type`,`parent_id`),
  KEY `IDX_SOURCE_ID` (`source_id`),
  KEY `IDX_RELATED` (`related_id`,`related_type`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment`
--

LOCK TABLES `attachment` WRITE;
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
INSERT INTO `attachment` VALUES ('62e0405c021518ded','howto.txt',0,'text/plain',3967,NULL,'file','2022-07-26 19:28:28','Attachment','EspoUploadDir',NULL,0,NULL,NULL,'62e0405e8c05a53c5','Document','1');
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_log_record`
--

DROP TABLE IF EXISTS `auth_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_log_record` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `is_denied` tinyint(1) NOT NULL DEFAULT '0',
  `denial_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_time` double DEFAULT NULL,
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_method` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authentication_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portal_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_token_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IP_ADDRESS` (`ip_address`),
  KEY `IDX_IP_ADDRESS_REQUEST_TIME` (`ip_address`,`request_time`),
  KEY `IDX_REQUEST_TIME` (`request_time`),
  KEY `IDX_PORTAL_ID` (`portal_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_AUTH_TOKEN_ID` (`auth_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_log_record`
--

LOCK TABLES `auth_log_record` WRITE;
/*!40000 ALTER TABLE `auth_log_record` DISABLE KEYS */;
INSERT INTO `auth_log_record` VALUES ('62e03abc7a695da3a',0,'admin','172.20.0.1','2022-07-26 19:04:28',0,NULL,1658862268.4092,'http://localhost/api/v1/App/user','GET','Espo',NULL,'1','62e03abc78c52dabb');
/*!40000 ALTER TABLE `auth_log_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_token`
--

DROP TABLE IF EXISTS `auth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_token` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `token` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hash` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `last_access` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `portal_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_TOKEN` (`token`,`deleted`),
  KEY `IDX_HASH` (`hash`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_token`
--

LOCK TABLES `auth_token` WRITE;
/*!40000 ALTER TABLE `auth_token` DISABLE KEYS */;
INSERT INTO `auth_token` VALUES ('62e03abc78c52dabb',0,'711259c15ea0eef29684280a86a921c4','yQb/Foiz2ZN6XU8DemFwuq78wN/xiqdzvjzvUi55JbQXGXJ8wCTcweLfsf7Xk9ZIlZ5e5rFtSov3wMXYLprkz0','20703cc7e45e11f8f4ad503839314ac0','1','172.20.0.1',1,'2022-07-26 19:39:04','2022-07-26 19:04:28','2022-07-26 19:39:04',NULL);
/*!40000 ALTER TABLE `auth_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autofollow`
--

DROP TABLE IF EXISTS `autofollow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autofollow` (
  `id` int NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_TYPE` (`entity_type`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autofollow`
--

LOCK TABLES `autofollow` WRITE;
/*!40000 ALTER TABLE `autofollow` DISABLE KEYS */;
/*!40000 ALTER TABLE `autofollow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call`
--

DROP TABLE IF EXISTS `call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `call` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Planned',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `direction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Outbound',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DATE_START_STATUS` (`date_start`,`status`),
  KEY `IDX_DATE_START` (`date_start`,`deleted`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call`
--

LOCK TABLES `call` WRITE;
/*!40000 ALTER TABLE `call` DISABLE KEYS */;
INSERT INTO `call` VALUES ('62e03fe028552cd3a','Call1',0,'Planned','2022-07-26 06:00:00','2022-07-26 06:30:00','Outbound',NULL,'2022-07-26 19:26:24','2022-07-26 19:31:09','62e03bfb479a14e0a','Account','62e03bfb479a14e0a','1','1','62e03b2c309ae86c7');
/*!40000 ALTER TABLE `call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_contact`
--

DROP TABLE IF EXISTS `call_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `call_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CALL_ID_CONTACT_ID` (`call_id`,`contact_id`),
  KEY `IDX_CALL_ID` (`call_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_contact`
--

LOCK TABLES `call_contact` WRITE;
/*!40000 ALTER TABLE `call_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_lead`
--

DROP TABLE IF EXISTS `call_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_lead` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `call_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CALL_ID_LEAD_ID` (`call_id`,`lead_id`),
  KEY `IDX_CALL_ID` (`call_id`),
  KEY `IDX_LEAD_ID` (`lead_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_lead`
--

LOCK TABLES `call_lead` WRITE;
/*!40000 ALTER TABLE `call_lead` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_user`
--

DROP TABLE IF EXISTS `call_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `call_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ID_CALL_ID` (`user_id`,`call_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_CALL_ID` (`call_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_user`
--

LOCK TABLES `call_user` WRITE;
/*!40000 ALTER TABLE `call_user` DISABLE KEYS */;
INSERT INTO `call_user` VALUES (1,'62e03b2c309ae86c7','62e03fe028552cd3a','None',0);
/*!40000 ALTER TABLE `call_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Planning',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Email',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `budget` double DEFAULT NULL,
  `mail_merge_only_with_address` tinyint(1) NOT NULL DEFAULT '1',
  `budget_currency` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contacts_template_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `leads_template_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accounts_template_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `users_template_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CONTACTS_TEMPLATE_ID` (`contacts_template_id`),
  KEY `IDX_LEADS_TEMPLATE_ID` (`leads_template_id`),
  KEY `IDX_ACCOUNTS_TEMPLATE_ID` (`accounts_template_id`),
  KEY `IDX_USERS_TEMPLATE_ID` (`users_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
INSERT INTO `campaign` VALUES ('62e04099b15ac572c','Campaign1',0,'Planning','Television','2022-07-26','2022-07-30','tst','2022-07-26 19:29:29','2022-07-26 19:29:29',1111,1,'USD','1',NULL,'62e03b2c309ae86c7',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_log_record`
--

DROP TABLE IF EXISTS `campaign_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_log_record` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_date` datetime DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `string_data` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `string_additional_data` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `application` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Espo',
  `created_at` datetime DEFAULT NULL,
  `is_test` tinyint(1) NOT NULL DEFAULT '0',
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `object_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `object_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `queue_item_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ACTION_DATE` (`action_date`,`deleted`),
  KEY `IDX_ACTION` (`action`,`deleted`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_OBJECT` (`object_id`,`object_type`),
  KEY `IDX_QUEUE_ITEM_ID` (`queue_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_log_record`
--

LOCK TABLES `campaign_log_record` WRITE;
/*!40000 ALTER TABLE `campaign_log_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_log_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_target_list`
--

DROP TABLE IF EXISTS `campaign_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_target_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CAMPAIGN_ID_TARGET_LIST_ID` (`campaign_id`,`target_list_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_target_list`
--

LOCK TABLES `campaign_target_list` WRITE;
/*!40000 ALTER TABLE `campaign_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_target_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_target_list_excluding`
--

DROP TABLE IF EXISTS `campaign_target_list_excluding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_target_list_excluding` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CAMPAIGN_ID_TARGET_LIST_ID` (`campaign_id`,`target_list_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_target_list_excluding`
--

LOCK TABLES `campaign_target_list_excluding` WRITE;
/*!40000 ALTER TABLE `campaign_target_list_excluding` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_target_list_excluding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_tracking_url`
--

DROP TABLE IF EXISTS `campaign_tracking_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_tracking_url` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Redirect',
  `message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `modified_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_tracking_url`
--

LOCK TABLES `campaign_tracking_url` WRITE;
/*!40000 ALTER TABLE `campaign_tracking_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_tracking_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case`
--

DROP TABLE IF EXISTS `case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `number` int unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'New',
  `priority` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Normal',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_LEAD_ID` (`lead_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case`
--

LOCK TABLES `case` WRITE;
/*!40000 ALTER TABLE `case` DISABLE KEYS */;
INSERT INTO `case` VALUES ('62e03f29a380cbb50','Case1',0,1,'New','Normal','Question','Description','2022-07-26 19:23:21','2022-07-26 19:30:43','62e03bfb479a14e0a',NULL,'62e03c4b7dcb1e8c8',NULL,'1','1','62e03b2c309ae86c7');
/*!40000 ALTER TABLE `case` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_contact`
--

DROP TABLE IF EXISTS `case_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `case_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CASE_ID_CONTACT_ID` (`case_id`,`contact_id`),
  KEY `IDX_CASE_ID` (`case_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_contact`
--

LOCK TABLES `case_contact` WRITE;
/*!40000 ALTER TABLE `case_contact` DISABLE KEYS */;
INSERT INTO `case_contact` VALUES (1,'62e03f29a380cbb50','62e03c4b7dcb1e8c8',0);
/*!40000 ALTER TABLE `case_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_knowledge_base_article`
--

DROP TABLE IF EXISTS `case_knowledge_base_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_knowledge_base_article` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `case_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `knowledge_base_article_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CASE_ID_KNOWLEDGE_BASE_ARTICLE_ID` (`case_id`,`knowledge_base_article_id`),
  KEY `IDX_CASE_ID` (`case_id`),
  KEY `IDX_KNOWLEDGE_BASE_ARTICLE_ID` (`knowledge_base_article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_knowledge_base_article`
--

LOCK TABLES `case_knowledge_base_article` WRITE;
/*!40000 ALTER TABLE `case_knowledge_base_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `case_knowledge_base_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `salutation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `do_not_call` tinyint(1) NOT NULL DEFAULT '0',
  `address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `middle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_FIRST_NAME` (`first_name`,`deleted`),
  KEY `IDX_NAME` (`first_name`,`last_name`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES ('62e03c4b7dcb1e8c8','Hans Krüger',0,'Mr.','Hans','Krüger','Germany',0,'Stresemannstrasse 8','Hanau','Hesse','Germany','63450','2022-07-26 19:11:07','2022-07-26 19:11:07',NULL,'62e03bfb479a14e0a',NULL,'1',NULL,'62e03b2c309ae86c7');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_document`
--

DROP TABLE IF EXISTS `contact_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_document` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CONTACT_ID_DOCUMENT_ID` (`contact_id`,`document_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_DOCUMENT_ID` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_document`
--

LOCK TABLES `contact_document` WRITE;
/*!40000 ALTER TABLE `contact_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_meeting`
--

DROP TABLE IF EXISTS `contact_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_meeting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meeting_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CONTACT_ID_MEETING_ID` (`contact_id`,`meeting_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_MEETING_ID` (`meeting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_meeting`
--

LOCK TABLES `contact_meeting` WRITE;
/*!40000 ALTER TABLE `contact_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_opportunity`
--

DROP TABLE IF EXISTS `contact_opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_opportunity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opportunity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CONTACT_ID_OPPORTUNITY_ID` (`contact_id`,`opportunity_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_OPPORTUNITY_ID` (`opportunity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_opportunity`
--

LOCK TABLES `contact_opportunity` WRITE;
/*!40000 ALTER TABLE `contact_opportunity` DISABLE KEYS */;
INSERT INTO `contact_opportunity` VALUES (1,'62e03c4b7dcb1e8c8','62e03f059a3ffb7a9','',0);
/*!40000 ALTER TABLE `contact_opportunity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_target_list`
--

DROP TABLE IF EXISTS `contact_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_target_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CONTACT_ID_TARGET_LIST_ID` (`contact_id`,`target_list_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_target_list`
--

LOCK TABLES `contact_target_list` WRITE;
/*!40000 ALTER TABLE `contact_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_target_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `rate` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES ('USD',0,1);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_template`
--

DROP TABLE IF EXISTS `dashboard_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_template` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `layout` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `dashlets_options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_template`
--

LOCK TABLES `dashboard_template` WRITE;
/*!40000 ALTER TABLE `dashboard_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `file_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_FOLDER_ID` (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
INSERT INTO `document` VALUES ('62e0405e8c05a53c5','howto.txt',0,'Active',NULL,'2022-07-26',NULL,'tst','2022-07-26 19:28:30','2022-07-26 19:28:30','62e0405c021518ded','1',NULL,NULL,NULL);
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_folder`
--

DROP TABLE IF EXISTS `document_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_folder` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_folder`
--

LOCK TABLES `document_folder` WRITE;
/*!40000 ALTER TABLE `document_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_folder_path`
--

DROP TABLE IF EXISTS `document_folder_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_folder_path` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ascendor_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descendor_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASCENDOR_ID` (`ascendor_id`),
  KEY `IDX_DESCENDOR_ID` (`descendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_folder_path`
--

LOCK TABLES `document_folder_path` WRITE;
/*!40000 ALTER TABLE `document_folder_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_folder_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_lead`
--

DROP TABLE IF EXISTS `document_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_lead` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `document_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_DOCUMENT_ID_LEAD_ID` (`document_id`,`lead_id`),
  KEY `IDX_DOCUMENT_ID` (`document_id`),
  KEY `IDX_LEAD_ID` (`lead_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_lead`
--

LOCK TABLES `document_lead` WRITE;
/*!40000 ALTER TABLE `document_lead` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_opportunity`
--

DROP TABLE IF EXISTS `document_opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_opportunity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `document_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opportunity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_DOCUMENT_ID_OPPORTUNITY_ID` (`document_id`,`opportunity_id`),
  KEY `IDX_DOCUMENT_ID` (`document_id`),
  KEY `IDX_OPPORTUNITY_ID` (`opportunity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_opportunity`
--

LOCK TABLES `document_opportunity` WRITE;
/*!40000 ALTER TABLE `document_opportunity` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_opportunity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `from_string` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_to_string` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_name_map` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_replied` tinyint(1) NOT NULL DEFAULT '0',
  `message_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message_id_internal` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body_plain` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_html` tinyint(1) NOT NULL DEFAULT '1',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Archived',
  `has_attachment` tinyint(1) NOT NULL DEFAULT '0',
  `date_sent` datetime DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT '0',
  `ics_contents` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ics_event_uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_email_address_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `replied_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_event_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_event_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_DATE_SENT` (`date_sent`,`deleted`),
  KEY `IDX_DATE_SENT_STATUS` (`date_sent`,`status`,`deleted`),
  KEY `IDX_MESSAGE_ID` (`message_id`),
  KEY `IDX_ICS_EVENT_UID` (`ics_event_uid`),
  KEY `IDX_FROM_EMAIL_ADDRESS_ID` (`from_email_address_id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_SENT_BY_ID` (`sent_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_REPLIED_ID` (`replied_id`),
  KEY `IDX_CREATED_EVENT` (`created_event_id`,`created_event_type`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  FULLTEXT KEY `IDX_SYSTEM_FULL_TEXT_SEARCH` (`name`,`body_plain`,`body`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_account`
--

DROP TABLE IF EXISTS `email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_account` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `email_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` int DEFAULT '993',
  `security` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'SSL',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monitored_folders` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sent_folder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_sent_emails` tinyint(1) NOT NULL DEFAULT '0',
  `keep_fetched_emails_unread` tinyint(1) NOT NULL DEFAULT '0',
  `fetch_since` date DEFAULT NULL,
  `fetch_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `use_imap` tinyint(1) NOT NULL DEFAULT '1',
  `use_smtp` tinyint(1) NOT NULL DEFAULT '0',
  `smtp_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_port` int DEFAULT '587',
  `smtp_auth` tinyint(1) NOT NULL DEFAULT '1',
  `smtp_security` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TLS',
  `smtp_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_auth_mechanism` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'login',
  `imap_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_folder_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EMAIL_FOLDER_ID` (`email_folder_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_account`
--

LOCK TABLES `email_account` WRITE;
/*!40000 ALTER TABLE `email_account` DISABLE KEYS */;
INSERT INTO `email_account` VALUES ('62e03f9a5b757a6fe','admin@localhost.localhost',0,'admin@localhost.localhost','Active','localhost',993,'SSL','blabla','xRqtPKYUDx1c/AV/vR8uHIVAZTvjZFuTLqyoub0Pi4Q=','[\"INBOX\"]',NULL,0,0,'2022-07-26',NULL,'2022-07-26 19:25:14','2022-07-26 19:25:14',1,0,NULL,587,1,'TLS',NULL,NULL,'login',NULL,NULL,NULL,'1','1','1');
/*!40000 ALTER TABLE `email_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_address`
--

DROP TABLE IF EXISTS `email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_address` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `lower` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invalid` tinyint(1) NOT NULL DEFAULT '0',
  `opt_out` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_LOWER` (`lower`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_address`
--

LOCK TABLES `email_address` WRITE;
/*!40000 ALTER TABLE `email_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_email_account`
--

DROP TABLE IF EXISTS `email_email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_email_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EMAIL_ID_EMAIL_ACCOUNT_ID` (`email_id`,`email_account_id`),
  KEY `IDX_EMAIL_ID` (`email_id`),
  KEY `IDX_EMAIL_ACCOUNT_ID` (`email_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_email_account`
--

LOCK TABLES `email_email_account` WRITE;
/*!40000 ALTER TABLE `email_email_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_email_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_email_address`
--

DROP TABLE IF EXISTS `email_email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_email_address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_address_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EMAIL_ID_EMAIL_ADDRESS_ID_ADDRESS_TYPE` (`email_id`,`email_address_id`,`address_type`),
  KEY `IDX_EMAIL_ID` (`email_id`),
  KEY `IDX_EMAIL_ADDRESS_ID` (`email_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_email_address`
--

LOCK TABLES `email_email_address` WRITE;
/*!40000 ALTER TABLE `email_email_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_email_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_filter`
--

DROP TABLE IF EXISTS `email_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_filter` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `from` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body_contains` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_global` tinyint(1) NOT NULL DEFAULT '0',
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Skip',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_folder_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_EMAIL_FOLDER_ID` (`email_folder_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_filter`
--

LOCK TABLES `email_filter` WRITE;
/*!40000 ALTER TABLE `email_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_folder`
--

DROP TABLE IF EXISTS `email_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_folder` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `order` int DEFAULT NULL,
  `skip_notifications` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_folder`
--

LOCK TABLES `email_folder` WRITE;
/*!40000 ALTER TABLE `email_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_inbound_email`
--

DROP TABLE IF EXISTS `email_inbound_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_inbound_email` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EMAIL_ID_INBOUND_EMAIL_ID` (`email_id`,`inbound_email_id`),
  KEY `IDX_EMAIL_ID` (`email_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_inbound_email`
--

LOCK TABLES `email_inbound_email` WRITE;
/*!40000 ALTER TABLE `email_inbound_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_inbound_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_queue_item`
--

DROP TABLE IF EXISTS `email_queue_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_queue_item` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attempt_count` int DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `email_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_test` tinyint(1) NOT NULL DEFAULT '0',
  `mass_email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_MASS_EMAIL_ID` (`mass_email_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_queue_item`
--

LOCK TABLES `email_queue_item` WRITE;
/*!40000 ALTER TABLE `email_queue_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_queue_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_template`
--

DROP TABLE IF EXISTS `email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_template` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_html` tinyint(1) NOT NULL DEFAULT '1',
  `one_off` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `category_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CATEGORY_ID` (`category_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_template`
--

LOCK TABLES `email_template` WRITE;
/*!40000 ALTER TABLE `email_template` DISABLE KEYS */;
INSERT INTO `email_template` VALUES ('62e03a1538d8992cf','Case-to-Email auto-reply',0,'Case has been created','<p>{Person.name},</p><p>Case \'{Case.name}\' has been created with number {Case.number} and assigned to {User.name}.</p>',1,0,'2022-07-26 19:01:41','2022-07-26 19:01:41',NULL,NULL,'system',NULL,1);
/*!40000 ALTER TABLE `email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_template_category`
--

DROP TABLE IF EXISTS `email_template_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_template_category` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `order` int DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_template_category`
--

LOCK TABLES `email_template_category` WRITE;
/*!40000 ALTER TABLE `email_template_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_template_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_template_category_path`
--

DROP TABLE IF EXISTS `email_template_category_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_template_category_path` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ascendor_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descendor_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASCENDOR_ID` (`ascendor_id`),
  KEY `IDX_DESCENDOR_ID` (`descendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_template_category_path`
--

LOCK TABLES `email_template_category_path` WRITE;
/*!40000 ALTER TABLE `email_template_category_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_template_category_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_user`
--

DROP TABLE IF EXISTS `email_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `is_important` tinyint(1) DEFAULT '0',
  `in_trash` tinyint(1) DEFAULT '0',
  `folder_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EMAIL_ID_USER_ID` (`email_id`,`user_id`),
  KEY `IDX_EMAIL_ID` (`email_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_user`
--

LOCK TABLES `email_user` WRITE;
/*!40000 ALTER TABLE `email_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_email_address`
--

DROP TABLE IF EXISTS `entity_email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_email_address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_address_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ENTITY_ID_EMAIL_ADDRESS_ID_ENTITY_TYPE` (`entity_id`,`email_address_id`,`entity_type`),
  KEY `IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_EMAIL_ADDRESS_ID` (`email_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_email_address`
--

LOCK TABLES `entity_email_address` WRITE;
/*!40000 ALTER TABLE `entity_email_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_email_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_phone_number`
--

DROP TABLE IF EXISTS `entity_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_phone_number` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ENTITY_ID_PHONE_NUMBER_ID_ENTITY_TYPE` (`entity_id`,`phone_number_id`,`entity_type`),
  KEY `IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_PHONE_NUMBER_ID` (`phone_number_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_phone_number`
--

LOCK TABLES `entity_phone_number` WRITE;
/*!40000 ALTER TABLE `entity_phone_number` DISABLE KEYS */;
INSERT INTO `entity_phone_number` VALUES (1,'62e03bfb479a14e0a','62e03bfb4a48fc650','Account',1,0),(2,'62e03c4b7dcb1e8c8','62e03c4b808a216a2','Contact',1,0),(3,'62e03eb0e440675fe','62e03c4b808a216a2','Lead',1,0);
/*!40000 ALTER TABLE `entity_phone_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_team`
--

DROP TABLE IF EXISTS `entity_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_team` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ENTITY_ID_TEAM_ID_ENTITY_TYPE` (`entity_id`,`team_id`,`entity_type`),
  KEY `IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_TEAM_ID` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_team`
--

LOCK TABLES `entity_team` WRITE;
/*!40000 ALTER TABLE `entity_team` DISABLE KEYS */;
INSERT INTO `entity_team` VALUES (1,'62e03bfb479a14e0a','62e03b5c795a9cec6','Account',0),(2,'62e03c4b7dcb1e8c8','62e03b5c795a9cec6','Contact',0),(3,'62e03eb0e440675fe','62e03b5c795a9cec6','Lead',0),(4,'62e03f059a3ffb7a9','62e03b5c795a9cec6','Opportunity',0),(5,'62e03f29a380cbb50','62e03b5c795a9cec6','Case',0),(6,'62e03fe028552cd3a','62e03b5c795a9cec6','Call',0),(7,'62e03ff62a78e58a1','62e03b5c795a9cec6','Meeting',0),(8,'62e0402d9225477e6','62e03b5c795a9cec6','Task',0),(9,'62e04099b15ac572c','62e03b5c795a9cec6','Campaign',0);
/*!40000 ALTER TABLE `entity_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_user`
--

DROP TABLE IF EXISTS `entity_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ENTITY_ID_USER_ID_ENTITY_TYPE` (`entity_id`,`user_id`,`entity_type`),
  KEY `IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_user`
--

LOCK TABLES `entity_user` WRITE;
/*!40000 ALTER TABLE `entity_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `export`
--

DROP TABLE IF EXISTS `export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `notify_on_finish` tinyint(1) NOT NULL DEFAULT '0',
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_ATTACHMENT` (`attachment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `export`
--

LOCK TABLES `export` WRITE;
/*!40000 ALTER TABLE `export` DISABLE KEYS */;
/*!40000 ALTER TABLE `export` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extension`
--

DROP TABLE IF EXISTS `extension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extension` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_installed` tinyint(1) NOT NULL DEFAULT '0',
  `check_version_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extension`
--

LOCK TABLES `extension` WRITE;
/*!40000 ALTER TABLE `extension` DISABLE KEYS */;
/*!40000 ALTER TABLE `extension` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_account`
--

DROP TABLE IF EXISTS `external_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_account` (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_account`
--

LOCK TABLES `external_account` WRITE;
/*!40000 ALTER TABLE `external_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import`
--

DROP TABLE IF EXISTS `import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `entity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_index` int DEFAULT NULL,
  `params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `attribute_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `file_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import`
--

LOCK TABLES `import` WRITE;
/*!40000 ALTER TABLE `import` DISABLE KEYS */;
/*!40000 ALTER TABLE `import` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_entity`
--

DROP TABLE IF EXISTS `import_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_entity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `entity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `import_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_imported` tinyint(1) NOT NULL DEFAULT '0',
  `is_updated` tinyint(1) NOT NULL DEFAULT '0',
  `is_duplicate` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_IMPORT` (`import_id`,`entity_type`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`),
  KEY `IDX_IMPORT_ID` (`import_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_entity`
--

LOCK TABLES `import_entity` WRITE;
/*!40000 ALTER TABLE `import_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbound_email`
--

DROP TABLE IF EXISTS `inbound_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inbound_email` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `email_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` int DEFAULT '993',
  `security` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'SSL',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monitored_folders` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fetch_since` date DEFAULT NULL,
  `fetch_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `add_all_team_users` tinyint(1) NOT NULL DEFAULT '1',
  `sent_folder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_sent_emails` tinyint(1) NOT NULL DEFAULT '0',
  `keep_fetched_emails_unread` tinyint(1) NOT NULL DEFAULT '0',
  `use_imap` tinyint(1) NOT NULL DEFAULT '1',
  `use_smtp` tinyint(1) NOT NULL DEFAULT '0',
  `smtp_is_shared` tinyint(1) NOT NULL DEFAULT '0',
  `smtp_is_for_mass_email` tinyint(1) NOT NULL DEFAULT '0',
  `smtp_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_port` int DEFAULT '587',
  `smtp_auth` tinyint(1) NOT NULL DEFAULT '1',
  `smtp_security` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TLS',
  `smtp_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_auth_mechanism` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'login',
  `create_case` tinyint(1) NOT NULL DEFAULT '0',
  `case_distribution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Direct-Assignment',
  `target_user_position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply` tinyint(1) NOT NULL DEFAULT '0',
  `reply_from_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_to_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imap_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `assign_to_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_email_template_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASSIGN_TO_USER_ID` (`assign_to_user_id`),
  KEY `IDX_TEAM_ID` (`team_id`),
  KEY `IDX_REPLY_EMAIL_TEMPLATE_ID` (`reply_email_template_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbound_email`
--

LOCK TABLES `inbound_email` WRITE;
/*!40000 ALTER TABLE `inbound_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbound_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbound_email_team`
--

DROP TABLE IF EXISTS `inbound_email_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inbound_email_team` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `inbound_email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_INBOUND_EMAIL_ID_TEAM_ID` (`inbound_email_id`,`team_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`),
  KEY `IDX_TEAM_ID` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbound_email_team`
--

LOCK TABLES `inbound_email_team` WRITE;
/*!40000 ALTER TABLE `inbound_email_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbound_email_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integration`
--

DROP TABLE IF EXISTS `integration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integration` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integration`
--

LOCK TABLES `integration` WRITE;
/*!40000 ALTER TABLE `integration` DISABLE KEYS */;
/*!40000 ALTER TABLE `integration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `execute_time` datetime DEFAULT NULL,
  `number` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `queue` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_group` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `executed_at` datetime DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `attempts` int DEFAULT NULL,
  `target_id` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failed_attempts` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `scheduled_job_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_EXECUTE_TIME` (`status`,`execute_time`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_STATUS_SCHEDULED_JOB_ID` (`status`,`scheduled_job_id`),
  KEY `IDX_SCHEDULED_JOB_ID` (`scheduled_job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES ('62e03a15525a41b8e','Dummy',0,'Pending','2022-07-26 19:01:41',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41','62e03a14ee64b23b0'),('62e03eca4025be814','Espo\\Tools\\Stream\\Jobs\\ControlFollowers',0,'Pending','2022-07-26 19:21:46',2,'Espo\\Tools\\Stream\\Jobs\\ControlFollowers',NULL,NULL,NULL,'{\"entityType\":\"Lead\",\"entityId\":\"62e03eb0e440675fe\"}','q1',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2022-07-26 19:21:46','2022-07-26 19:21:46',NULL),('62e03ed192c87470e','Espo\\Tools\\Stream\\Jobs\\ControlFollowers',0,'Pending','2022-07-26 19:21:53',3,'Espo\\Tools\\Stream\\Jobs\\ControlFollowers',NULL,NULL,NULL,'{\"entityType\":\"Lead\",\"entityId\":\"62e03eb0e440675fe\"}','q1',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2022-07-26 19:21:53','2022-07-26 19:21:53',NULL);
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kanban_order`
--

DROP TABLE IF EXISTS `kanban_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kanban_order` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `order` smallint DEFAULT NULL,
  `group` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_USER_ID` (`entity_type`,`entity_id`,`user_id`),
  KEY `IDX_ENTITY_TYPE` (`entity_type`),
  KEY `IDX_ENTITY_TYPE_USER_ID` (`entity_type`,`user_id`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kanban_order`
--

LOCK TABLES `kanban_order` WRITE;
/*!40000 ALTER TABLE `kanban_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `kanban_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_base_article`
--

DROP TABLE IF EXISTS `knowledge_base_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_article` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `order` int DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_article`
--

LOCK TABLES `knowledge_base_article` WRITE;
/*!40000 ALTER TABLE `knowledge_base_article` DISABLE KEYS */;
INSERT INTO `knowledge_base_article` VALUES ('62e040ace2f561261','KB1',0,'Draft','en_US',NULL,NULL,NULL,9998,NULL,'2022-07-26 19:29:48','2022-07-26 19:29:48','','1',NULL,NULL,1);
/*!40000 ALTER TABLE `knowledge_base_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_base_article_knowledge_base_category`
--

DROP TABLE IF EXISTS `knowledge_base_article_knowledge_base_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_article_knowledge_base_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `knowledge_base_article_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `knowledge_base_category_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_KNOWLEDGE_BASE_ARTICLE_ID_KNOWLEDGE_BASE_CATEGORY_ID` (`knowledge_base_article_id`,`knowledge_base_category_id`),
  KEY `IDX_KNOWLEDGE_BASE_ARTICLE_ID` (`knowledge_base_article_id`),
  KEY `IDX_KNOWLEDGE_BASE_CATEGORY_ID` (`knowledge_base_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_article_knowledge_base_category`
--

LOCK TABLES `knowledge_base_article_knowledge_base_category` WRITE;
/*!40000 ALTER TABLE `knowledge_base_article_knowledge_base_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_base_article_knowledge_base_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_base_article_portal`
--

DROP TABLE IF EXISTS `knowledge_base_article_portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_article_portal` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `portal_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `knowledge_base_article_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_PORTAL_ID_KNOWLEDGE_BASE_ARTICLE_ID` (`portal_id`,`knowledge_base_article_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`),
  KEY `IDX_KNOWLEDGE_BASE_ARTICLE_ID` (`knowledge_base_article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_article_portal`
--

LOCK TABLES `knowledge_base_article_portal` WRITE;
/*!40000 ALTER TABLE `knowledge_base_article_portal` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_base_article_portal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_base_category`
--

DROP TABLE IF EXISTS `knowledge_base_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_category` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `order` int DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_category`
--

LOCK TABLES `knowledge_base_category` WRITE;
/*!40000 ALTER TABLE `knowledge_base_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_base_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_base_category_path`
--

DROP TABLE IF EXISTS `knowledge_base_category_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_category_path` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ascendor_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descendor_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASCENDOR_ID` (`ascendor_id`),
  KEY `IDX_DESCENDOR_ID` (`descendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_category_path`
--

LOCK TABLES `knowledge_base_category_path` WRITE;
/*!40000 ALTER TABLE `knowledge_base_category_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_base_category_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layout_record`
--

DROP TABLE IF EXISTS `layout_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `layout_record` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `layout_set_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_NAME_LAYOUT_SET_ID` (`name`,`layout_set_id`),
  KEY `IDX_LAYOUT_SET_ID` (`layout_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout_record`
--

LOCK TABLES `layout_record` WRITE;
/*!40000 ALTER TABLE `layout_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `layout_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layout_set`
--

DROP TABLE IF EXISTS `layout_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `layout_set` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `layout_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout_set`
--

LOCK TABLES `layout_set` WRITE;
/*!40000 ALTER TABLE `layout_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `layout_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead`
--

DROP TABLE IF EXISTS `lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `salutation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'New',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `industry` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `opportunity_amount` double DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `do_not_call` tinyint(1) NOT NULL DEFAULT '0',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `converted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `account_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opportunity_amount_currency` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_opportunity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_FIRST_NAME` (`first_name`,`deleted`),
  KEY `IDX_NAME` (`first_name`,`last_name`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_CREATED_AT_STATUS` (`created_at`,`status`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_CREATED_ACCOUNT_ID` (`created_account_id`),
  KEY `IDX_CREATED_CONTACT_ID` (`created_contact_id`),
  KEY `IDX_CREATED_OPPORTUNITY_ID` (`created_opportunity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead`
--

LOCK TABLES `lead` WRITE;
/*!40000 ALTER TABLE `lead` DISABLE KEYS */;
INSERT INTO `lead` VALUES ('62e03eb0e440675fe','Josef Dittrich',0,'Mr.','Josef','Dittrich','Title','New','Call','Advertising',1000000,'Website','Holzkamp 2','Itzehoe','Schleswig-Holstein','Germany','25524',0,'Description',NULL,'2022-07-26 19:21:20','2022-07-26 19:21:53','Mastercard',NULL,'USD','1','1','62e03b2c309ae86c7',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_capture`
--

DROP TABLE IF EXISTS `lead_capture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_capture` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `subscribe_to_target_list` tinyint(1) NOT NULL DEFAULT '1',
  `subscribe_contact_to_target_list` tinyint(1) NOT NULL DEFAULT '1',
  `field_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `duplicate_check` tinyint(1) NOT NULL DEFAULT '1',
  `opt_in_confirmation` tinyint(1) NOT NULL DEFAULT '0',
  `opt_in_confirmation_lifetime` int DEFAULT '48',
  `opt_in_confirmation_success_message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `create_lead_before_opt_in_confirmation` tinyint(1) NOT NULL DEFAULT '0',
  `skip_opt_in_confirmation_if_subscribed` tinyint(1) NOT NULL DEFAULT '0',
  `lead_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Web Site',
  `api_key` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opt_in_confirmation_email_template_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_team_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`),
  KEY `IDX_OPT_IN_CONFIRMATION_EMAIL_TEMPLATE_ID` (`opt_in_confirmation_email_template_id`),
  KEY `IDX_TARGET_TEAM_ID` (`target_team_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_capture`
--

LOCK TABLES `lead_capture` WRITE;
/*!40000 ALTER TABLE `lead_capture` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_capture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_capture_log_record`
--

DROP TABLE IF EXISTS `lead_capture_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_capture_log_record` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `number` int unsigned NOT NULL AUTO_INCREMENT,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_created` tinyint(1) NOT NULL DEFAULT '0',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `lead_capture_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_LEAD_CAPTURE_ID` (`lead_capture_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_capture_log_record`
--

LOCK TABLES `lead_capture_log_record` WRITE;
/*!40000 ALTER TABLE `lead_capture_log_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_capture_log_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_meeting`
--

DROP TABLE IF EXISTS `lead_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_meeting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `lead_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meeting_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_LEAD_ID_MEETING_ID` (`lead_id`,`meeting_id`),
  KEY `IDX_LEAD_ID` (`lead_id`),
  KEY `IDX_MEETING_ID` (`meeting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_meeting`
--

LOCK TABLES `lead_meeting` WRITE;
/*!40000 ALTER TABLE `lead_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_target_list`
--

DROP TABLE IF EXISTS `lead_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_target_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `lead_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_LEAD_ID_TARGET_LIST_ID` (`lead_id`,`target_list_id`),
  KEY `IDX_LEAD_ID` (`lead_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_target_list`
--

LOCK TABLES `lead_target_list` WRITE;
/*!40000 ALTER TABLE `lead_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_target_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mass_action`
--

DROP TABLE IF EXISTS `mass_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mass_action` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `entity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `processed_count` int DEFAULT NULL,
  `notify_on_finish` tinyint(1) NOT NULL DEFAULT '0',
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mass_action`
--

LOCK TABLES `mass_action` WRITE;
/*!40000 ALTER TABLE `mass_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `mass_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mass_email`
--

DROP TABLE IF EXISTS `mass_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mass_email` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `store_sent_emails` tinyint(1) NOT NULL DEFAULT '0',
  `opt_out_entirely` tinyint(1) NOT NULL DEFAULT '0',
  `from_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_to_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_to_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `email_template_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EMAIL_TEMPLATE_ID` (`email_template_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mass_email`
--

LOCK TABLES `mass_email` WRITE;
/*!40000 ALTER TABLE `mass_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `mass_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mass_email_target_list`
--

DROP TABLE IF EXISTS `mass_email_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mass_email_target_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mass_email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_MASS_EMAIL_ID_TARGET_LIST_ID` (`mass_email_id`,`target_list_id`),
  KEY `IDX_MASS_EMAIL_ID` (`mass_email_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mass_email_target_list`
--

LOCK TABLES `mass_email_target_list` WRITE;
/*!40000 ALTER TABLE `mass_email_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `mass_email_target_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mass_email_target_list_excluding`
--

DROP TABLE IF EXISTS `mass_email_target_list_excluding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mass_email_target_list_excluding` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mass_email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_MASS_EMAIL_ID_TARGET_LIST_ID` (`mass_email_id`,`target_list_id`),
  KEY `IDX_MASS_EMAIL_ID` (`mass_email_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mass_email_target_list_excluding`
--

LOCK TABLES `mass_email_target_list_excluding` WRITE;
/*!40000 ALTER TABLE `mass_email_target_list_excluding` DISABLE KEYS */;
/*!40000 ALTER TABLE `mass_email_target_list_excluding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Planned',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `is_all_day` tinyint(1) NOT NULL DEFAULT '0',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `date_start_date` date DEFAULT NULL,
  `date_end_date` date DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DATE_START_STATUS` (`date_start`,`status`),
  KEY `IDX_DATE_START` (`date_start`,`deleted`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting`
--

LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
INSERT INTO `meeting` VALUES ('62e03ff62a78e58a1','Meeting1',0,'Planned','2022-07-26 19:15:00','2022-07-26 20:15:00',0,'tst','2022-07-26 19:26:46','2022-07-26 19:31:02',NULL,NULL,'62e03bfb479a14e0a','Account','62e03bfb479a14e0a','1','1','62e03b2c309ae86c7');
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_user`
--

DROP TABLE IF EXISTS `meeting_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meeting_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ID_MEETING_ID` (`user_id`,`meeting_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_MEETING_ID` (`meeting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting_user`
--

LOCK TABLES `meeting_user` WRITE;
/*!40000 ALTER TABLE `meeting_user` DISABLE KEYS */;
INSERT INTO `meeting_user` VALUES (1,'62e03b2c309ae86c7','62e03ff62a78e58a1','None',0);
/*!40000 ALTER TABLE `meeting_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `next_number`
--

DROP TABLE IF EXISTS `next_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `next_number` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_TYPE_FIELD_NAME` (`entity_type`,`field_name`),
  KEY `IDX_ENTITY_TYPE` (`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `next_number`
--

LOCK TABLES `next_number` WRITE;
/*!40000 ALTER TABLE `next_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `next_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `post` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` bigint unsigned NOT NULL AUTO_INCREMENT,
  `is_global` tinyint(1) NOT NULL DEFAULT '0',
  `is_internal` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `super_parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `super_parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_CREATED_AT` (`created_at`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_PARENT_AND_SUPER_PARENT` (`parent_id`,`parent_type`,`super_parent_id`,`super_parent_type`),
  KEY `IDX_CREATED_BY_NUMBER` (`created_by_id`,`number`),
  KEY `IDX_RELATED` (`related_id`,`related_type`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_SUPER_PARENT` (`super_parent_id`,`super_parent_type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
INSERT INTO `note` VALUES ('62e03bfb54c8b174d',0,NULL,'{\"assignedUserId\":\"1\",\"assignedUserName\":\"Admin\"}','Create',NULL,1,0,0,'2022-07-26 19:09:47','2022-07-26 19:09:47','62e03bfb479a14e0a','Account',NULL,NULL,'1',NULL,NULL,NULL),('62e03c4b8ba406c5d',0,NULL,'{\"assignedUserId\":\"62e03b2c309ae86c7\",\"assignedUserName\":\"Tester One\"}','Create',NULL,2,0,0,'2022-07-26 19:11:07','2022-07-26 19:11:07','62e03c4b7dcb1e8c8','Contact',NULL,NULL,'1',NULL,'62e03bfb479a14e0a','Account'),('62e03eb0ede3f9d3e',0,NULL,'{\"statusValue\":\"New\",\"statusField\":\"status\",\"statusStyle\":\"default\"}','Create',NULL,3,0,0,'2022-07-26 19:21:20','2022-07-26 19:21:20','62e03eb0e440675fe','Lead',NULL,NULL,'1',NULL,NULL,NULL),('62e03eca3d8f67999',0,NULL,'{\"assignedUserId\":\"62e03b2c309ae86c7\",\"assignedUserName\":\"Tester One\"}','Assign',NULL,4,0,0,'2022-07-26 19:21:46','2022-07-26 19:21:46','62e03eb0e440675fe','Lead',NULL,NULL,'1',NULL,NULL,NULL),('62e03f05a0e4ddce3',0,NULL,'{\"assignedUserId\":\"62e03b2c309ae86c7\",\"assignedUserName\":\"Tester One\",\"statusValue\":\"Prospecting\",\"statusField\":\"stage\",\"statusStyle\":\"default\"}','Create',NULL,5,0,0,'2022-07-26 19:22:45','2022-07-26 19:22:45','62e03f059a3ffb7a9','Opportunity',NULL,NULL,'1',NULL,'62e03bfb479a14e0a','Account'),('62e03f29a9f0df798',0,NULL,'{\"assignedUserId\":\"62e03b2c309ae86c7\",\"assignedUserName\":\"Tester One\",\"statusValue\":\"New\",\"statusField\":\"status\",\"statusStyle\":\"default\"}','Create',NULL,6,0,0,'2022-07-26 19:23:21','2022-07-26 19:23:21','62e03f29a380cbb50','Case',NULL,NULL,'1',NULL,'62e03bfb479a14e0a','Account'),('62e03fe02f7d27e44',0,NULL,NULL,'CreateRelated',NULL,7,0,0,'2022-07-26 19:26:24','2022-07-26 19:26:24','62e03bfb479a14e0a','Account','62e03fe028552cd3a','Call','1',NULL,'62e03bfb479a14e0a','Account'),('62e03ff63184c1718',0,NULL,NULL,'CreateRelated',NULL,8,0,0,'2022-07-26 19:26:46','2022-07-26 19:26:46','62e03bfb479a14e0a','Account','62e03ff62a78e58a1','Meeting','1',NULL,'62e03bfb479a14e0a','Account'),('62e0402d973f5b19f',0,NULL,'{\"assignedUserId\":\"62e03b2c309ae86c7\",\"assignedUserName\":\"Tester One\",\"statusValue\":\"Not Started\",\"statusField\":\"status\",\"statusStyle\":\"default\"}','Create',NULL,9,0,0,'2022-07-26 19:27:41','2022-07-26 19:27:41','62e0402d9225477e6','Task',NULL,NULL,'1',NULL,'62e03bfb479a14e0a','Account');
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note_portal`
--

DROP TABLE IF EXISTS `note_portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note_portal` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `note_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portal_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NOTE_ID_PORTAL_ID` (`note_id`,`portal_id`),
  KEY `IDX_NOTE_ID` (`note_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_portal`
--

LOCK TABLES `note_portal` WRITE;
/*!40000 ALTER TABLE `note_portal` DISABLE KEYS */;
/*!40000 ALTER TABLE `note_portal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note_team`
--

DROP TABLE IF EXISTS `note_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note_team` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `note_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NOTE_ID_TEAM_ID` (`note_id`,`team_id`),
  KEY `IDX_NOTE_ID` (`note_id`),
  KEY `IDX_TEAM_ID` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_team`
--

LOCK TABLES `note_team` WRITE;
/*!40000 ALTER TABLE `note_team` DISABLE KEYS */;
INSERT INTO `note_team` VALUES (1,'62e03c4b8ba406c5d','62e03b5c795a9cec6',0),(2,'62e03f05a0e4ddce3','62e03b5c795a9cec6',0),(3,'62e03f29a9f0df798','62e03b5c795a9cec6',0),(4,'62e03fe02f7d27e44','62e03b5c795a9cec6',0),(5,'62e03ff63184c1718','62e03b5c795a9cec6',0),(6,'62e0402d973f5b19f','62e03b5c795a9cec6',0);
/*!40000 ALTER TABLE `note_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note_user`
--

DROP TABLE IF EXISTS `note_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `note_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NOTE_ID_USER_ID` (`note_id`,`user_id`),
  KEY `IDX_NOTE_ID` (`note_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_user`
--

LOCK TABLES `note_user` WRITE;
/*!40000 ALTER TABLE `note_user` DISABLE KEYS */;
INSERT INTO `note_user` VALUES (1,'62e03c4b8ba406c5d','62e03b2c309ae86c7',0),(2,'62e03f05a0e4ddce3','62e03b2c309ae86c7',0),(3,'62e03f29a9f0df798','62e03b2c309ae86c7',0),(4,'62e03fe02f7d27e44','62e03b2c309ae86c7',0),(5,'62e03ff63184c1718','62e03b2c309ae86c7',0),(6,'62e0402d973f5b19f','62e03b2c309ae86c7',0);
/*!40000 ALTER TABLE `note_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `number` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `email_is_processed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_CREATED_AT` (`created_at`),
  KEY `IDX_USER` (`user_id`,`created_at`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_RELATED` (`related_id`,`related_type`),
  KEY `IDX_RELATED_PARENT` (`related_parent_id`,`related_parent_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES ('62e03fe036931b854',0,1,'{\"entityType\":\"Call\",\"entityId\":\"62e03fe028552cd3a\",\"entityName\":\"Call\",\"isNew\":true,\"userId\":\"1\",\"userName\":\"Admin\"}','Assign',0,0,'2022-07-26 19:26:24',NULL,'62e03b2c309ae86c7','62e03fe028552cd3a','Call',NULL,NULL),('62e03ff63845f79fe',0,2,'{\"entityType\":\"Meeting\",\"entityId\":\"62e03ff62a78e58a1\",\"entityName\":\"Test\",\"isNew\":true,\"userId\":\"1\",\"userName\":\"Admin\"}','Assign',0,0,'2022-07-26 19:26:46',NULL,'62e03b2c309ae86c7','62e03ff62a78e58a1','Meeting',NULL,NULL);
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opportunity`
--

DROP TABLE IF EXISTS `opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunity` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `amount` double DEFAULT NULL,
  `stage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Prospecting',
  `last_stage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `probability` int DEFAULT NULL,
  `lead_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `close_date` date DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `amount_currency` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_STAGE` (`stage`,`deleted`),
  KEY `IDX_LAST_STAGE` (`last_stage`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_CREATED_AT_STAGE` (`created_at`,`stage`),
  KEY `IDX_ASSIGNED_USER_STAGE` (`assigned_user_id`,`stage`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opportunity`
--

LOCK TABLES `opportunity` WRITE;
/*!40000 ALTER TABLE `opportunity` DISABLE KEYS */;
INSERT INTO `opportunity` VALUES ('62e03f059a3ffb7a9','Opportunity1',0,6789,'Prospecting','Prospecting',10,'Call','2022-07-27','Phone Number','2022-07-26 19:22:45','2022-07-26 19:30:27','USD','62e03bfb479a14e0a','62e03c4b7dcb1e8c8',NULL,'1','1','62e03b2c309ae86c7');
/*!40000 ALTER TABLE `opportunity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_change_request`
--

DROP TABLE IF EXISTS `password_change_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_change_request` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `request_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_REQUEST_ID` (`request_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_change_request`
--

LOCK TABLES `password_change_request` WRITE;
/*!40000 ALTER TABLE `password_change_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_change_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_number`
--

DROP TABLE IF EXISTS `phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone_number` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numeric` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invalid` tinyint(1) NOT NULL DEFAULT '0',
  `opt_out` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_NAME` (`name`),
  KEY `IDX_NUMERIC` (`numeric`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_number`
--

LOCK TABLES `phone_number` WRITE;
/*!40000 ALTER TABLE `phone_number` DISABLE KEYS */;
INSERT INTO `phone_number` VALUES ('62e03bfb4a48fc650','123456790',0,'Office','123456790',0,0),('62e03c4b808a216a2','1234567890',0,'Mobile','1234567890',0,0);
/*!40000 ALTER TABLE `phone_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal`
--

DROP TABLE IF EXISTS `portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `custom_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `tab_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `quick_create_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `theme` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `time_zone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `time_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `week_start` int DEFAULT '-1',
  `default_currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `dashboard_layout` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `dashlets_options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `custom_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `logo_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_logo_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_set_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CUSTOM_ID` (`custom_id`),
  KEY `IDX_LAYOUT_SET_ID` (`layout_set_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal`
--

LOCK TABLES `portal` WRITE;
/*!40000 ALTER TABLE `portal` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_portal_role`
--

DROP TABLE IF EXISTS `portal_portal_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal_portal_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `portal_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portal_role_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_PORTAL_ID_PORTAL_ROLE_ID` (`portal_id`,`portal_role_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`),
  KEY `IDX_PORTAL_ROLE_ID` (`portal_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_portal_role`
--

LOCK TABLES `portal_portal_role` WRITE;
/*!40000 ALTER TABLE `portal_portal_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_portal_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_role`
--

DROP TABLE IF EXISTS `portal_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal_role` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `field_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `export_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `mass_update_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_role`
--

LOCK TABLES `portal_role` WRITE;
/*!40000 ALTER TABLE `portal_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_role_user`
--

DROP TABLE IF EXISTS `portal_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal_role_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `portal_role_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_PORTAL_ROLE_ID_USER_ID` (`portal_role_id`,`user_id`),
  KEY `IDX_PORTAL_ROLE_ID` (`portal_role_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_role_user`
--

LOCK TABLES `portal_role_user` WRITE;
/*!40000 ALTER TABLE `portal_role_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_user`
--

DROP TABLE IF EXISTS `portal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `portal_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_PORTAL_ID_USER_ID` (`portal_id`,`user_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_user`
--

LOCK TABLES `portal_user` WRITE;
/*!40000 ALTER TABLE `portal_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preferences`
--

DROP TABLE IF EXISTS `preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preferences` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preferences`
--

LOCK TABLES `preferences` WRITE;
/*!40000 ALTER TABLE `preferences` DISABLE KEYS */;
INSERT INTO `preferences` VALUES ('1','{\n    \"id\": \"1\",\n    \"timeZone\": \"\",\n    \"dateFormat\": \"\",\n    \"timeFormat\": \"\",\n    \"weekStart\": -1,\n    \"defaultCurrency\": \"\",\n    \"thousandSeparator\": \",\",\n    \"decimalMark\": \".\",\n    \"dashboardLayout\": [\n        {\n            \"name\": \"My Espo\",\n            \"layout\": [\n                {\n                    \"id\": \"default-activities\",\n                    \"name\": \"Activities\",\n                    \"x\": 2,\n                    \"y\": 2,\n                    \"width\": 2,\n                    \"height\": 4\n                },\n                {\n                    \"id\": \"default-stream\",\n                    \"name\": \"Stream\",\n                    \"x\": 0,\n                    \"y\": 0,\n                    \"width\": 2,\n                    \"height\": 4\n                }\n            ]\n        }\n    ],\n    \"dashletsOptions\": {},\n    \"smtpPort\": 25,\n    \"smtpAuth\": false,\n    \"language\": \"\",\n    \"exportDelimiter\": \",\",\n    \"receiveAssignmentEmailNotifications\": true,\n    \"receiveMentionEmailNotifications\": true,\n    \"receiveStreamEmailNotifications\": true,\n    \"assignmentNotificationsIgnoreEntityTypeList\": [],\n    \"signature\": \"\",\n    \"defaultReminders\": [],\n    \"theme\": \"\",\n    \"useCustomTabList\": false,\n    \"emailReplyToAllByDefault\": true,\n    \"emailReplyForceHtml\": false,\n    \"doNotFillAssignedUserIfNotRequired\": true,\n    \"followEntityOnStreamPost\": true,\n    \"followCreatedEntities\": false,\n    \"followCreatedEntityTypeList\": [],\n    \"emailUseExternalClient\": false,\n    \"scopeColorsDisabled\": false,\n    \"tabColorsDisabled\": false\n}');
/*!40000 ALTER TABLE `preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminder`
--

DROP TABLE IF EXISTS `reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminder` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `remind_at` datetime DEFAULT NULL,
  `start_at` datetime DEFAULT NULL,
  `type` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Popup',
  `seconds` int DEFAULT '0',
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_submitted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_REMIND_AT` (`remind_at`),
  KEY `IDX_START_AT` (`start_at`),
  KEY `IDX_TYPE` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminder`
--

LOCK TABLES `reminder` WRITE;
/*!40000 ALTER TABLE `reminder` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `assignment_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `user_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `portal_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `group_email_account_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `export_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `mass_update_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `data_privacy_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `follower_management_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `field_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_team`
--

DROP TABLE IF EXISTS `role_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_team` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ROLE_ID_TEAM_ID` (`role_id`,`team_id`),
  KEY `IDX_ROLE_ID` (`role_id`),
  KEY `IDX_TEAM_ID` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_team`
--

LOCK TABLES `role_team` WRITE;
/*!40000 ALTER TABLE `role_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ROLE_ID_USER_ID` (`role_id`,`user_id`),
  KEY `IDX_ROLE_ID` (`role_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_job`
--

DROP TABLE IF EXISTS `scheduled_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_job` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `job` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `scheduling` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `is_internal` tinyint(1) NOT NULL DEFAULT '0',
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_job`
--

LOCK TABLES `scheduled_job` WRITE;
/*!40000 ALTER TABLE `scheduled_job` DISABLE KEYS */;
INSERT INTO `scheduled_job` VALUES ('62e03a14e40b0b496','Submit Popup Reminders',0,'SubmitPopupReminders','Active','* * * * *',NULL,'2022-07-26 19:01:40','2022-07-26 19:01:40',1,NULL,NULL),('62e03a14e66f2fe6c','Process Job Group',0,'ProcessJobGroup','Active','* * * * *',NULL,'2022-07-26 19:01:40','2022-07-26 19:01:40',1,NULL,NULL),('62e03a14e8360f122','Process Job Queue q0',0,'ProcessJobQueueQ0','Active','* * * * *',NULL,'2022-07-26 19:01:40','2022-07-26 19:01:40',1,NULL,NULL),('62e03a14ea41ea163','Process Job Queue q1',0,'ProcessJobQueueQ1','Active','*/1 * * * *',NULL,'2022-07-26 19:01:40','2022-07-26 19:01:40',1,NULL,NULL),('62e03a14ec5851f74','Process Job Queue e0',0,'ProcessJobQueueE0','Active','* * * * *',NULL,'2022-07-26 19:01:40','2022-07-26 19:01:40',1,NULL,NULL),('62e03a14ee64b23b0','Dummy',0,'Dummy','Active','1 */12 * * *',NULL,'2022-07-26 19:01:40','2022-07-26 19:01:40',1,NULL,NULL),('62e03a14f022d805b','Check for New Version',0,'CheckNewVersion','Active','15 5 * * *',NULL,'2022-07-26 19:01:40','2022-07-26 19:01:40',1,NULL,NULL),('62e03a14f237ef9aa','Check for New Versions of Installed Extensions',0,'CheckNewExtensionVersion','Active','25 5 * * *',NULL,'2022-07-26 19:01:40','2022-07-26 19:01:40',1,NULL,NULL),('62e03a153cfacb714','Check Group Email Accounts',0,'CheckInboundEmails','Active','*/2 * * * *',NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41',0,'system',NULL),('62e03a153f40d74ea','Check Personal Email Accounts',0,'CheckEmailAccounts','Active','*/1 * * * *',NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41',0,'system',NULL),('62e03a154115bbfdc','Send Email Reminders',0,'SendEmailReminders','Active','*/2 * * * *',NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41',0,'system',NULL),('62e03a1542e5b84d1','Send Email Notifications',0,'SendEmailNotifications','Active','*/2 * * * *',NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41',0,'system',NULL),('62e03a1544af2e138','Clean-up',0,'Cleanup','Active','1 1 * * 0',NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41',0,'system',NULL),('62e03a15466d87474','Send Mass Emails',0,'ProcessMassEmail','Active','15 * * * *',NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41',0,'system',NULL),('62e03a15481d6135b','Auth Token Control',0,'AuthTokenControl','Active','*/6 * * * *',NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41',0,'system',NULL),('62e03a154c12d0981','Control Knowledge Base Article Status',0,'ControlKnowledgeBaseArticleStatus','Active','10 1 * * *',NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41',0,'system',NULL),('62e03a15501e925e0','Process Webhook Queue',0,'ProcessWebhookQueue','Active','*/5 * * * *',NULL,'2022-07-26 19:01:41','2022-07-26 19:01:41',0,'system',NULL);
/*!40000 ALTER TABLE `scheduled_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_job_log_record`
--

DROP TABLE IF EXISTS `scheduled_job_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_job_log_record` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `execution_time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `scheduled_job_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_SCHEDULED_JOB_ID_EXECUTION_TIME` (`scheduled_job_id`,`execution_time`),
  KEY `IDX_SCHEDULED_JOB_ID` (`scheduled_job_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_job_log_record`
--

LOCK TABLES `scheduled_job_log_record` WRITE;
/*!40000 ALTER TABLE `scheduled_job_log_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_job_log_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Archived',
  `date_sent` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `from_phone_number_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `replied_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DATE_SENT` (`date_sent`,`deleted`),
  KEY `IDX_DATE_SENT_STATUS` (`date_sent`,`status`,`deleted`),
  KEY `IDX_FROM_PHONE_NUMBER_ID` (`from_phone_number_id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_REPLIED_ID` (`replied_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_phone_number`
--

DROP TABLE IF EXISTS `sms_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_phone_number` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sms_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_SMS_ID_PHONE_NUMBER_ID_ADDRESS_TYPE` (`sms_id`,`phone_number_id`,`address_type`),
  KEY `IDX_SMS_ID` (`sms_id`),
  KEY `IDX_PHONE_NUMBER_ID` (`phone_number_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_phone_number`
--

LOCK TABLES `sms_phone_number` WRITE;
/*!40000 ALTER TABLE `sms_phone_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_phone_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription` (
  `id` int NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `entity_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_USER_ENTITY` (`user_id`,`entity_id`,`entity_type`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
INSERT INTO `subscription` VALUES (1,0,'62e03bfb479a14e0a','Account','1');
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target`
--

DROP TABLE IF EXISTS `target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `salutation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `do_not_call` tinyint(1) NOT NULL DEFAULT '0',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `middle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FIRST_NAME` (`first_name`,`deleted`),
  KEY `IDX_NAME` (`first_name`,`last_name`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target`
--

LOCK TABLES `target` WRITE;
/*!40000 ALTER TABLE `target` DISABLE KEYS */;
/*!40000 ALTER TABLE `target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_list`
--

DROP TABLE IF EXISTS `target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_list` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_list`
--

LOCK TABLES `target_list` WRITE;
/*!40000 ALTER TABLE `target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `target_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_list_user`
--

DROP TABLE IF EXISTS `target_list_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_list_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ID_TARGET_LIST_ID` (`user_id`,`target_list_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_list_user`
--

LOCK TABLES `target_list_user` WRITE;
/*!40000 ALTER TABLE `target_list_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `target_list_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Not Started',
  `priority` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Normal',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `date_start_date` date DEFAULT NULL,
  `date_end_date` date DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DATE_START_STATUS` (`date_start`,`status`),
  KEY `IDX_DATE_END_STATUS` (`date_end`,`status`),
  KEY `IDX_DATE_START` (`date_start`,`deleted`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_EMAIL_ID` (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES ('62e0402d9225477e6','Task1',0,'Not Started','Low','2022-07-27 00:00:00','2022-07-28 01:00:00',NULL,NULL,NULL,'tst','2022-07-26 19:27:41','2022-07-26 19:27:41','62e03bfb479a14e0a','Account','62e03bfb479a14e0a',NULL,'1',NULL,'62e03b2c309ae86c7',NULL);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `position_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `layout_set_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_LAYOUT_SET_ID` (`layout_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES ('62e03b5c795a9cec6','Admins',0,'[]','2022-07-26 19:07:08','2022-07-26 19:07:08',NULL);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_user`
--

DROP TABLE IF EXISTS `team_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `team_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_TEAM_ID_USER_ID` (`team_id`,`user_id`),
  KEY `IDX_TEAM_ID` (`team_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_user`
--

LOCK TABLES `team_user` WRITE;
/*!40000 ALTER TABLE `team_user` DISABLE KEYS */;
INSERT INTO `team_user` VALUES (1,'62e03b5c795a9cec6','1',NULL,0),(2,'62e03b5c795a9cec6','62e03b2c309ae86c7',NULL,0);
/*!40000 ALTER TABLE `team_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `template` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `header` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `footer` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `entity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `left_margin` double DEFAULT '10',
  `right_margin` double DEFAULT '10',
  `top_margin` double DEFAULT '10',
  `bottom_margin` double DEFAULT '25',
  `print_footer` tinyint(1) NOT NULL DEFAULT '0',
  `print_header` tinyint(1) NOT NULL DEFAULT '0',
  `footer_position` double DEFAULT '15',
  `header_position` double DEFAULT '10',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `page_orientation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Portrait',
  `page_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'A4',
  `page_width` double DEFAULT NULL,
  `page_height` double DEFAULT NULL,
  `font_face` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template`
--

LOCK TABLES `template` WRITE;
/*!40000 ALTER TABLE `template` DISABLE KEYS */;
/*!40000 ALTER TABLE `template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `two_factor_code`
--

DROP TABLE IF EXISTS `two_factor_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `two_factor_code` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attempts_left` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_AT` (`created_at`),
  KEY `IDX_USER_ID_METHOD` (`user_id`,`method`),
  KEY `IDX_USER_ID_METHOD_IS_ACTIVE` (`user_id`,`method`,`is_active`),
  KEY `IDX_USER_ID_METHOD_CREATED_AT` (`user_id`,`method`,`created_at`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `two_factor_code`
--

LOCK TABLES `two_factor_code` WRITE;
/*!40000 ALTER TABLE `two_factor_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `two_factor_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unique_id`
--

DROP TABLE IF EXISTS `unique_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unique_id` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `terminate_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_NAME` (`name`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unique_id`
--

LOCK TABLES `unique_id` WRITE;
/*!40000 ALTER TABLE `unique_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `unique_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'regular',
  `password` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_method` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salutation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `middle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_team_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboard_template_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_TYPE` (`type`),
  KEY `IDX_DEFAULT_TEAM_ID` (`default_team_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_DASHBOARD_TEMPLATE_ID` (`dashboard_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('1','Admin',0,'admin','admin','yQb/Foiz2ZN6XU8DemFwuq78wN/xiqdzvjzvUi55JbQXGXJ8wCTcweLfsf7Xk9ZIlZ5e5rFtSov3wMXYLprkz0',NULL,NULL,NULL,'','Admin',1,NULL,'','2022-07-26 19:01:41','2022-07-26 19:01:41',NULL,NULL,NULL,NULL,'system',NULL),('62e03b2c309ae86c7','Tester One',0,'tester','regular','',NULL,NULL,'Mr.','Tester','One',1,NULL,'','2022-07-26 19:06:20','2022-07-26 19:06:20',NULL,NULL,NULL,NULL,'1',NULL),('system','System',0,'system','system',NULL,NULL,NULL,NULL,'','System',1,NULL,'','2022-07-26 19:01:40','2022-07-26 19:01:40',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_data`
--

DROP TABLE IF EXISTS `user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_data` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `imap_handlers` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `smtp_handlers` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `auth2_f_a` tinyint(1) NOT NULL DEFAULT '0',
  `auth2_f_a_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth2_f_a_totp_secret` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth2_f_a_email_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_data`
--

LOCK TABLES `user_data` WRITE;
/*!40000 ALTER TABLE `user_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook`
--

DROP TABLE IF EXISTS `webhook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `event` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `entity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EVENT` (`event`),
  KEY `IDX_ENTITY_TYPE_TYPE` (`entity_type`,`type`),
  KEY `IDX_ENTITY_TYPE_FIELD` (`entity_type`,`field`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook`
--

LOCK TABLES `webhook` WRITE;
/*!40000 ALTER TABLE `webhook` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_event_queue_item`
--

DROP TABLE IF EXISTS `webhook_event_queue_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook_event_queue_item` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `number` bigint unsigned NOT NULL AUTO_INCREMENT,
  `event` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `is_processed` tinyint(1) NOT NULL DEFAULT '0',
  `target_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_event_queue_item`
--

LOCK TABLES `webhook_event_queue_item` WRITE;
/*!40000 ALTER TABLE `webhook_event_queue_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_event_queue_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_queue_item`
--

DROP TABLE IF EXISTS `webhook_queue_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook_queue_item` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `number` bigint unsigned NOT NULL AUTO_INCREMENT,
  `event` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `status` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `processed_at` datetime DEFAULT NULL,
  `attempts` int DEFAULT '0',
  `process_at` datetime DEFAULT NULL,
  `webhook_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_WEBHOOK_ID` (`webhook_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_queue_item`
--

LOCK TABLES `webhook_queue_item` WRITE;
/*!40000 ALTER TABLE `webhook_queue_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_queue_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-26 21:39:19
