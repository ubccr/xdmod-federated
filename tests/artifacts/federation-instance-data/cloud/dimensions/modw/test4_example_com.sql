-- MySQL dump 10.14  Distrib 5.5.65-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: test4_example_com-modw
-- ------------------------------------------------------
-- Server version	5.5.65-MariaDB

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='The various organization.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT  IGNORE INTO `organization` VALUES (1,1,'test2','test2',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'test2','test2',0,1,0);
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='Information about resources.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcefact`
--

LOCK TABLES `resourcefact` WRITE;
/*!40000 ALTER TABLE `resourcefact` DISABLE KEYS */;
INSERT  IGNORE INTO `resourcefact` VALUES (1,5,1,'torx','torx',NULL,'0000-00-00 00:00:00',0,NULL,NULL,0,'UTC',1);
/*!40000 ALTER TABLE `resourcefact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcespecs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `resourcespecs` (
  `resource_id` int(11) NOT NULL,
  `start_date_ts` int(11) NOT NULL,
  `end_date_ts` int(11) DEFAULT NULL,
  `processors` int(11) DEFAULT NULL,
  `q_nodes` int(11) DEFAULT NULL,
  `q_ppn` int(11) DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`resource_id`,`start_date_ts`) USING BTREE,
  KEY `unq` (`name`,`start_date_ts`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcespecs`
--

LOCK TABLES `resourcespecs` WRITE;
/*!40000 ALTER TABLE `resourcespecs` DISABLE KEYS */;
/*!40000 ALTER TABLE `resourcespecs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `nsfstatuscode_id` int(11) NOT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(60) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `birth_month` int(11) DEFAULT NULL,
  `birth_day` int(11) DEFAULT NULL,
  `department` varchar(300) DEFAULT NULL,
  `title` varchar(300) DEFAULT NULL,
  `is_reconciled` tinyint(1) DEFAULT '0',
  `citizenship_country_id` int(11) DEFAULT NULL,
  `email_address` varchar(200) DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  `ts_ts` int(11) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL COMMENT 'links to allocationstate',
  `long_name` varchar(700) DEFAULT NULL,
  `short_name` varchar(101) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `person_origin_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `organization_id` (`organization_id`,`person_origin_id`) USING BTREE,
  KEY `aggregation_index` (`status`,`id`,`ts_ts`) USING BTREE,
  KEY `person_last_name` (`last_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=924 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT  IGNORE INTO `person` VALUES (-2,-2,-2,NULL,'unassociated',NULL,'unassociated',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'unassociated','unassociated',-2,0),(-1,-1,-1,NULL,'Unknown',NULL,'Unknown',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Unknown','Unknown',-1,0),(1,1,0,NULL,'Dillon',NULL,'Kennedy',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Kennedy, Dillon','Kennedy, D',25,1),(2,1,0,NULL,'Denise',NULL,'Elliott',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Elliott, Denise','Elliott, D',256,2),(3,1,0,NULL,'Peter',NULL,'Berg',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Berg, Peter','Berg, P',156,3),(4,1,0,NULL,'Michael',NULL,'Duarte',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Duarte, Michael','Duarte, M',172,4),(5,1,0,NULL,'Scott',NULL,'Schroeder',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Schroeder, Scott','Schroeder, S',122,5),(6,1,0,NULL,'Edward',NULL,'Edwards',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Edwards, Edward','Edwards, E',232,6),(7,1,0,NULL,'Timothy',NULL,'Powell',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Powell, Timothy','Powell, T',22,7),(8,1,0,NULL,'Stephen',NULL,'Davis',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Davis, Stephen','Davis, S',192,8),(9,1,0,NULL,'Timothy',NULL,'Castro',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Castro, Timothy','Castro, T',7,9),(10,1,0,NULL,'Russell',NULL,'Byrd',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Byrd, Russell','Byrd, R',253,10),(11,1,0,NULL,'Bruce',NULL,'Leach',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Leach, Bruce','Leach, B',112,11),(12,1,0,NULL,'Hannah',NULL,'Cain',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Cain, Hannah','Cain, H',68,12),(13,1,0,NULL,'Patty',NULL,'Martin',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Martin, Patty','Martin, P',243,13),(14,1,0,NULL,'Crystal',NULL,'Pena',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Pena, Crystal','Pena, C',254,14),(15,1,0,NULL,'Lauren',NULL,'Young',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Young, Lauren','Young, L',200,15),(16,1,0,NULL,'Jennifer',NULL,'Garcia',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Garcia, Jennifer','Garcia, J',180,16),(17,1,0,NULL,'Clarence',NULL,'Gomez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Gomez, Clarence','Gomez, C',212,17),(18,1,0,NULL,'Tina',NULL,'Wong',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Wong, Tina','Wong, T',195,18),(19,1,0,NULL,'Michael',NULL,'Rogers',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Rogers, Michael','Rogers, M',199,19),(20,1,0,NULL,'Kelly',NULL,'Bauer',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Bauer, Kelly','Bauer, K',126,20),(21,1,0,NULL,'Derek',NULL,'Davis',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Davis, Derek','Davis, D',56,21),(22,1,0,NULL,'Seth',NULL,'Miranda',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Miranda, Seth','Miranda, S',21,22),(23,1,0,NULL,'Alicia',NULL,'Harrell',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Harrell, Alicia','Harrell, A',98,23),(24,1,0,NULL,'Adam',NULL,'Camacho',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Camacho, Adam','Camacho, A',46,24),(25,1,0,NULL,'Terrance',NULL,'Martinez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Martinez, Terrance','Martinez, T',261,25),(26,1,0,NULL,'Michael',NULL,'Ross',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Ross, Michael','Ross, M',70,26),(27,1,0,NULL,'Bradley',NULL,'Hahn',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hahn, Bradley','Hahn, B',54,27),(28,1,0,NULL,'Brian',NULL,'Mcdonald',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Mcdonald, Brian','Mcdonald, B',244,28),(29,1,0,NULL,'Timothy',NULL,'Robinson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Robinson, Timothy','Robinson, T',155,29),(30,1,0,NULL,'Angela',NULL,'Gould',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Gould, Angela','Gould, A',1,30),(31,1,0,NULL,'Melissa',NULL,'Pollard',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Pollard, Melissa','Pollard, M',97,31),(32,1,0,NULL,'Lauren',NULL,'Middleton',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Middleton, Lauren','Middleton, L',258,32),(33,1,0,NULL,'Kathryn',NULL,'Aguilar',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Aguilar, Kathryn','Aguilar, K',144,33),(34,1,0,NULL,'Mark',NULL,'Long',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Long, Mark','Long, M',230,34),(35,1,0,NULL,'Donald',NULL,'Lewis',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Lewis, Donald','Lewis, D',161,35),(36,1,0,NULL,'Tiffany',NULL,'Watson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Watson, Tiffany','Watson, T',169,36),(37,1,0,NULL,'Andrea',NULL,'Irwin',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Irwin, Andrea','Irwin, A',104,37),(38,1,0,NULL,'Brittany',NULL,'Chase',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Chase, Brittany','Chase, B',47,38),(39,1,0,NULL,'Travis',NULL,'Morse',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Morse, Travis','Morse, T',220,39),(40,1,0,NULL,'Stephanie',NULL,'Cruz',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Cruz, Stephanie','Cruz, S',105,40),(41,1,0,NULL,'Brittany',NULL,'Carter',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Carter, Brittany','Carter, B',186,41),(42,1,0,NULL,'Shelley',NULL,'Harris',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Harris, Shelley','Harris, S',160,42),(43,1,0,NULL,'Scott',NULL,'Williams',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Williams, Scott','Williams, S',197,43),(44,1,0,NULL,'Cynthia',NULL,'Parker',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Parker, Cynthia','Parker, C',2,44),(45,1,0,NULL,'Curtis',NULL,'Chung',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Chung, Curtis','Chung, C',72,45),(46,1,0,NULL,'Phillip',NULL,'Maxwell',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Maxwell, Phillip','Maxwell, P',177,46),(47,1,0,NULL,'Joseph',NULL,'Diaz',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Diaz, Joseph','Diaz, J',36,47),(48,1,0,NULL,'Miranda',NULL,'Harris',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Harris, Miranda','Harris, M',93,48),(49,1,0,NULL,'Michael',NULL,'Watkins',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Watkins, Michael','Watkins, M',130,49),(50,1,0,NULL,'Catherine',NULL,'Hayden',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hayden, Catherine','Hayden, C',134,50),(51,1,0,NULL,'Tamara',NULL,'Macdonald',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Macdonald, Tamara','Macdonald, T',167,51),(52,1,0,NULL,'Peter',NULL,'Phillips',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Phillips, Peter','Phillips, P',77,52),(53,1,0,NULL,'Ryan',NULL,'Wells',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Wells, Ryan','Wells, R',9,53),(54,1,0,NULL,'Adam',NULL,'Garcia',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Garcia, Adam','Garcia, A',31,54),(55,1,0,NULL,'Stephanie',NULL,'Bright',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Bright, Stephanie','Bright, S',17,55),(56,1,0,NULL,'Kelly',NULL,'Pearson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Pearson, Kelly','Pearson, K',229,56),(57,1,0,NULL,'Joel',NULL,'Garcia',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Garcia, Joel','Garcia, J',214,57),(58,1,0,NULL,'Brian',NULL,'Clark',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Clark, Brian','Clark, B',183,58),(59,1,0,NULL,'Martha',NULL,'Foster',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Foster, Martha','Foster, M',132,59),(60,1,0,NULL,'Cynthia',NULL,'Shields',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Shields, Cynthia','Shields, C',202,60),(61,1,0,NULL,'Gloria',NULL,'Sanchez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Sanchez, Gloria','Sanchez, G',29,61),(62,1,0,NULL,'Mark',NULL,'Brown',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Brown, Mark','Brown, M',159,62),(63,1,0,NULL,'Amber',NULL,'Smith',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Smith, Amber','Smith, A',240,63),(64,1,0,NULL,'Alicia',NULL,'Kirk',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Kirk, Alicia','Kirk, A',71,64),(65,1,0,NULL,'Barbara',NULL,'Shepherd',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Shepherd, Barbara','Shepherd, B',51,65),(66,1,0,NULL,'Gina',NULL,'Smith',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Smith, Gina','Smith, G',64,66),(67,1,0,NULL,'John',NULL,'Turner',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Turner, John','Turner, J',81,67),(68,1,0,NULL,'Tracy',NULL,'Leonard',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Leonard, Tracy','Leonard, T',239,68),(69,1,0,NULL,'Tracy',NULL,'Perez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Perez, Tracy','Perez, T',203,69),(70,1,0,NULL,'Michelle',NULL,'Morales',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Morales, Michelle','Morales, M',67,70),(71,1,0,NULL,'Jeremy',NULL,'Thomas',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Thomas, Jeremy','Thomas, J',238,71),(72,1,0,NULL,'Mark',NULL,'Stephens',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Stephens, Mark','Stephens, M',49,72),(73,1,0,NULL,'Jennifer',NULL,'Larsen',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Larsen, Jennifer','Larsen, J',57,73),(74,1,0,NULL,'Jennifer',NULL,'Maldonado',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Maldonado, Jennifer','Maldonado, J',123,74),(77,1,0,NULL,'Amanda',NULL,'Raymond',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Raymond, Amanda','Raymond, A',233,77),(82,1,0,NULL,'Amanda',NULL,'Moss',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Moss, Amanda','Moss, A',11,82),(83,1,0,NULL,'Amanda',NULL,'Thompson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Thompson, Amanda','Thompson, A',121,83),(89,1,0,NULL,'Robert',NULL,'Larson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Larson, Robert','Larson, R',63,89),(94,1,0,NULL,'Ariel',NULL,'Key',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Key, Ariel','Key, A',108,94),(102,1,0,NULL,'Collin',NULL,'Smith',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Smith, Collin','Smith, C',210,102),(103,1,0,NULL,'James',NULL,'Cortez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Cortez, James','Cortez, J',227,103),(108,1,0,NULL,'Charles',NULL,'Roman',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Roman, Charles','Roman, C',223,108),(109,1,0,NULL,'Samuel',NULL,'Johnson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Johnson, Samuel','Johnson, S',234,109),(112,1,0,NULL,'Scott',NULL,'Garza',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Garza, Scott','Garza, S',225,112),(123,1,0,NULL,'Gloria',NULL,'Franco',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Franco, Gloria','Franco, G',32,123),(124,1,0,NULL,'Stefanie',NULL,'Christensen',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Christensen, Stefanie','Christensen, S',152,124),(131,1,0,NULL,'Tracy',NULL,'Smith',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Smith, Tracy','Smith, T',86,131),(132,1,0,NULL,'David',NULL,'Yates',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Yates, David','Yates, D',76,132),(133,1,0,NULL,'Cassandra',NULL,'Lam',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Lam, Cassandra','Lam, C',176,133),(141,1,0,NULL,'Bryan',NULL,'Castillo',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Castillo, Bryan','Castillo, B',188,141),(144,1,0,NULL,'Johnny',NULL,'Herrera',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Herrera, Johnny','Herrera, J',85,144),(147,1,0,NULL,'Madison',NULL,'Hawkins',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hawkins, Madison','Hawkins, M',55,147),(148,1,0,NULL,'Bridget',NULL,'Rios',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Rios, Bridget','Rios, B',204,148),(149,1,0,NULL,'Lisa',NULL,'Oneal',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Oneal, Lisa','Oneal, L',201,149),(154,1,0,NULL,'Mary',NULL,'Griffin',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Griffin, Mary','Griffin, M',0,154),(156,1,0,NULL,'Michael',NULL,'Hernandez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hernandez, Michael','Hernandez, M',222,156),(160,1,0,NULL,'Shaun',NULL,'Fisher',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Fisher, Shaun','Fisher, S',15,160),(161,1,0,NULL,'Sarah',NULL,'Schneider',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Schneider, Sarah','Schneider, S',196,161),(162,1,0,NULL,'Edward',NULL,'Hall',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hall, Edward','Hall, E',28,162),(169,1,0,NULL,'Andrew',NULL,'Jones',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Jones, Andrew','Jones, A',179,169),(184,1,0,NULL,'Ashley',NULL,'Molina',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Molina, Ashley','Molina, A',157,184),(187,1,0,NULL,'Joshua',NULL,'Rodriguez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Rodriguez, Joshua','Rodriguez, J',100,187),(193,1,0,NULL,'Mary',NULL,'Ruiz',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Ruiz, Mary','Ruiz, M',18,193),(199,1,0,NULL,'Ashley',NULL,'Guzman',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Guzman, Ashley','Guzman, A',241,199),(200,1,0,NULL,'Adrienne',NULL,'Price',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Price, Adrienne','Price, A',173,200),(204,1,0,NULL,'Cassandra',NULL,'Edwards',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Edwards, Cassandra','Edwards, C',116,204),(205,1,0,NULL,'Kristen',NULL,'Gonzalez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Gonzalez, Kristen','Gonzalez, K',43,205),(210,1,0,NULL,'James',NULL,'Barrett',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Barrett, James','Barrett, J',117,210),(211,1,0,NULL,'Jacob',NULL,'Parker',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Parker, Jacob','Parker, J',73,211),(216,1,0,NULL,'Sara',NULL,'Villa',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Villa, Sara','Villa, S',213,216),(218,1,0,NULL,'William',NULL,'Solomon',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Solomon, William','Solomon, W',60,218),(227,1,0,NULL,'Sergio',NULL,'Mcclain',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Mcclain, Sergio','Mcclain, S',75,227),(231,1,0,NULL,'Erik',NULL,'Bowers',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Bowers, Erik','Bowers, E',245,231),(239,1,0,NULL,'Robert',NULL,'Roman',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Roman, Robert','Roman, R',27,239),(240,1,0,NULL,'Arthur',NULL,'Ford',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Ford, Arthur','Ford, A',20,240),(241,1,0,NULL,'Shelia',NULL,'Allen',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Allen, Shelia','Allen, S',120,241),(242,1,0,NULL,'Michael',NULL,'Everett',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Everett, Michael','Everett, M',148,242),(243,1,0,NULL,'Jason',NULL,'Mccarthy',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Mccarthy, Jason','Mccarthy, J',139,243),(244,1,0,NULL,'Mary',NULL,'Willis',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Willis, Mary','Willis, M',6,244),(247,1,0,NULL,'Carlos',NULL,'Carpenter',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Carpenter, Carlos','Carpenter, C',118,247),(254,1,0,NULL,'Michael',NULL,'Hammond',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hammond, Michael','Hammond, M',127,254),(259,1,0,NULL,'Mark',NULL,'Frye',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Frye, Mark','Frye, M',133,259),(274,1,0,NULL,'Marcus',NULL,'Paul',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Paul, Marcus','Paul, M',92,274),(275,1,0,NULL,'Kim',NULL,'Krause',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Krause, Kim','Krause, K',211,275),(283,1,0,NULL,'Robert',NULL,'Price',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Price, Robert','Price, R',33,283),(285,1,0,NULL,'Benjamin',NULL,'Gibson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Gibson, Benjamin','Gibson, B',252,285),(289,1,0,NULL,'Mary',NULL,'Collier',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Collier, Mary','Collier, M',255,289),(290,1,0,NULL,'Melanie',NULL,'Mitchell',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Mitchell, Melanie','Mitchell, M',125,290),(291,1,0,NULL,'Samantha',NULL,'Jones',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Jones, Samantha','Jones, S',217,291),(296,1,0,NULL,'David',NULL,'Brewer',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Brewer, David','Brewer, D',237,296),(297,1,0,NULL,'James',NULL,'Taylor',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Taylor, James','Taylor, J',151,297),(298,1,0,NULL,'Sarah',NULL,'Gonzalez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Gonzalez, Sarah','Gonzalez, S',135,298),(302,1,0,NULL,'Erin',NULL,'Mejia',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Mejia, Erin','Mejia, E',90,302),(305,1,0,NULL,'Julia',NULL,'Clark',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Clark, Julia','Clark, J',111,305),(310,1,0,NULL,'Christopher',NULL,'Stanton',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Stanton, Christopher','Stanton, C',94,310),(311,1,0,NULL,'Michael',NULL,'Hartman',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hartman, Michael','Hartman, M',95,311),(314,1,0,NULL,'Samuel',NULL,'Burgess',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Burgess, Samuel','Burgess, S',194,314),(319,1,0,NULL,'Virginia',NULL,'Wong',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Wong, Virginia','Wong, V',12,319),(326,1,0,NULL,'Edward',NULL,'Klein',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Klein, Edward','Klein, E',170,326),(336,1,0,NULL,'Eric',NULL,'Cooper',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Cooper, Eric','Cooper, E',247,336),(353,1,0,NULL,'James',NULL,'Johnson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Johnson, James','Johnson, J',165,353),(354,1,0,NULL,'Lance',NULL,'Hamilton',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hamilton, Lance','Hamilton, L',34,354),(362,1,0,NULL,'David',NULL,'Lee',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Lee, David','Lee, D',145,362),(369,1,0,NULL,'Christopher',NULL,'Harris',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Harris, Christopher','Harris, C',235,369),(374,1,0,NULL,'Kevin',NULL,'Carson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Carson, Kevin','Carson, K',74,374),(382,1,0,NULL,'Scott',NULL,'Scott',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Scott, Scott','Scott, S',131,382),(386,1,0,NULL,'Eric',NULL,'Carlson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Carlson, Eric','Carlson, E',219,386),(387,1,0,NULL,'Justin',NULL,'Barry',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Barry, Justin','Barry, J',45,387),(388,1,0,NULL,'Karen',NULL,'Crosby',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Crosby, Karen','Crosby, K',37,388),(389,1,0,NULL,'Stephanie',NULL,'Martinez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Martinez, Stephanie','Martinez, S',78,389),(390,1,0,NULL,'Daniel',NULL,'Ford',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Ford, Daniel','Ford, D',216,390),(391,1,0,NULL,'Connie',NULL,'Baker',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Baker, Connie','Baker, C',14,391),(397,1,0,NULL,'Stephen',NULL,'Moore',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Moore, Stephen','Moore, S',162,397),(403,1,0,NULL,'Joseph',NULL,'Chavez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Chavez, Joseph','Chavez, J',153,403),(404,1,0,NULL,'Donna',NULL,'Gibson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Gibson, Donna','Gibson, D',30,404),(407,1,0,NULL,'Kathy',NULL,'Montgomery',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Montgomery, Kathy','Montgomery, K',189,407),(420,1,0,NULL,'Daniel',NULL,'Sullivan',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Sullivan, Daniel','Sullivan, D',8,420),(426,1,0,NULL,'Ryan',NULL,'Shaw',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Shaw, Ryan','Shaw, R',198,426),(431,1,0,NULL,'David',NULL,'Baker',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Baker, David','Baker, D',62,431),(440,1,0,NULL,'Nicholas',NULL,'Morse',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Morse, Nicholas','Morse, N',260,440),(441,1,0,NULL,'Jonathan',NULL,'Powell',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Powell, Jonathan','Powell, J',207,441),(443,1,0,NULL,'James',NULL,'Moore',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Moore, James','Moore, J',263,443),(452,1,0,NULL,'Timothy',NULL,'Cochran',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Cochran, Timothy','Cochran, T',3,452),(453,1,0,NULL,'Margaret',NULL,'Green',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Green, Margaret','Green, M',187,453),(456,1,0,NULL,'Jennifer',NULL,'Chase',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Chase, Jennifer','Chase, J',4,456),(457,1,0,NULL,'James',NULL,'Crawford',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Crawford, James','Crawford, J',83,457),(461,1,0,NULL,'Billy',NULL,'Evans',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Evans, Billy','Evans, B',58,461),(462,1,0,NULL,'Benjamin',NULL,'Molina',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Molina, Benjamin','Molina, B',24,462),(464,1,0,NULL,'Audrey',NULL,'Trevino',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Trevino, Audrey','Trevino, A',84,464),(466,1,0,NULL,'Crystal',NULL,'Jordan',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Jordan, Crystal','Jordan, C',257,466),(469,1,0,NULL,'Daniel',NULL,'Martin',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Martin, Daniel','Martin, D',82,469),(470,1,0,NULL,'Pamela',NULL,'George',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'George, Pamela','George, P',102,470),(476,1,0,NULL,'Thomas',NULL,'Brown',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Brown, Thomas','Brown, T',154,476),(490,1,0,NULL,'Tina',NULL,'Smith',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Smith, Tina','Smith, T',44,490),(493,1,0,NULL,'Adrienne',NULL,'Green',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Green, Adrienne','Green, A',221,493),(494,1,0,NULL,'Robert',NULL,'White',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'White, Robert','White, R',249,494),(501,1,0,NULL,'Caroline',NULL,'Rocha',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Rocha, Caroline','Rocha, C',175,501),(506,1,0,NULL,'Cynthia',NULL,'Murphy',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Murphy, Cynthia','Murphy, C',101,506),(507,1,0,NULL,'Christopher',NULL,'Jackson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Jackson, Christopher','Jackson, C',231,507),(519,1,0,NULL,'Robert',NULL,'Anthony',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Anthony, Robert','Anthony, R',228,519),(520,1,0,NULL,'George',NULL,'Lin',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Lin, George','Lin, G',48,520),(522,1,0,NULL,'Cynthia',NULL,'Espinoza',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Espinoza, Cynthia','Espinoza, C',65,522),(523,1,0,NULL,'Melissa',NULL,'Hopkins',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hopkins, Melissa','Hopkins, M',53,523),(524,1,0,NULL,'Marcus',NULL,'Myers',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Myers, Marcus','Myers, M',88,524),(525,1,0,NULL,'Natalie',NULL,'Johnson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Johnson, Natalie','Johnson, N',262,525),(527,1,0,NULL,'Amber',NULL,'Rivas',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Rivas, Amber','Rivas, A',106,527),(534,1,0,NULL,'Michael',NULL,'Walters',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Walters, Michael','Walters, M',182,534),(535,1,0,NULL,'Brian',NULL,'Turner',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Turner, Brian','Turner, B',103,535),(543,1,0,NULL,'Ralph',NULL,'Sutton',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Sutton, Ralph','Sutton, R',142,543),(555,1,0,NULL,'Ryan',NULL,'Cruz',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Cruz, Ryan','Cruz, R',143,555),(561,1,0,NULL,'Erica',NULL,'Little',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Little, Erica','Little, E',215,561),(565,1,0,NULL,'Karen',NULL,'Stafford',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Stafford, Karen','Stafford, K',146,565),(569,1,0,NULL,'Catherine',NULL,'Smith',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Smith, Catherine','Smith, C',52,569),(570,1,0,NULL,'Jennifer',NULL,'Payne',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Payne, Jennifer','Payne, J',61,570),(571,1,0,NULL,'Matthew',NULL,'Garcia',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Garcia, Matthew','Garcia, M',79,571),(572,1,0,NULL,'Tiffany',NULL,'Morgan',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Morgan, Tiffany','Morgan, T',119,572),(576,1,0,NULL,'Emily',NULL,'Moss',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Moss, Emily','Moss, E',149,576),(578,1,0,NULL,'Trevor',NULL,'Torres',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Torres, Trevor','Torres, T',13,578),(585,1,0,NULL,'Christopher',NULL,'Greene',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Greene, Christopher','Greene, C',190,585),(586,1,0,NULL,'Jennifer',NULL,'Buck',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Buck, Jennifer','Buck, J',138,586),(594,1,0,NULL,'Amanda',NULL,'Brown',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Brown, Amanda','Brown, A',41,594),(595,1,0,NULL,'Zoe',NULL,'Barnett',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Barnett, Zoe','Barnett, Z',38,595),(601,1,0,NULL,'Kevin',NULL,'Smith',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Smith, Kevin','Smith, K',259,601),(602,1,0,NULL,'Bradley',NULL,'Jimenez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Jimenez, Bradley','Jimenez, B',40,602),(606,1,0,NULL,'Cindy',NULL,'Cain',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Cain, Cindy','Cain, C',206,606),(608,1,0,NULL,'Kara',NULL,'Baker',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Baker, Kara','Baker, K',109,608),(611,1,0,NULL,'Jeffery',NULL,'Rodriguez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Rodriguez, Jeffery','Rodriguez, J',205,611),(613,1,0,NULL,'Anthony',NULL,'Diaz',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Diaz, Anthony','Diaz, A',246,613),(617,1,0,NULL,'Glenn',NULL,'Wells',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Wells, Glenn','Wells, G',16,617),(618,1,0,NULL,'Jacob',NULL,'Li',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Li, Jacob','Li, J',89,618),(627,1,0,NULL,'Nicholas',NULL,'Hernandez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hernandez, Nicholas','Hernandez, N',59,627),(640,1,0,NULL,'Erin',NULL,'Johnson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Johnson, Erin','Johnson, E',248,640),(641,1,0,NULL,'Shawn',NULL,'Freeman',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Freeman, Shawn','Freeman, S',39,641),(647,1,0,NULL,'Amanda',NULL,'Mccormick',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Mccormick, Amanda','Mccormick, A',178,647),(671,1,0,NULL,'Margaret',NULL,'Osborne',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Osborne, Margaret','Osborne, M',236,671),(678,1,0,NULL,'Jesse',NULL,'Mcgrath',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Mcgrath, Jesse','Mcgrath, J',163,678),(679,1,0,NULL,'Michael',NULL,'Neal',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Neal, Michael','Neal, M',158,679),(685,1,0,NULL,'Christina',NULL,'Palmer',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Palmer, Christina','Palmer, C',224,685),(693,1,0,NULL,'Jesse',NULL,'Vazquez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Vazquez, Jesse','Vazquez, J',10,693),(694,1,0,NULL,'Carolyn',NULL,'Owen',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Owen, Carolyn','Owen, C',129,694),(695,1,0,NULL,'Katherine',NULL,'Jenkins',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Jenkins, Katherine','Jenkins, K',147,695),(700,1,0,NULL,'Carly',NULL,'Holt',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Holt, Carly','Holt, C',168,700),(701,1,0,NULL,'Zachary',NULL,'Hanson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hanson, Zachary','Hanson, Z',150,701),(706,1,0,NULL,'Vanessa',NULL,'Fitzpatrick',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Fitzpatrick, Vanessa','Fitzpatrick, V',193,706),(707,1,0,NULL,'Abigail',NULL,'Wright',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Wright, Abigail','Wright, A',42,707),(717,1,0,NULL,'Mary',NULL,'Wilson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Wilson, Mary','Wilson, M',164,717),(723,1,0,NULL,'Joshua',NULL,'Sullivan',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Sullivan, Joshua','Sullivan, J',136,723),(728,1,0,NULL,'Haley',NULL,'Bates',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Bates, Haley','Bates, H',110,728),(731,1,0,NULL,'David',NULL,'Rollins',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Rollins, David','Rollins, D',128,731),(750,1,0,NULL,'Brian',NULL,'Morales',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Morales, Brian','Morales, B',50,750),(751,1,0,NULL,'Michele',NULL,'Watts',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Watts, Michele','Watts, M',226,751),(753,1,0,NULL,'Adrian',NULL,'Williams',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Williams, Adrian','Williams, A',69,753),(754,1,0,NULL,'Katherine',NULL,'Smith',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Smith, Katherine','Smith, K',19,754),(764,1,0,NULL,'Robert',NULL,'Anderson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Anderson, Robert','Anderson, R',5,764),(768,1,0,NULL,'Tracey',NULL,'Flynn',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Flynn, Tracey','Flynn, T',251,768),(774,1,0,NULL,'Jesus',NULL,'Henderson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Henderson, Jesus','Henderson, J',141,774),(777,1,0,NULL,'Ashley',NULL,'Lang',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Lang, Ashley','Lang, A',209,777),(778,1,0,NULL,'Julie',NULL,'Davis',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Davis, Julie','Davis, J',174,778),(780,1,0,NULL,'Sean',NULL,'Evans',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Evans, Sean','Evans, S',208,780),(788,1,0,NULL,'Jill',NULL,'Thompson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Thompson, Jill','Thompson, J',137,788),(789,1,0,NULL,'Rachel',NULL,'Page',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Page, Rachel','Page, R',181,789),(790,1,0,NULL,'Lawrence',NULL,'Brown',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Brown, Lawrence','Brown, L',107,790),(791,1,0,NULL,'John',NULL,'Townsend',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Townsend, John','Townsend, J',66,791),(792,1,0,NULL,'Jaclyn',NULL,'Bradford',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Bradford, Jaclyn','Bradford, J',23,792),(796,1,0,NULL,'Ryan',NULL,'Myers',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Myers, Ryan','Myers, R',115,796),(799,1,0,NULL,'Seth',NULL,'Harper',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Harper, Seth','Harper, S',87,799),(819,1,0,NULL,'Caitlin',NULL,'Gonzales',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Gonzales, Caitlin','Gonzales, C',184,819),(827,1,0,NULL,'James',NULL,'Lewis',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Lewis, James','Lewis, J',114,827),(828,1,0,NULL,'Raymond',NULL,'Wilson',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Wilson, Raymond','Wilson, R',191,828),(834,1,0,NULL,'Russell',NULL,'Hoffman',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Hoffman, Russell','Hoffman, R',91,834),(835,1,0,NULL,'Melissa',NULL,'Davis',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Davis, Melissa','Davis, M',99,835),(842,1,0,NULL,'Ethan',NULL,'Jimenez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Jimenez, Ethan','Jimenez, E',140,842),(856,1,0,NULL,'Suzanne',NULL,'Williams',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Williams, Suzanne','Williams, S',124,856),(857,1,0,NULL,'Sarah',NULL,'Poole',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Poole, Sarah','Poole, S',113,857),(861,1,0,NULL,'Alex',NULL,'Morgan',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Morgan, Alex','Morgan, A',26,861),(866,1,0,NULL,'Darlene',NULL,'Meyer',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Meyer, Darlene','Meyer, D',166,866),(878,1,0,NULL,'Susan',NULL,'Gonzalez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Gonzalez, Susan','Gonzalez, S',242,878),(879,1,0,NULL,'Alyssa',NULL,'Perez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Perez, Alyssa','Perez, A',250,879),(886,1,0,NULL,'Walter',NULL,'Jacobs',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Jacobs, Walter','Jacobs, W',96,886),(893,1,0,NULL,'Joseph',NULL,'Randolph',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Randolph, Joseph','Randolph, J',80,893),(902,1,0,NULL,'Tony',NULL,'Tran',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Tran, Tony','Tran, T',218,902),(905,1,0,NULL,'Manuel',NULL,'Lopez',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Lopez, Manuel','Lopez, M',185,905),(913,1,0,NULL,'Sarah',NULL,'Sanders',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Sanders, Sarah','Sanders, S',171,913),(923,1,0,NULL,'Amanda',NULL,'Harper',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'Harper, Amanda','Harper, A',35,923);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `piperson`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `piperson` (
  `person_id` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `long_name` varchar(400) DEFAULT NULL,
  `short_name` varchar(100) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`person_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piperson`
--

LOCK TABLES `piperson` WRITE;
/*!40000 ALTER TABLE `piperson` DISABLE KEYS */;
INSERT  IGNORE INTO `piperson` VALUES (-1,-1,'Unknown','Unknown',99999);
/*!40000 ALTER TABLE `piperson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The id of the account record.',
  `account_origin_id` int(11) NOT NULL DEFAULT '-1',
  `parent_id` int(11) DEFAULT NULL COMMENT 'The id of the parent account record, if any.',
  `charge_number` varchar(200) NOT NULL COMMENT 'The charge number associated with the allocation.',
  `creator_organization_id` int(11) DEFAULT NULL COMMENT 'The id of the organization who created this account.',
  `granttype_id` int(11) NOT NULL,
  `long_name` varchar(500) DEFAULT NULL,
  `short_name` varchar(500) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `federation_instance_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq` (`account_origin_id`,`federation_instance_id`) USING BTREE,
  KEY `index_charge` (`charge_number`,`id`) USING BTREE,
  KEY `fk_account_account1_idx` (`parent_id`) USING BTREE,
  KEY `fk_account_granttype1_idx` (`granttype_id`) USING BTREE,
  KEY `fk_account_organization1_idx` (`creator_organization_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table has records for all the accounts/projects.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT  IGNORE INTO `account` VALUES (-1,-1,NULL,'Unknown',NULL,-1,'Unknown Project','Unknown Project',-1,0);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `request` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The id of the request record.',
  `request_origin_id` int(11) NOT NULL,
  `request_type_id` int(11) NOT NULL COMMENT 'The type of the request. Links to transactiontype table.',
  `primary_fos_id` int(11) NOT NULL COMMENT 'The field of science associated with  the project of this request.',
  `account_id` int(11) NOT NULL COMMENT 'The account pertaining to this request.',
  `proposal_title` varchar(1000) DEFAULT NULL COMMENT 'The title of the proposal for the allocation request.',
  `expedite` tinyint(1) DEFAULT NULL COMMENT 'The date this request expires.',
  `project_title` varchar(300) DEFAULT NULL COMMENT 'The project title related to this request.',
  `primary_reviewer` varchar(100) DEFAULT NULL COMMENT 'The name of the primary reviewer.',
  `proposal_number` varchar(20) DEFAULT NULL COMMENT 'The number of the proposal  of the project.',
  `grant_number` varchar(200) NOT NULL COMMENT 'The grant number.',
  `comments` varchar(2000) DEFAULT NULL COMMENT 'Any comments.',
  `start_date` date NOT NULL COMMENT 'The start date of the request.',
  `end_date` date NOT NULL COMMENT 'The end of the request.',
  `boardtype_id` int(11) DEFAULT NULL COMMENT 'The board type.',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_request_account1_idx` (`account_id`) USING BTREE,
  KEY `fk_request_boardtype1_idx` (`boardtype_id`) USING BTREE,
  KEY `fk_request_fieldofscience1_idx` (`primary_fos_id`) USING BTREE,
  KEY `fk_request_transactiontype1_idx` (`request_type_id`) USING BTREE,
  KEY `index6` (`grant_number`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Requests by PIs for allocations on TG.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request`
--

LOCK TABLES `request` WRITE;
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
/*!40000 ALTER TABLE `request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemaccount`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `systemaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'the id of the record',
  `system_account_origin_id` int(11) DEFAULT NULL,
  `person_id` int(11) NOT NULL COMMENT 'The person to whom this system account belongs',
  `resource_id` int(11) NOT NULL COMMENT 'The resource for which this is an account.',
  `username` varchar(255) NOT NULL COMMENT 'The username to log on to the resource.',
  `ts` datetime DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `system_account_origin_id` (`system_account_origin_id`,`resource_id`) USING BTREE,
  KEY `fk_systemaccount_person1_idx` (`person_id`) USING BTREE,
  KEY `fk_systemaccount_resourcefact1_idx` (`resource_id`) USING BTREE,
  KEY `index_resource_username_id` (`resource_id`,`username`,`id`) USING BTREE,
  KEY `systemaccount_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=924 DEFAULT CHARSET=latin1 COMMENT='User''s accounts on various resources.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemaccount`
--

LOCK TABLES `systemaccount` WRITE;
/*!40000 ALTER TABLE `systemaccount` DISABLE KEYS */;
INSERT  IGNORE INTO `systemaccount` VALUES (1,1,1,1,'dillonkennedy','2022-03-23 07:40:59',0),(2,2,2,1,'deniseelliott','2022-03-23 07:40:59',0),(3,3,3,1,'peterberg','2022-03-23 07:40:59',0),(4,4,4,1,'michaelduarte','2022-03-23 07:40:59',0),(5,5,5,1,'scottschroeder','2022-03-23 07:40:59',0),(6,6,6,1,'edwardedwards','2022-03-23 07:40:59',0),(7,7,7,1,'timothypowell','2022-03-23 07:40:59',0),(8,8,8,1,'stephendavis','2022-03-23 07:40:59',0),(9,9,9,1,'timothycastro','2022-03-23 07:40:59',0),(10,10,10,1,'russellbyrd','2022-03-23 07:40:59',0),(11,11,11,1,'bruceleach','2022-03-23 07:40:59',0),(12,12,12,1,'hannahcain','2022-03-23 07:40:59',0),(13,13,13,1,'pattymartin','2022-03-23 07:40:59',0),(14,14,14,1,'crystalpena','2022-03-23 07:40:59',0),(15,15,15,1,'laurenyoung','2022-03-23 07:40:59',0),(16,16,16,1,'jennifergarcia','2022-03-23 07:40:59',0),(17,17,17,1,'clarencegomez','2022-03-23 07:40:59',0),(18,18,18,1,'tinawong','2022-03-23 07:40:59',0),(19,19,19,1,'michaelrogers','2022-03-23 07:40:59',0),(20,20,20,1,'kellybauer','2022-03-23 07:40:59',0),(21,21,21,1,'derekdavis','2022-03-23 07:40:59',0),(22,22,22,1,'sethmiranda','2022-03-23 07:40:59',0),(23,23,23,1,'aliciaharrell','2022-03-23 07:40:59',0),(24,24,24,1,'adamcamacho','2022-03-23 07:40:59',0),(25,25,25,1,'terrancemartinez','2022-03-23 07:40:59',0),(26,26,26,1,'michaelross','2022-03-23 07:40:59',0),(27,27,27,1,'bradleyhahn','2022-03-23 07:40:59',0),(28,28,28,1,'brianmcdonald','2022-03-23 07:40:59',0),(29,29,29,1,'timothyrobinson','2022-03-23 07:40:59',0),(30,30,30,1,'angelagould','2022-03-23 07:40:59',0),(31,31,31,1,'melissapollard','2022-03-23 07:40:59',0),(32,32,32,1,'laurenmiddleton','2022-03-23 07:40:59',0),(33,33,33,1,'kathrynaguilar','2022-03-23 07:40:59',0),(34,34,34,1,'marklong','2022-03-23 07:40:59',0),(35,35,35,1,'donaldlewis','2022-03-23 07:40:59',0),(36,36,36,1,'tiffanywatson','2022-03-23 07:40:59',0),(37,37,37,1,'andreairwin','2022-03-23 07:40:59',0),(38,38,38,1,'brittanychase','2022-03-23 07:40:59',0),(39,39,39,1,'travismorse','2022-03-23 07:40:59',0),(40,40,40,1,'stephaniecruz','2022-03-23 07:40:59',0),(41,41,41,1,'brittanycarter','2022-03-23 07:40:59',0),(42,42,42,1,'shelleyharris','2022-03-23 07:40:59',0),(43,43,43,1,'scottwilliams','2022-03-23 07:40:59',0),(44,44,44,1,'cynthiaparker','2022-03-23 07:40:59',0),(45,45,45,1,'curtischung','2022-03-23 07:40:59',0),(46,46,46,1,'phillipmaxwell','2022-03-23 07:40:59',0),(47,47,47,1,'josephdiaz','2022-03-23 07:40:59',0),(48,48,48,1,'mirandaharris','2022-03-23 07:40:59',0),(49,49,49,1,'michaelwatkins','2022-03-23 07:40:59',0),(50,50,50,1,'catherinehayden','2022-03-23 07:40:59',0),(51,51,51,1,'tamaramacdonald','2022-03-23 07:40:59',0),(52,52,52,1,'peterphillips','2022-03-23 07:40:59',0),(53,53,53,1,'ryanwells','2022-03-23 07:40:59',0),(54,54,54,1,'adamgarcia','2022-03-23 07:40:59',0),(55,55,55,1,'stephaniebright','2022-03-23 07:40:59',0),(56,56,56,1,'kellypearson','2022-03-23 07:40:59',0),(57,57,57,1,'joelgarcia','2022-03-23 07:40:59',0),(58,58,58,1,'brianclark','2022-03-23 07:40:59',0),(59,59,59,1,'marthafoster','2022-03-23 07:40:59',0),(60,60,60,1,'cynthiashields','2022-03-23 07:40:59',0),(61,61,61,1,'gloriasanchez','2022-03-23 07:40:59',0),(62,62,62,1,'markbrown','2022-03-23 07:40:59',0),(63,63,63,1,'ambersmith','2022-03-23 07:40:59',0),(64,64,64,1,'aliciakirk','2022-03-23 07:40:59',0),(65,65,65,1,'barbarashepherd','2022-03-23 07:40:59',0),(66,66,66,1,'ginasmith','2022-03-23 07:40:59',0),(67,67,67,1,'johnturner','2022-03-23 07:40:59',0),(68,68,68,1,'tracyleonard','2022-03-23 07:40:59',0),(69,69,69,1,'tracyperez','2022-03-23 07:40:59',0),(70,70,70,1,'michellemorales','2022-03-23 07:40:59',0),(71,71,71,1,'jeremythomas','2022-03-23 07:40:59',0),(72,72,72,1,'markstephens','2022-03-23 07:40:59',0),(73,73,73,1,'jenniferlarsen','2022-03-23 07:40:59',0),(74,74,74,1,'jennifermaldonado','2022-03-23 07:40:59',0),(77,77,77,1,'amandaraymond','2022-03-23 07:40:59',0),(82,82,82,1,'amandamoss','2022-03-23 07:40:59',0),(83,83,83,1,'amandathompson','2022-03-23 07:40:59',0),(89,89,89,1,'robertlarson','2022-03-23 07:40:59',0),(94,94,94,1,'arielkey','2022-03-23 07:40:59',0),(102,102,102,1,'collinsmith','2022-03-23 07:40:59',0),(103,103,103,1,'jamescortez','2022-03-23 07:40:59',0),(108,108,108,1,'charlesroman','2022-03-23 07:40:59',0),(109,109,109,1,'samueljohnson','2022-03-23 07:40:59',0),(112,112,112,1,'scottgarza','2022-03-23 07:40:59',0),(123,123,123,1,'gloriafranco','2022-03-23 07:40:59',0),(124,124,124,1,'stefaniechristensen','2022-03-23 07:40:59',0),(131,131,131,1,'tracysmith','2022-03-23 07:40:59',0),(132,132,132,1,'davidyates','2022-03-23 07:40:59',0),(133,133,133,1,'cassandralam','2022-03-23 07:40:59',0),(141,141,141,1,'bryancastillo','2022-03-23 07:40:59',0),(144,144,144,1,'johnnyherrera','2022-03-23 07:40:59',0),(147,147,147,1,'madisonhawkins','2022-03-23 07:40:59',0),(148,148,148,1,'bridgetrios','2022-03-23 07:40:59',0),(149,149,149,1,'lisaoneal','2022-03-23 07:40:59',0),(154,154,154,1,'marygriffin','2022-03-23 07:40:59',0),(156,156,156,1,'michaelhernandez','2022-03-23 07:40:59',0),(160,160,160,1,'shaunfisher','2022-03-23 07:40:59',0),(161,161,161,1,'sarahschneider','2022-03-23 07:40:59',0),(162,162,162,1,'edwardhall','2022-03-23 07:40:59',0),(169,169,169,1,'andrewjones','2022-03-23 07:40:59',0),(184,184,184,1,'ashleymolina','2022-03-23 07:40:59',0),(187,187,187,1,'joshuarodriguez','2022-03-23 07:40:59',0),(193,193,193,1,'maryruiz','2022-03-23 07:40:59',0),(199,199,199,1,'ashleyguzman','2022-03-23 07:40:59',0),(200,200,200,1,'adrienneprice','2022-03-23 07:40:59',0),(204,204,204,1,'cassandraedwards','2022-03-23 07:40:59',0),(205,205,205,1,'kristengonzalez','2022-03-23 07:40:59',0),(210,210,210,1,'jamesbarrett','2022-03-23 07:40:59',0),(211,211,211,1,'jacobparker','2022-03-23 07:40:59',0),(216,216,216,1,'saravilla','2022-03-23 07:40:59',0),(218,218,218,1,'williamsolomon','2022-03-23 07:40:59',0),(227,227,227,1,'sergiomcclain','2022-03-23 07:40:59',0),(231,231,231,1,'erikbowers','2022-03-23 07:40:59',0),(239,239,239,1,'robertroman','2022-03-23 07:40:59',0),(240,240,240,1,'arthurford','2022-03-23 07:40:59',0),(241,241,241,1,'sheliaallen','2022-03-23 07:40:59',0),(242,242,242,1,'michaeleverett','2022-03-23 07:40:59',0),(243,243,243,1,'jasonmccarthy','2022-03-23 07:40:59',0),(244,244,244,1,'marywillis','2022-03-23 07:40:59',0),(247,247,247,1,'carloscarpenter','2022-03-23 07:40:59',0),(254,254,254,1,'michaelhammond','2022-03-23 07:40:59',0),(259,259,259,1,'markfrye','2022-03-23 07:40:59',0),(274,274,274,1,'marcuspaul','2022-03-23 07:40:59',0),(275,275,275,1,'kimkrause','2022-03-23 07:40:59',0),(283,283,283,1,'robertprice','2022-03-23 07:40:59',0),(285,285,285,1,'benjamingibson','2022-03-23 07:40:59',0),(289,289,289,1,'marycollier','2022-03-23 07:40:59',0),(290,290,290,1,'melaniemitchell','2022-03-23 07:40:59',0),(291,291,291,1,'samanthajones','2022-03-23 07:40:59',0),(296,296,296,1,'davidbrewer','2022-03-23 07:40:59',0),(297,297,297,1,'jamestaylor','2022-03-23 07:40:59',0),(298,298,298,1,'sarahgonzalez','2022-03-23 07:40:59',0),(302,302,302,1,'erinmejia','2022-03-23 07:40:59',0),(305,305,305,1,'juliaclark','2022-03-23 07:40:59',0),(310,310,310,1,'christopherstanton','2022-03-23 07:40:59',0),(311,311,311,1,'michaelhartman','2022-03-23 07:40:59',0),(314,314,314,1,'samuelburgess','2022-03-23 07:40:59',0),(319,319,319,1,'virginiawong','2022-03-23 07:40:59',0),(326,326,326,1,'edwardklein','2022-03-23 07:40:59',0),(336,336,336,1,'ericcooper','2022-03-23 07:40:59',0),(353,353,353,1,'jamesjohnson','2022-03-23 07:40:59',0),(354,354,354,1,'lancehamilton','2022-03-23 07:40:59',0),(362,362,362,1,'davidlee','2022-03-23 07:40:59',0),(369,369,369,1,'christopherharris','2022-03-23 07:40:59',0),(374,374,374,1,'kevincarson','2022-03-23 07:40:59',0),(382,382,382,1,'scottscott','2022-03-23 07:40:59',0),(386,386,386,1,'ericcarlson','2022-03-23 07:40:59',0),(387,387,387,1,'justinbarry','2022-03-23 07:40:59',0),(388,388,388,1,'karencrosby','2022-03-23 07:40:59',0),(389,389,389,1,'stephaniemartinez','2022-03-23 07:40:59',0),(390,390,390,1,'danielford','2022-03-23 07:40:59',0),(391,391,391,1,'conniebaker','2022-03-23 07:40:59',0),(397,397,397,1,'stephenmoore','2022-03-23 07:40:59',0),(403,403,403,1,'josephchavez','2022-03-23 07:40:59',0),(404,404,404,1,'donnagibson','2022-03-23 07:40:59',0),(407,407,407,1,'kathymontgomery','2022-03-23 07:40:59',0),(420,420,420,1,'danielsullivan','2022-03-23 07:40:59',0),(426,426,426,1,'ryanshaw','2022-03-23 07:40:59',0),(431,431,431,1,'davidbaker','2022-03-23 07:40:59',0),(440,440,440,1,'nicholasmorse','2022-03-23 07:40:59',0),(441,441,441,1,'jonathanpowell','2022-03-23 07:40:59',0),(443,443,443,1,'jamesmoore','2022-03-23 07:40:59',0),(452,452,452,1,'timothycochran','2022-03-23 07:40:59',0),(453,453,453,1,'margaretgreen','2022-03-23 07:40:59',0),(456,456,456,1,'jenniferchase','2022-03-23 07:40:59',0),(457,457,457,1,'jamescrawford','2022-03-23 07:40:59',0),(461,461,461,1,'billyevans','2022-03-23 07:40:59',0),(462,462,462,1,'benjaminmolina','2022-03-23 07:40:59',0),(464,464,464,1,'audreytrevino','2022-03-23 07:40:59',0),(466,466,466,1,'crystaljordan','2022-03-23 07:40:59',0),(469,469,469,1,'danielmartin','2022-03-23 07:40:59',0),(470,470,470,1,'pamelageorge','2022-03-23 07:40:59',0),(476,476,476,1,'thomasbrown','2022-03-23 07:40:59',0),(490,490,490,1,'tinasmith','2022-03-23 07:40:59',0),(493,493,493,1,'adriennegreen','2022-03-23 07:40:59',0),(494,494,494,1,'robertwhite','2022-03-23 07:40:59',0),(501,501,501,1,'carolinerocha','2022-03-23 07:40:59',0),(506,506,506,1,'cynthiamurphy','2022-03-23 07:40:59',0),(507,507,507,1,'christopherjackson','2022-03-23 07:40:59',0),(519,519,519,1,'robertanthony','2022-03-23 07:40:59',0),(520,520,520,1,'georgelin','2022-03-23 07:40:59',0),(522,522,522,1,'cynthiaespinoza','2022-03-23 07:40:59',0),(523,523,523,1,'melissahopkins','2022-03-23 07:40:59',0),(524,524,524,1,'marcusmyers','2022-03-23 07:40:59',0),(525,525,525,1,'nataliejohnson','2022-03-23 07:40:59',0),(527,527,527,1,'amberrivas','2022-03-23 07:40:59',0),(534,534,534,1,'michaelwalters','2022-03-23 07:40:59',0),(535,535,535,1,'brianturner','2022-03-23 07:40:59',0),(543,543,543,1,'ralphsutton','2022-03-23 07:40:59',0),(555,555,555,1,'ryancruz','2022-03-23 07:40:59',0),(561,561,561,1,'ericalittle','2022-03-23 07:40:59',0),(565,565,565,1,'karenstafford','2022-03-23 07:40:59',0),(569,569,569,1,'catherinesmith','2022-03-23 07:40:59',0),(570,570,570,1,'jenniferpayne','2022-03-23 07:40:59',0),(571,571,571,1,'matthewgarcia','2022-03-23 07:40:59',0),(572,572,572,1,'tiffanymorgan','2022-03-23 07:40:59',0),(576,576,576,1,'emilymoss','2022-03-23 07:40:59',0),(578,578,578,1,'trevortorres','2022-03-23 07:40:59',0),(585,585,585,1,'christophergreene','2022-03-23 07:40:59',0),(586,586,586,1,'jenniferbuck','2022-03-23 07:40:59',0),(594,594,594,1,'amandabrown','2022-03-23 07:40:59',0),(595,595,595,1,'zoebarnett','2022-03-23 07:40:59',0),(601,601,601,1,'kevinsmith','2022-03-23 07:40:59',0),(602,602,602,1,'bradleyjimenez','2022-03-23 07:40:59',0),(606,606,606,1,'cindycain','2022-03-23 07:40:59',0),(608,608,608,1,'karabaker','2022-03-23 07:40:59',0),(611,611,611,1,'jefferyrodriguez','2022-03-23 07:40:59',0),(613,613,613,1,'anthonydiaz','2022-03-23 07:40:59',0),(617,617,617,1,'glennwells','2022-03-23 07:40:59',0),(618,618,618,1,'jacobli','2022-03-23 07:40:59',0),(627,627,627,1,'nicholashernandez','2022-03-23 07:40:59',0),(640,640,640,1,'erinjohnson','2022-03-23 07:40:59',0),(641,641,641,1,'shawnfreeman','2022-03-23 07:40:59',0),(647,647,647,1,'amandamccormick','2022-03-23 07:40:59',0),(671,671,671,1,'margaretosborne','2022-03-23 07:40:59',0),(678,678,678,1,'jessemcgrath','2022-03-23 07:40:59',0),(679,679,679,1,'michaelneal','2022-03-23 07:40:59',0),(685,685,685,1,'christinapalmer','2022-03-23 07:40:59',0),(693,693,693,1,'jessevazquez','2022-03-23 07:40:59',0),(694,694,694,1,'carolynowen','2022-03-23 07:40:59',0),(695,695,695,1,'katherinejenkins','2022-03-23 07:40:59',0),(700,700,700,1,'carlyholt','2022-03-23 07:40:59',0),(701,701,701,1,'zacharyhanson','2022-03-23 07:40:59',0),(706,706,706,1,'vanessafitzpatrick','2022-03-23 07:40:59',0),(707,707,707,1,'abigailwright','2022-03-23 07:40:59',0),(717,717,717,1,'marywilson','2022-03-23 07:40:59',0),(723,723,723,1,'joshuasullivan','2022-03-23 07:40:59',0),(728,728,728,1,'haleybates','2022-03-23 07:40:59',0),(731,731,731,1,'davidrollins','2022-03-23 07:40:59',0),(750,750,750,1,'brianmorales','2022-03-23 07:40:59',0),(751,751,751,1,'michelewatts','2022-03-23 07:40:59',0),(753,753,753,1,'adrianwilliams','2022-03-23 07:40:59',0),(754,754,754,1,'katherinesmith','2022-03-23 07:40:59',0),(764,764,764,1,'robertanderson','2022-03-23 07:40:59',0),(768,768,768,1,'traceyflynn','2022-03-23 07:40:59',0),(774,774,774,1,'jesushenderson','2022-03-23 07:40:59',0),(777,777,777,1,'ashleylang','2022-03-23 07:40:59',0),(778,778,778,1,'juliedavis','2022-03-23 07:40:59',0),(780,780,780,1,'seanevans','2022-03-23 07:40:59',0),(788,788,788,1,'jillthompson','2022-03-23 07:40:59',0),(789,789,789,1,'rachelpage','2022-03-23 07:40:59',0),(790,790,790,1,'lawrencebrown','2022-03-23 07:40:59',0),(791,791,791,1,'johntownsend','2022-03-23 07:40:59',0),(792,792,792,1,'jaclynbradford','2022-03-23 07:40:59',0),(796,796,796,1,'ryanmyers','2022-03-23 07:40:59',0),(799,799,799,1,'sethharper','2022-03-23 07:40:59',0),(819,819,819,1,'caitlingonzales','2022-03-23 07:40:59',0),(827,827,827,1,'jameslewis','2022-03-23 07:40:59',0),(828,828,828,1,'raymondwilson','2022-03-23 07:40:59',0),(834,834,834,1,'russellhoffman','2022-03-23 07:40:59',0),(835,835,835,1,'melissadavis','2022-03-23 07:40:59',0),(842,842,842,1,'ethanjimenez','2022-03-23 07:40:59',0),(856,856,856,1,'suzannewilliams','2022-03-23 07:40:59',0),(857,857,857,1,'sarahpoole','2022-03-23 07:40:59',0),(861,861,861,1,'alexmorgan','2022-03-23 07:40:59',0),(866,866,866,1,'darlenemeyer','2022-03-23 07:40:59',0),(878,878,878,1,'susangonzalez','2022-03-23 07:40:59',0),(879,879,879,1,'alyssaperez','2022-03-23 07:40:59',0),(886,886,886,1,'walterjacobs','2022-03-23 07:40:59',0),(893,893,893,1,'josephrandolph','2022-03-23 07:40:59',0),(902,902,902,1,'tonytran','2022-03-23 07:40:59',0),(905,905,905,1,'manuellopez','2022-03-23 07:40:59',0),(913,913,913,1,'sarahsanders','2022-03-23 07:40:59',0),(923,923,923,1,'amandaharper','2022-03-23 07:40:59',0);
/*!40000 ALTER TABLE `systemaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `principalinvestigator`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `principalinvestigator` (
  `person_id` int(11) NOT NULL COMMENT 'The id of the person of the PI.',
  `request_id` int(11) NOT NULL COMMENT 'The request id.',
  PRIMARY KEY (`person_id`,`request_id`) USING BTREE,
  KEY `fk_princialinvestigator_person1_idx` (`person_id`) USING BTREE,
  KEY `fk_princialinvestigator_request1_idx` (`request_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Only PIs are allowed to make requests.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `principalinvestigator`
--

LOCK TABLES `principalinvestigator` WRITE;
/*!40000 ALTER TABLE `principalinvestigator` DISABLE KEYS */;
/*!40000 ALTER TABLE `principalinvestigator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_venue`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `submission_venue` (
  `submission_venue_id` int(11) NOT NULL,
  `submission_venue` varchar(64) NOT NULL COMMENT 'Short version or abbrev',
  `display` varchar(256) NOT NULL COMMENT 'What to show the user',
  `description` varchar(1024) DEFAULT NULL,
  `order_id` int(5) unsigned NOT NULL,
  PRIMARY KEY (`submission_venue_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Submission mechanism: cli, gateway, etc.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_venue`
--

LOCK TABLES `submission_venue` WRITE;
/*!40000 ALTER TABLE `submission_venue` DISABLE KEYS */;
INSERT  IGNORE INTO `submission_venue` VALUES (-1,' unknown',' Unknown',' Unknown',1),(1,' cli',' CLI',' Command Line Interface',3),(2,' gateway',' Gateway',' Science Gateway',4),(3,' openstack-api',' OpenStack API',' OpenStack API',5);
/*!40000 ALTER TABLE `submission_venue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-28 21:14:24
