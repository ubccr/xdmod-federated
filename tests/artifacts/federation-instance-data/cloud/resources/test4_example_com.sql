-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: openxdmod_cac_cornell_edu-modw
-- ------------------------------------------------------
-- Server version	5.5.68-MariaDB

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
-- Table structure for table `resourcefact`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `resourcefact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The id of the resource record',
  `resourcetype_id` int(11) DEFAULT '0' COMMENT 'The resource type id.',
  `organization_id` int(11) NOT NULL DEFAULT '1' COMMENT 'The organization of the resource.',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT 'The name of the resource.',
  `code` varchar(64) NOT NULL COMMENT 'The short name of the resource.',
  `description` varchar(1000) DEFAULT NULL COMMENT 'The description of the resource.',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The date the resource was put into commission.',
  `start_date_ts` int(14) NOT NULL DEFAULT '0',
  `end_date` datetime DEFAULT NULL COMMENT 'The end date of the resource.',
  `end_date_ts` int(14) DEFAULT NULL,
  `shared_jobs` int(1) NOT NULL DEFAULT '0',
  `timezone` varchar(30) NOT NULL DEFAULT 'UTC',
  `resource_origin_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq` (`organization_id`,`name`,`start_date`) USING BTREE,
  KEY `aggregation_index` (`resourcetype_id`,`id`) USING BTREE,
  KEY `fk_resource_organization1_idx` (`organization_id`) USING BTREE,
  KEY `fk_resource_resourcetype1_idx` (`resourcetype_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Information about resources.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcefact`
--

LOCK TABLES `resourcefact` WRITE;
/*!40000 ALTER TABLE `resourcefact` DISABLE KEYS */;
INSERT INTO `resourcefact` VALUES (1,5,1,'RedCloud','redcloud',NULL,'0000-00-00 00:00:00',0,NULL,NULL,0,'UTC',1);
/*!40000 ALTER TABLE `resourcefact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The id of the record.',
  `organizationtype_id` int(11) DEFAULT NULL COMMENT 'The type of the organization.',
  `abbrev` varchar(100) DEFAULT NULL COMMENT 'Abbreviated name.',
  `name` varchar(300) DEFAULT NULL COMMENT 'Long name for this organization.',
  `url` varchar(500) DEFAULT NULL COMMENT 'The internet URL.',
  `phone` varchar(30) DEFAULT NULL COMMENT 'Phone number.',
  `nsf_org_code` varchar(45) DEFAULT NULL COMMENT 'NSF code for this organization.',
  `is_reconciled` tinyint(1) DEFAULT '0' COMMENT 'Whether this record is reconciled.',
  `amie_name` varchar(6) DEFAULT NULL COMMENT 'The amie name.',
  `country_id` int(11) DEFAULT NULL COMMENT 'The country this organization is in.',
  `state_id` int(11) DEFAULT NULL COMMENT 'The state this organization is in.',
  `latitude` decimal(13,10) DEFAULT NULL COMMENT 'The latitude of the organization.',
  `longitude` decimal(13,10) DEFAULT NULL COMMENT 'The longitude of the organization.',
  `short_name` varchar(300) DEFAULT NULL,
  `long_name` varchar(300) DEFAULT NULL,
  `federation_instance_id` int(11) unsigned NOT NULL DEFAULT '0',
  `organization_origin_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `amie_name_unique` (`amie_name`) USING BTREE,
  UNIQUE KEY `name_unique` (`name`) USING BTREE,
  UNIQUE KEY `nsf_org_code_unique` (`nsf_org_code`) USING BTREE,
  UNIQUE KEY `uniq` (`organization_origin_id`,`federation_instance_id`) USING BTREE,
  KEY `fk_organization_country1_idx` (`country_id`) USING BTREE,
  KEY `fk_organization_organizationtype1_idx` (`organizationtype_id`) USING BTREE,
  KEY `fk_organization_state1_idx` (`state_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='The various organization.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orgainzation`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1, 1,'Cornell', 'Cornell University Center for Advanced Computing', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 'Cornell', 'Cornell University Center for Advanced Computing', 0, 1, 0);
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-21 13:52:45
