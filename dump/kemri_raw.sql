-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: kemri
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.22.04.1

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
-- Table structure for table `kemri_appointmentschedule`
--

DROP TABLE IF EXISTS `kemri_appointmentschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_appointmentschedule` (
  `taskId` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `subcountyId` int DEFAULT NULL,
  `wardId` int DEFAULT NULL,
  `departmentId` int DEFAULT NULL,
  `projectId` int DEFAULT NULL,
  `taskName` varchar(255) DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `description` text,
  `isAllDay` tinyint(1) DEFAULT NULL,
  `recurrenceId` int DEFAULT NULL,
  `recurrenceRule` varchar(255) DEFAULT NULL,
  `recurrenceException` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`taskId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_appointmentschedule`
--

LOCK TABLES `kemri_appointmentschedule` WRITE;
/*!40000 ALTER TABLE `kemri_appointmentschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_appointmentschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_attachments`
--

DROP TABLE IF EXISTS `kemri_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_attachments` (
  `attachmentId` int NOT NULL AUTO_INCREMENT,
  `assetId` int DEFAULT NULL,
  `typeId` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` text,
  `size` int DEFAULT NULL,
  `contentBlob` varchar(255) DEFAULT NULL,
  `description` text,
  `documentNo` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attachmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_attachments`
--

LOCK TABLES `kemri_attachments` WRITE;
/*!40000 ALTER TABLE `kemri_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_attachmenttypes`
--

DROP TABLE IF EXISTS `kemri_attachmenttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_attachmenttypes` (
  `typeId` int NOT NULL AUTO_INCREMENT,
  `attachmentName` varchar(255) DEFAULT NULL,
  `description` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_attachmenttypes`
--

LOCK TABLES `kemri_attachmenttypes` WRITE;
/*!40000 ALTER TABLE `kemri_attachmenttypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_attachmenttypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_categories`
--

DROP TABLE IF EXISTS `kemri_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_categories` (
  `categoryId` int NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(255) DEFAULT NULL,
  `description` text,
  `picture` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_categories`
--

LOCK TABLES `kemri_categories` WRITE;
/*!40000 ALTER TABLE `kemri_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_contractors`
--

DROP TABLE IF EXISTS `kemri_contractors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_contractors` (
  `contractorId` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `companyName` varchar(255) DEFAULT NULL,
  `contactName` varchar(255) DEFAULT NULL,
  `contactTitle` varchar(255) DEFAULT NULL,
  `address` text,
  `productService` varchar(255) DEFAULT NULL,
  `county` int DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `postalCode` varchar(255) DEFAULT NULL,
  `country` int DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` text,
  `homePage` int DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`contractorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_contractors`
--

LOCK TABLES `kemri_contractors` WRITE;
/*!40000 ALTER TABLE `kemri_contractors` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_contractors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_counties`
--

DROP TABLE IF EXISTS `kemri_counties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_counties` (
  `countyId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `geoSpatial` varchar(255) DEFAULT NULL,
  `geoCode` varchar(255) DEFAULT NULL,
  `geoLat` decimal(10,7) DEFAULT NULL,
  `geoLon` decimal(10,7) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`countyId`),
  UNIQUE KEY `uq_county_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_counties`
--

LOCK TABLES `kemri_counties` WRITE;
/*!40000 ALTER TABLE `kemri_counties` DISABLE KEYS */;
INSERT INTO `kemri_counties` VALUES (1,'Kisumu','POINT(34.7617 -0.1022)','KSM',-0.1022000,34.7617000,0,NULL),(2,'Nairobi','POINT(36.8219 -1.2921)','NBO',-1.2921000,36.8219000,0,NULL),(3,'Mombasa','POINT(39.6682 -4.0437)','MSA',-4.0437000,39.6682000,0,NULL),(4,'Turkana','POINT(35.5975 3.1118)','TRK',3.1118000,35.5975000,0,NULL),(5,'Marsabit','POINT(37.9868 2.3482)','MRS',2.3482000,37.9868000,0,NULL),(6,'Garissa','POINT(39.6450 -0.4560)','GRS',-0.4560000,39.6450000,0,NULL);
/*!40000 ALTER TABLE `kemri_counties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_departments`
--

DROP TABLE IF EXISTS `kemri_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_departments` (
  `departmentId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `alias` text,
  `location` text,
  `address` text,
  `contactPerson` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `email` text,
  `remarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`departmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_departments`
--

LOCK TABLES `kemri_departments` WRITE;
/*!40000 ALTER TABLE `kemri_departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_sections`
--

DROP TABLE IF EXISTS `kemri_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_sections` (
  `sectionId` int NOT NULL AUTO_INCREMENT,
  `departmentId` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `alias` text,
  `location` text,
  `address` text,
  `contactPerson` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `email` text,
  `remarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sectionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_sections`
--

LOCK TABLES `kemri_sections` WRITE;
/*!40000 ALTER TABLE `kemri_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_financialyears`
--

DROP TABLE IF EXISTS `kemri_financialyears`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_financialyears` (
  `finYearId` int NOT NULL AUTO_INCREMENT,
  `finYearName` varchar(255) DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `remarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`finYearId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_financialyears`
--

LOCK TABLES `kemri_financialyears` WRITE;
/*!40000 ALTER TABLE `kemri_financialyears` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_financialyears` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_kemri_milestones`
--

DROP TABLE IF EXISTS `kemri_kemri_milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_kemri_milestones` (
  `milestoneId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `milestoneName` varchar(255) DEFAULT NULL,
  `milestoneDescription` text,
  `dueDate` datetime DEFAULT NULL,
  `completed` tinyint(1) DEFAULT NULL,
  `completedDate` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`milestoneId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_kemri_milestones`
--

LOCK TABLES `kemri_kemri_milestones` WRITE;
/*!40000 ALTER TABLE `kemri_kemri_milestones` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_kemri_milestones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_participants`
--

DROP TABLE IF EXISTS `kemri_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_participants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `individualId` int DEFAULT NULL,
  `householdId` int DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `villageLocality` int DEFAULT NULL,
  `gpsLongitude` decimal(10,7) DEFAULT NULL,
  `gpsLatitude` decimal(10,7) DEFAULT NULL,
  `vectorBorneDiseaseStatus` varchar(255) DEFAULT NULL,
  `malariaDiagnosis` varchar(255) DEFAULT NULL,
  `dengueDiagnosis` varchar(255) DEFAULT NULL,
  `leishmaniasisDiagnosis` varchar(255) DEFAULT NULL,
  `waterSource` varchar(255) DEFAULT NULL,
  `housingType` varchar(255) DEFAULT NULL,
  `mosquitoNetUsage` int DEFAULT NULL,
  `educationLevel` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `incomeKshMonth` decimal(15,2) DEFAULT NULL,
  `accessToHealthcareKm` varchar(255) DEFAULT NULL,
  `climatePerceptionScore` decimal(15,2) DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_participants`
--

LOCK TABLES `kemri_participants` WRITE;
/*!40000 ALTER TABLE `kemri_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_planpregistry`
--

DROP TABLE IF EXISTS `kemri_planpregistry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_planpregistry` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cidpid` varchar(255) DEFAULT NULL,
  `cidpName` varchar(255) DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `theme` text,
  `vision` text,
  `mission` text,
  `remarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_planpregistry`
--

LOCK TABLES `kemri_planpregistry` WRITE;
/*!40000 ALTER TABLE `kemri_planpregistry` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_planpregistry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_privileges`
--

DROP TABLE IF EXISTS `kemri_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_privileges` (
  `privilegeId` int NOT NULL AUTO_INCREMENT,
  `privilegeName` varchar(255) DEFAULT NULL,
  `description` text,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`privilegeId`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_privileges`
--

LOCK TABLES `kemri_privileges` WRITE;
/*!40000 ALTER TABLE `kemri_privileges` DISABLE KEYS */;
INSERT INTO `kemri_privileges` VALUES (1,'user.read_all','Allows viewing all user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(2,'user.create','Allows creating new user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(3,'user.update','Allows updating existing user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(4,'user.delete','Allows deleting user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(5,'project.read_all','Allows viewing all projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(6,'project.create','Allows creating new projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(7,'project.update','Allows updating existing projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(8,'project.delete','Allows deleting projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(9,'project.manage_own','Allows managing projects assigned to the user (e.g., project lead).','2025-07-19 00:12:32','2025-07-19 00:12:32'),(10,'task.read_all','Allows viewing all tasks across projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(11,'task.create','Allows creating new tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(12,'task.update','Allows updating existing tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(13,'task.delete','Allows deleting tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(14,'task.manage_assignees','Allows assigning/unassigning staff to tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(15,'task.manage_dependencies','Allows managing task dependencies.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(16,'milestone.read_all','Allows viewing all milestones across projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(17,'milestone.create','Allows creating new milestones.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(18,'milestone.update','Allows updating existing milestones.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(19,'milestone.delete','Allows deleting milestones.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(20,'raw_data.view','Allows viewing raw data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(21,'raw_data.export','Allows exporting raw data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(22,'raw_data.create','Allows adding new raw data entries.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(23,'raw_data.update','Allows modifying raw data entries.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(24,'raw_data.delete','Allows deleting raw data entries.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(25,'dashboard.view','Allows viewing the main dashboard.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(26,'reports.view_all','Allows viewing all system reports.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(27,'user.read_all','Allows viewing all user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(28,'user.create','Allows creating new user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(29,'user.update','Allows updating existing user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(30,'user.delete','Allows deleting user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(31,'project.read_all','Allows viewing all projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(32,'project.create','Allows creating new projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(33,'project.update','Allows updating existing projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(34,'project.delete','Allows deleting projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(35,'project.manage_own','Allows managing projects assigned to the user (e.g., project lead).','2025-07-19 00:12:32','2025-07-19 00:12:32'),(36,'task.read_all','Allows viewing all tasks across projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(37,'task.create','Allows creating new tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(38,'task.update','Allows updating existing tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(39,'task.delete','Allows deleting tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(40,'task.manage_assignees','Allows assigning/unassigning staff to tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(41,'task.manage_dependencies','Allows managing task dependencies.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(42,'milestone.read_all','Allows viewing all milestones across projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(43,'milestone.create','Allows creating new milestones.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(44,'milestone.update','Allows updating existing milestones.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(45,'milestone.delete','Allows deleting milestones.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(46,'raw_data.view','Allows viewing raw data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(47,'raw_data.export','Allows exporting raw data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(48,'raw_data.create','Allows adding new raw data entries.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(49,'raw_data.update','Allows modifying raw data entries.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(50,'raw_data.delete','Allows deleting raw data entries.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(51,'dashboard.view','Allows viewing the main dashboard.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(52,'reports.view_all','Allows viewing all system reports.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(58,'user.read_all','Allows viewing all user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(59,'user.create','Allows creating new user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(60,'user.update','Allows updating existing user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(61,'user.delete','Allows deleting user accounts.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(62,'project.read_all','Allows viewing all projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(63,'project.create','Allows creating new projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(64,'project.update','Allows updating existing projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(65,'project.delete','Allows deleting projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(66,'project.manage_own','Allows managing projects assigned to the user (e.g., project lead).','2025-07-19 00:12:32','2025-07-19 00:12:32'),(67,'task.read_all','Allows viewing all tasks across projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(68,'task.create','Allows creating new tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(69,'task.update','Allows updating existing tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(70,'task.delete','Allows deleting tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(71,'task.manage_assignees','Allows assigning/unassigning staff to tasks.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(72,'task.manage_dependencies','Allows managing task dependencies.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(73,'milestone.read_all','Allows viewing all milestones across projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(74,'milestone.create','Allows creating new milestones.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(75,'milestone.update','Allows updating existing milestones.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(76,'milestone.delete','Allows deleting milestones.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(77,'raw_data.view','Allows viewing raw data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(78,'raw_data.export','Allows exporting raw data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(79,'raw_data.create','Allows adding new raw data entries.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(80,'raw_data.update','Allows modifying raw data entries.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(81,'raw_data.delete','Allows deleting raw data entries.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(82,'dashboard.view','Allows viewing the main dashboard.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(83,'reports.view_all','Allows viewing all system reports.','2025-07-19 00:12:32','2025-07-19 00:12:32');
/*!40000 ALTER TABLE `kemri_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_project_counties`
--

DROP TABLE IF EXISTS `kemri_project_counties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_project_counties` (
  `projectId` int NOT NULL,
  `countyId` int NOT NULL,
  `assignedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`projectId`,`countyId`),
  KEY `fk_project_county_county` (`countyId`),
  CONSTRAINT `fk_project_county_county` FOREIGN KEY (`countyId`) REFERENCES `kemri_counties` (`countyId`) ON DELETE CASCADE,
  CONSTRAINT `fk_project_county_project` FOREIGN KEY (`projectId`) REFERENCES `kemri_projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_project_counties`
--

LOCK TABLES `kemri_project_counties` WRITE;
/*!40000 ALTER TABLE `kemri_project_counties` DISABLE KEYS */;
INSERT INTO `kemri_project_counties` VALUES (1,1,'2025-07-21 15:37:57'),(1,4,'2025-07-21 15:37:57'),(2,1,'2025-07-21 15:37:57'),(3,2,'2025-07-21 15:37:57'),(4,1,'2025-07-21 15:37:57'),(5,3,'2025-07-21 15:37:57'),(7,4,'2025-07-21 15:37:57'),(7,5,'2025-07-21 15:37:57');
/*!40000 ALTER TABLE `kemri_project_counties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_project_roles`
--

DROP TABLE IF EXISTS `kemri_project_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_project_roles` (
  `roleId` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_project_roles`
--

LOCK TABLES `kemri_project_roles` WRITE;
/*!40000 ALTER TABLE `kemri_project_roles` DISABLE KEYS */;
INSERT INTO `kemri_project_roles` VALUES (1,'Principal Investigator','Overall lead of the project, responsible for scientific and administrative oversight.'),(2,'Co-Investigator','Collaborates with the PI on the scientific aspects of the project.'),(3,'Project Manager','Responsible for day-to-day project operations, scheduling, and resources.'),(4,'Research Assistant','Assists with data collection, lab work, and other research tasks.'),(5,'Data Manager','Manages project data, ensuring quality, security, and accessibility.'),(6,'Statistician','Provides statistical expertise for study design and data analysis.'),(7,'Lab Lead','Oversees laboratory activities related to the project.'),(8,'Field Coordinator','Manages field operations and community engagement.'),(9,'Administrator','Handles administrative and logistical support for the project.'),(10,'Principal Investigator','Overall lead of the project, responsible for scientific and administrative oversight.'),(11,'Co-Investigator','Collaborates with the PI on the scientific aspects of the project.'),(12,'Project Manager','Responsible for day-to-day project operations, scheduling, and resources.'),(13,'Research Assistant','Assists with data collection, lab work, and other research tasks.'),(14,'Data Manager','Manages project data, ensuring quality, security, and accessibility.'),(15,'Statistician','Provides statistical expertise for study design and data analysis.'),(16,'Lab Lead','Oversees laboratory activities related to the project.'),(17,'Field Coordinator','Manages field operations and community engagement.'),(18,'Administrator','Handles administrative and logistical support for the project.'),(25,'Principal Investigator','Overall lead of the project, responsible for scientific and administrative oversight.'),(26,'Co-Investigator','Collaborates with the PI on the scientific aspects of the project.'),(27,'Project Manager','Responsible for day-to-day project operations, scheduling, and resources.'),(28,'Research Assistant','Assists with data collection, lab work, and other research tasks.'),(29,'Data Manager','Manages project data, ensuring quality, security, and accessibility.'),(30,'Statistician','Provides statistical expertise for study design and data analysis.'),(31,'Lab Lead','Oversees laboratory activities related to the project.'),(32,'Field Coordinator','Manages field operations and community engagement.'),(33,'Administrator','Handles administrative and logistical support for the project.');
/*!40000 ALTER TABLE `kemri_project_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_project_staff_assignments`
--

DROP TABLE IF EXISTS `kemri_project_staff_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_project_staff_assignments` (
  `assignmentId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `staffId` int DEFAULT NULL,
  `roleId` int DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  PRIMARY KEY (`assignmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_project_staff_assignments`
--

LOCK TABLES `kemri_project_staff_assignments` WRITE;
/*!40000 ALTER TABLE `kemri_project_staff_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_project_staff_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_project_subcounties`
--

DROP TABLE IF EXISTS `kemri_project_subcounties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_project_subcounties` (
  `projectId` int NOT NULL,
  `subcountyId` int NOT NULL,
  `assignedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`projectId`,`subcountyId`),
  KEY `fk_project_subcounty_subcounty` (`subcountyId`),
  CONSTRAINT `fk_project_subcounty_project` FOREIGN KEY (`projectId`) REFERENCES `kemri_projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_project_subcounty_subcounty` FOREIGN KEY (`subcountyId`) REFERENCES `kemri_subcounties` (`subcountyId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_project_subcounties`
--

LOCK TABLES `kemri_project_subcounties` WRITE;
/*!40000 ALTER TABLE `kemri_project_subcounties` DISABLE KEYS */;
INSERT INTO `kemri_project_subcounties` VALUES (1,101,'2025-07-21 15:37:57'),(1,102,'2025-07-21 15:37:57'),(2,102,'2025-07-21 15:37:57'),(4,103,'2025-07-21 15:37:57'),(5,105,'2025-07-21 15:37:57');
/*!40000 ALTER TABLE `kemri_project_subcounties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_project_wards`
--

DROP TABLE IF EXISTS `kemri_project_wards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_project_wards` (
  `projectId` int NOT NULL,
  `wardId` int NOT NULL,
  `assignedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`projectId`,`wardId`),
  KEY `fk_project_ward_ward` (`wardId`),
  CONSTRAINT `fk_project_ward_project` FOREIGN KEY (`projectId`) REFERENCES `kemri_projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_project_ward_ward` FOREIGN KEY (`wardId`) REFERENCES `kemri_wards` (`wardId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_project_wards`
--

LOCK TABLES `kemri_project_wards` WRITE;
/*!40000 ALTER TABLE `kemri_project_wards` DISABLE KEYS */;
INSERT INTO `kemri_project_wards` VALUES (1,201,'2025-07-21 15:37:57'),(1,202,'2025-07-21 15:37:57'),(2,203,'2025-07-21 15:37:57'),(4,201,'2025-07-21 15:37:57');
/*!40000 ALTER TABLE `kemri_project_wards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projectattachments`
--

DROP TABLE IF EXISTS `kemri_projectattachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projectattachments` (
  `attachmentId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `statusId` int DEFAULT NULL,
  `observationId` int DEFAULT NULL,
  `typeId` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` text,
  `size` int DEFAULT NULL,
  `contentBlob` varchar(255) DEFAULT NULL,
  `description` text,
  `documentNo` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attachmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projectattachments`
--

LOCK TABLES `kemri_projectattachments` WRITE;
/*!40000 ALTER TABLE `kemri_projectattachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projectattachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projectcertificate`
--

DROP TABLE IF EXISTS `kemri_projectcertificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projectcertificate` (
  `certificateId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `statusId` int DEFAULT NULL,
  `requestDate` datetime DEFAULT NULL,
  `awardDate` datetime DEFAULT NULL,
  `progressStatus` varchar(255) DEFAULT NULL,
  `applicationStatus` varchar(255) DEFAULT NULL,
  `certType` varchar(255) DEFAULT NULL,
  `certSubType` varchar(255) DEFAULT NULL,
  `certNumber` varchar(255) DEFAULT NULL,
  `path` text,
  `approvedBy` varchar(255) DEFAULT NULL,
  `requesterRemarks` text,
  `approverRemarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`certificateId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projectcertificate`
--

LOCK TABLES `kemri_projectcertificate` WRITE;
/*!40000 ALTER TABLE `kemri_projectcertificate` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projectcertificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projectfeedback`
--

DROP TABLE IF EXISTS `kemri_projectfeedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projectfeedback` (
  `feedbackId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `feedbackMessage` int DEFAULT NULL,
  `response` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) DEFAULT NULL,
  `updatedBy` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `voidedAt` datetime DEFAULT NULL,
  `voidingReason` varchar(255) DEFAULT NULL,
  `submittedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`feedbackId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projectfeedback`
--

LOCK TABLES `kemri_projectfeedback` WRITE;
/*!40000 ALTER TABLE `kemri_projectfeedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projectfeedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projectmaps`
--

DROP TABLE IF EXISTS `kemri_projectmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projectmaps` (
  `mapId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `map` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`mapId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projectmaps`
--

LOCK TABLES `kemri_projectmaps` WRITE;
/*!40000 ALTER TABLE `kemri_projectmaps` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projectmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projectmonitoring`
--

DROP TABLE IF EXISTS `kemri_projectmonitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projectmonitoring` (
  `monitoringId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `statusId` int DEFAULT NULL,
  `inspectionDate` datetime DEFAULT NULL,
  `progressStatus` varchar(255) DEFAULT NULL,
  `objectivesHierarchy` text,
  `metric` varchar(255) DEFAULT NULL,
  `countyKpi` int DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  `actual` varchar(255) DEFAULT NULL,
  `deviation` varchar(255) DEFAULT NULL,
  `comment` text,
  `remarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`monitoringId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projectmonitoring`
--

LOCK TABLES `kemri_projectmonitoring` WRITE;
/*!40000 ALTER TABLE `kemri_projectmonitoring` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projectmonitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projectobservations`
--

DROP TABLE IF EXISTS `kemri_projectobservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projectobservations` (
  `observationId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `statusId` int DEFAULT NULL,
  `observationDate` datetime DEFAULT NULL,
  `progressStatus` varchar(255) DEFAULT NULL,
  `outputAchieved` text,
  `outputPercentage` int DEFAULT NULL,
  `delayReason` varchar(255) DEFAULT NULL,
  `findings` text,
  `challenges` text,
  `recommendations` text,
  `remarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  `createdBy` varchar(255) DEFAULT NULL,
  `updatedBy` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `voidedAt` datetime DEFAULT NULL,
  `voidingReason` varchar(255) DEFAULT NULL,
  `userType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`observationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projectobservations`
--

LOCK TABLES `kemri_projectobservations` WRITE;
/*!40000 ALTER TABLE `kemri_projectobservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projectobservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projectpayments`
--

DROP TABLE IF EXISTS `kemri_projectpayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projectpayments` (
  `paymentId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `contractorId` int DEFAULT NULL,
  `statusId` int DEFAULT NULL,
  `certificateId` int DEFAULT NULL,
  `recordedOn` datetime DEFAULT NULL,
  `paymentDate` datetime DEFAULT NULL,
  `progressStatus` varchar(255) DEFAULT NULL,
  `paymentType` varchar(255) DEFAULT NULL,
  `staging` varchar(255) DEFAULT NULL,
  `ifmisid` varchar(255) DEFAULT NULL,
  `transactionId` int DEFAULT NULL,
  `paymentNumber` varchar(255) DEFAULT NULL,
  `path` text,
  `approvedBy` varchar(255) DEFAULT NULL,
  `paymentRemarks` text,
  `amountPaid` decimal(15,2) DEFAULT NULL,
  `percPaid` decimal(15,2) DEFAULT NULL,
  `transactionDetails` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`paymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projectpayments`
--

LOCK TABLES `kemri_projectpayments` WRITE;
/*!40000 ALTER TABLE `kemri_projectpayments` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projectpayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projects`
--

DROP TABLE IF EXISTS `kemri_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectName` varchar(255) DEFAULT NULL,
  `directorate` varchar(255) DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `costOfProject` decimal(15,2) DEFAULT NULL,
  `paidOut` decimal(15,2) DEFAULT NULL,
  `objective` text,
  `expectedOutput` text,
  `principalInvestigator` text,
  `expectedOutcome` text,
  `status` varchar(255) DEFAULT NULL,
  `statusReason` text,
  `createdOn` datetime DEFAULT NULL,
  `principalInvestigatorStaffId` int DEFAULT NULL,
  `departmentId` int DEFAULT NULL,
  `sectionId` int DEFAULT NULL,
  `finYearId` int DEFAULT NULL,
  `programId` int DEFAULT NULL,
  `subProgramId` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projects`
--

LOCK TABLES `kemri_projects` WRITE;
/*!40000 ALTER TABLE `kemri_projects` DISABLE KEYS */;
INSERT INTO `kemri_projects` VALUES (1,'Impact of Climate Change on Vector-Borne Disease Prevalence in Arid and Semi-Arid Lands','Directorate of Research and Development','2024-12-31 00:00:00','2025-12-31 00:00:00',85000000.00,80000000.00,'To assess the correlation between changing climatic patterns (temperature, rainfall) and the incidence of diseases like Dengue and Chikungunya, and to develop early warning systems for outbreaks.','A comprehensive report on climate-disease correlation, validated predictive models for outbreaks, and policy recommendations for public health interventions.','Dr. Aisha Mohamed','Reduced burden of vector-borne diseases in vulnerable communities through proactive measures and informed policy.','At Risk','Final data analysis and report writing are the primary activities. Minor delays due to unexpected extreme weather events during final data validation affecting fieldwork in one sub-county.','2025-07-13 13:40:19',NULL,NULL,402,NULL,602,NULL),(2,'Role of Traditional Herbal Medicine in Diabetes Management: Efficacy and Safety','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',75000000.00,70000000.00,'To scientifically evaluate the efficacy and safety of commonly used traditional herbal remedies for diabetes in Kenya.','Pharmacological data on selected herbal extracts, clinical trial results on efficacy, and safety profiles.','Prof. Daniel Mutua','Evidence-based guidance on the use of traditional medicine for diabetes, potentially integrating safe and effective remedies into mainstream healthcare.','In Progress','Laboratory analysis of herbal compounds is ongoing. Clinical trial recruitment has been challenging, but efforts are underway to complete patient follow-up within the extended timeline.','2025-07-13 13:40:19',NULL,301,NULL,501,NULL,701),(3,'Efficacy of a Novel Antimalarial Drug Candidate in Pediatric Populations','Directorate of Research and Development','2023-07-03 00:00:00','2025-07-17 00:00:00',120000000.00,120000000.00,'To conduct a Phase II clinical trial for a new antimalarial compound, evaluating its safety and efficacy in children aged 6 months to 12 years.','Clinical trial results, peer-reviewed publications, and a recommendation for progression to Phase III trials.','Prof. James Omondi','Introduction of a new, effective, and safe treatment option for malaria in children.','Closed','All trial phases concluded, data analyzed, final report and publications submitted. Financial closeout completed in June 2025.','2025-07-13 13:40:19',NULL,NULL,401,NULL,601,NULL),(4,'Development of a Rapid Diagnostic Test for Early Detection of Visceral Leishmaniasis','Directorate of Research and Development','2025-01-01 00:00:00','2026-07-01 00:00:00',70000000.00,30000000.00,'To develop and validate a highly sensitive and specific rapid diagnostic test (RDT) for early detection of Visceral Leishmaniasis (Kala-azar).','A prototype RDT, validation study results, and intellectual property documentation.','Dr. Emily Chepkirui','Improved early diagnosis of Visceral Leishmaniasis, leading to better patient management and reduced morbidity/mortality.','In Progress','Laboratory development of the RDT prototype is ongoing. Initial patient sample collection has resumed after addressing logistical challenges in remote areas.','2025-07-13 13:40:19',NULL,301,402,501,602,701),(5,'Community-Based Interventions for Non-Communicable Disease Prevention in Urban Informal Settlements','Directorate of Research and Development','2024-07-17 00:00:00','2025-07-17 00:00:00',60000000.00,50000000.00,'To design, implement, and evaluate the effectiveness of community-led health promotion programs targeting hypertension and diabetes.','A toolkit for community health volunteers, quantitative and qualitative data on intervention impact, and policy briefs for urban health strategies.','Dr. Sarah Wanjiru','Improved health outcomes and reduced prevalence of NCDs in target communities, with scalable intervention models.','In Progress','Intervention implementation is in its final phase. Data collection from communities is ongoing, with some minor challenges in sustained participant engagement.','2025-07-13 13:40:19',NULL,NULL,NULL,NULL,NULL,NULL),(6,'Assessment of Maternal and Child Health Program Effectiveness in Remote Pastoralist Communities','Directorate of Research and Development','2024-10-31 00:00:00','2025-12-31 00:00:00',45000000.00,45000000.00,'To evaluate the reach, quality, and impact of existing maternal and child health interventions in nomadic communities.','A detailed report on program gaps and successes, recommendations for culturally appropriate interventions, and a policy brief.','Dr. David Kimani','Enhanced effectiveness of MCH programs, leading to improved maternal and child health indicators in pastoralist regions.','Completed','Fieldwork and data collection are fully complete. Final report submitted and awaiting publication. Project is in the administrative closeout phase.','2025-07-13 13:40:19',NULL,301,401,501,601,701),(7,'Investigation of Zoonotic Disease Spillover Risks at the Human-Wildlife Interface','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',110000000.00,35000000.00,'To identify and characterize novel zoonotic pathogens with pandemic potential and assess risk factors for spillover events.','Identification of high-risk pathogen-host combinations, a risk assessment framework, and baseline data for future surveillance.','Dr. Susan Chebet','Improved preparedness and early detection of emerging zoonotic threats, reducing the risk of epidemics.','In Progress','Active wildlife and human sample collection is underway. Initial laboratory analysis has commenced. Permit delays for accessing specific conservancies were resolved.','2025-07-13 13:40:19',NULL,NULL,402,NULL,602,NULL),(8,'Optimizing Cold Chain Management for Vaccine Delivery in Rural Areas','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',38000000.00,38000000.00,'To pilot and evaluate innovative cold chain technologies and logistics strategies for vaccine storage and distribution in hard-to-reach areas.','A feasibility report on new cold chain solutions, a cost-benefit analysis, and operational guidelines for implementation.','Mr. Peter Njoroge','Reduced vaccine wastage, improved vaccine accessibility, and enhanced immunization coverage in underserved regions.','Closed','All pilot phases concluded, data analyzed, and final report submitted to the Ministry of Health. Financial closeout completed in May 2025.','2025-07-13 13:40:19',NULL,301,NULL,501,NULL,701),(9,'Genomic Surveillance of Antimicrobial Resistance in Selected Bacterial Pathogens','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',95000000.00,94000000.00,'To establish a national genomic surveillance system for key antibiotic-resistant bacteria and track their evolution and spread.','A national database of bacterial genomics, identified resistance patterns, and annual surveillance reports.','Dr. Ken Baraka','Enhanced national capacity for AMR surveillance, informing antibiotic stewardship policies and infection control.','Completed','All genomic sequencing and bioinformatics analysis concluded. Final national surveillance report submitted. Awaiting administrative closure.','2025-07-13 13:40:19',NULL,NULL,401,NULL,601,NULL),(10,'Assessing the Mental Health Burden among Adolescents in Post-Conflict Regions','Directorate of Research and Development','2021-12-22 00:00:00','2025-12-24 00:00:00',50000000.00,35000000.00,'To determine the prevalence and risk factors for common mental health disorders among adolescents in areas affected by past inter-communal conflict.','Epidemiological data on adolescent mental health, identification of protective and risk factors, and recommendations for psychosocial support programs.','Dr. Faith Achieng','Improved understanding of adolescent mental health needs, leading to targeted and effective interventions.','Delayed','All data collection in schools concluded in June 2025. Data analysis and initial report drafting are in advanced stages. Project awaiting finalization and dissemination.','2025-07-13 13:40:19',NULL,301,402,501,602,701),(11,'Development of an AI-Powered Diagnostic Tool for Tuberculosis Detection from Chest X-rays','Directorate of Research and Development','2024-07-02 00:00:00','2025-12-01 00:00:00',90000000.00,40000000.00,'To develop and validate an artificial intelligence algorithm for automated and rapid detection of pulmonary tuberculosis from digital chest X-rays.','A validated AI model, a user-friendly software interface, and performance metrics compared to human readers.','Dr. John Mwangi','Accelerated and more accurate TB diagnosis, especially in resource-limited settings, leading to earlier treatment and reduced transmission.','In Progress','Large-scale data annotation is nearing completion. Initial AI model training and refinement are ongoing. Addressing challenges in dataset diversity.','2025-07-13 13:40:19',NULL,NULL,NULL,NULL,NULL,NULL),(12,'Nutritional Interventions for Stunting Reduction in Early Childhood','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',80000000.00,25000000.00,'To evaluate the impact of a multi-sectoral nutritional intervention package on stunting rates among children under five years old.','Longitudinal data on child growth, assessment of intervention effectiveness, and a cost-effectiveness analysis.','Dr. Grace Mwende','Reduced stunting prevalence, improved child development, and evidence-based strategies for national nutrition programs.','In Progress','Baseline data collection is complete. Community-level interventions have commenced, but participant retention requires close monitoring.','2025-07-13 13:40:19',NULL,301,401,501,601,701),(13,'Socio-Economic Impact of HIV Self-Testing Kits in Key Populations','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',40000000.00,39000000.00,'To assess the socio-economic facilitators and barriers to the uptake and utilization of HIV self-testing kits among sex workers and injecting drug users.','Qualitative and quantitative data on self-testing uptake, identified best practices, and policy recommendations for scale-up.','Dr. Ben Kiprono','Increased HIV testing rates and earlier diagnosis among key populations, contributing to HIV prevention efforts.','Completed','All data collection and analysis are complete. Final report submission is imminent. Preparing for stakeholder dissemination.','2025-07-13 13:40:19',NULL,NULL,402,NULL,602,NULL),(14,'Development of a Dengue Vaccine Candidate: Pre-Clinical Studies','Directorate of Research and Development','2023-07-01 00:00:00','2025-07-17 00:00:00',150000000.00,45000000.00,'To conduct pre-clinical studies (in vitro and in vivo animal models) to evaluate the immunogenicity and safety of a novel Dengue vaccine candidate.','Pre-clinical data package, patent applications, and a roadmap for Phase I human trials.','Prof. Alice Mwikali','A promising Dengue vaccine candidate ready for human clinical trials, addressing a significant public health burden.','In Progress','Initial reagent development and animal model setup are complete. First phase of immunogenicity studies is underway. Some delays due to international procurement of specialized reagents.','2025-07-13 13:40:19',NULL,301,NULL,501,NULL,701),(15,'Evaluation of Point-of-Care Diagnostics for Sexually Transmitted Infections in Primary Healthcare Settings','Directorate of Research and Development','1969-12-31 00:00:00','1969-12-31 00:00:00',68000000.00,68000000.00,'To assess the diagnostic accuracy, feasibility, and acceptability of novel point-of-care tests for common STIs in rural health centers.','Performance data for various RDTs, user-feedback reports, and recommendations for integration into national guidelines.','Dr. Florence Adhiambo','Improved and more accessible STI diagnosis and treatment, reducing transmission and associated complications.','Completed','All data collection and analysis finalized in April 2025. Final report submitted and awaiting publication. Project is in the administrative closeout phase.','2025-07-13 13:40:19',NULL,NULL,401,NULL,601,NULL),(16,'Health Systems Strengthening for Emergency Preparedness and Response in Border Regions','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',78000000.00,30000000.00,'To identify gaps and propose interventions to strengthen health system capacity for rapid response to disease outbreaks and other health emergencies in cross-border areas.','A comprehensive needs assessment report, training modules for health workers, and a regional emergency response plan.','Dr. Alex Kiprop','Enhanced resilience of border health systems to public health emergencies, protecting populations from transboundary health threats.','In Progress','Initial mapping of health facilities and stakeholder engagement are complete. Training modules are under development. Cross-border coordination remains a challenge requiring ongoing diplomatic efforts.','2025-07-13 13:40:19',NULL,301,402,501,602,701),(17,'Genetic Diversity of HIV-1 Subtypes and Drug Resistance Mutations in Treatment-Naive Patients','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',105000000.00,103000000.00,'To characterize the circulating HIV-1 subtypes and identify prevalent drug resistance mutations in individuals initiating antiretroviral therapy.','A comprehensive report on HIV genetic diversity, identified drug resistance patterns, and recommendations for first-line ART regimens.','Dr. Maureen Akinyi','Optimized HIV treatment strategies, reduced treatment failure rates, and improved long-term outcomes for people living with HIV.','Completed','All laboratory sequencing and bioinformatics analysis are fully complete. Final manuscript is under peer review. Awaiting administrative closeout.','2025-07-13 13:40:19',NULL,NULL,NULL,NULL,NULL,NULL),(18,'Impact of Indoor Air Pollution on Respiratory Health in Rural Households','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',52000000.00,22000000.00,'To quantify the levels of indoor air pollutants in rural households using traditional cooking fuels and assess their association with respiratory symptoms and diseases.','Data on household air pollution levels, correlation with respiratory health indicators, and recommendations for clean energy interventions.','Dr. Chemtai Bett','Reduced burden of respiratory diseases in rural communities through evidence-based interventions to mitigate indoor air pollution.','In Progress','Baseline data collection and sensor deployment are active. Community engagement for long-term monitoring is ongoing, with efforts to maintain participant compliance.','2025-07-13 13:40:19',NULL,301,401,501,601,701),(19,'Development of a National Health Research Prioritization Framework','Directorate of Research and Development','2023-07-14 00:00:00','2024-07-01 00:00:00',25000000.00,25000000.00,'To facilitate a consultative process to develop a comprehensive and consensus-driven national health research prioritization framework.','A validated national health research prioritization framework, a stakeholder engagement report, and policy recommendations for research funding.','Dr. Monica Wasike','More strategic and impactful health research investments, aligned with national health priorities and contributing to Universal Health Coverage.','Closed','All stakeholder workshops and technical committee meetings concluded, final framework validated and submitted to the Ministry of Health and relevant research bodies. Financial closure completed in late 2024.','2025-07-13 13:40:19',NULL,NULL,402,NULL,602,NULL),(20,'Understanding the Epidemiology of Buruli Ulcer in Western Kenya','Directorate of Research and Development','1970-01-01 00:00:00','1970-01-01 00:00:00',55000000.00,48000000.00,'To investigate the environmental, behavioral, and host factors contributing to the transmission and prevalence of Buruli Ulcer.','Identification of high-risk areas and populations, a comprehensive epidemiological profile, and recommendations for control strategies.','Dr. Carol Onyango','Improved understanding of Buruli Ulcer transmission, leading to more effective prevention and control measures.','In Progress','Field surveys and patient follow-up are mostly complete. Laboratory analysis of environmental samples and patient biopsies is ongoing and time-consuming.','2025-07-13 13:40:19',NULL,301,NULL,501,NULL,701);
/*!40000 ALTER TABLE `kemri_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projectscheduling`
--

DROP TABLE IF EXISTS `kemri_projectscheduling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projectscheduling` (
  `scheduleId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `statusId` int DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `remarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`scheduleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projectscheduling`
--

LOCK TABLES `kemri_projectscheduling` WRITE;
/*!40000 ALTER TABLE `kemri_projectscheduling` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projectscheduling` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projecttypes`
--

DROP TABLE IF EXISTS `kemri_projecttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projecttypes` (
  `typeId` int NOT NULL AUTO_INCREMENT,
  `typeName` varchar(255) DEFAULT NULL,
  `description` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projecttypes`
--

LOCK TABLES `kemri_projecttypes` WRITE;
/*!40000 ALTER TABLE `kemri_projecttypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projecttypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projectwarnings`
--

DROP TABLE IF EXISTS `kemri_projectwarnings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projectwarnings` (
  `warningId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `statusId` int DEFAULT NULL,
  `warningMessage` int DEFAULT NULL,
  `warningSent` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`warningId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projectwarnings`
--

LOCK TABLES `kemri_projectwarnings` WRITE;
/*!40000 ALTER TABLE `kemri_projectwarnings` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projectwarnings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_projproposalratings`
--

DROP TABLE IF EXISTS `kemri_projproposalratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_projproposalratings` (
  `proposalId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `rating` varchar(255) DEFAULT NULL,
  `remarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`proposalId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_projproposalratings`
--

LOCK TABLES `kemri_projproposalratings` WRITE;
/*!40000 ALTER TABLE `kemri_projproposalratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_projproposalratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_role_privileges`
--

DROP TABLE IF EXISTS `kemri_role_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_role_privileges` (
  `roleId` int NOT NULL,
  `privilegeId` int NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  PRIMARY KEY (`roleId`,`privilegeId`),
  KEY `fk_role_privilege_privilegeId` (`privilegeId`),
  CONSTRAINT `fk_role_privilege_privilegeId` FOREIGN KEY (`privilegeId`) REFERENCES `kemri_privileges` (`privilegeId`) ON DELETE CASCADE,
  CONSTRAINT `fk_role_privilege_roleId` FOREIGN KEY (`roleId`) REFERENCES `kemri_roles` (`roleId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_role_privileges`
--

LOCK TABLES `kemri_role_privileges` WRITE;
/*!40000 ALTER TABLE `kemri_role_privileges` DISABLE KEYS */;
INSERT INTO `kemri_role_privileges` VALUES (1,1,'2025-07-19 00:12:32'),(1,2,'2025-07-19 00:12:32'),(1,3,'2025-07-19 00:12:32'),(1,4,'2025-07-19 00:12:32'),(1,5,'2025-07-19 00:12:32'),(1,6,'2025-07-19 00:12:32'),(1,7,'2025-07-19 00:12:32'),(1,8,'2025-07-19 00:12:32'),(1,10,'2025-07-19 00:12:32'),(1,11,'2025-07-19 00:12:32'),(1,12,'2025-07-19 00:12:32'),(1,13,'2025-07-19 00:12:32'),(1,14,'2025-07-19 00:12:32'),(1,15,'2025-07-19 00:12:32'),(1,16,'2025-07-19 00:12:32'),(1,17,'2025-07-19 00:12:32'),(1,18,'2025-07-19 00:12:32'),(1,19,'2025-07-19 00:12:32'),(1,20,'2025-07-19 00:12:32'),(1,21,'2025-07-19 00:12:32'),(1,22,'2025-07-19 00:12:32'),(1,23,'2025-07-19 00:12:32'),(1,24,'2025-07-19 00:12:32'),(1,25,'2025-07-19 00:12:32'),(1,26,'2025-07-19 00:12:32'),(2,1,'2025-07-19 00:12:32'),(2,5,'2025-07-19 00:12:32'),(2,6,'2025-07-19 00:12:32'),(2,7,'2025-07-19 00:12:32'),(2,8,'2025-07-19 00:12:32'),(2,10,'2025-07-19 00:12:32'),(2,11,'2025-07-19 00:12:32'),(2,12,'2025-07-19 00:12:32'),(2,13,'2025-07-19 00:12:32'),(2,14,'2025-07-19 00:12:32'),(2,15,'2025-07-19 00:12:32'),(2,16,'2025-07-19 00:12:32'),(2,17,'2025-07-19 00:12:32'),(2,18,'2025-07-19 00:12:32'),(2,19,'2025-07-19 00:12:32'),(2,20,'2025-07-19 00:12:32'),(2,25,'2025-07-19 00:12:32'),(2,26,'2025-07-19 00:12:32'),(3,22,'2025-07-19 00:12:32'),(3,23,'2025-07-19 00:12:32'),(3,25,'2025-07-19 00:12:32'),(4,5,'2025-07-19 00:12:32'),(4,10,'2025-07-19 00:12:32'),(4,16,'2025-07-19 00:12:32'),(4,20,'2025-07-19 00:12:32'),(4,25,'2025-07-19 00:12:32'),(4,26,'2025-07-19 00:12:32'),(5,5,'2025-07-19 00:12:32'),(5,9,'2025-07-19 00:12:32'),(5,10,'2025-07-19 00:12:32'),(5,11,'2025-07-19 00:12:32'),(5,12,'2025-07-19 00:12:32'),(5,13,'2025-07-19 00:12:32'),(5,14,'2025-07-19 00:12:32'),(5,15,'2025-07-19 00:12:32'),(5,16,'2025-07-19 00:12:32'),(5,17,'2025-07-19 00:12:32'),(5,18,'2025-07-19 00:12:32'),(5,19,'2025-07-19 00:12:32'),(5,25,'2025-07-19 00:12:32'),(6,25,'2025-07-19 00:12:32');
/*!40000 ALTER TABLE `kemri_role_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_roles`
--

DROP TABLE IF EXISTS `kemri_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_roles` (
  `roleId` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) DEFAULT NULL,
  `description` text,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_roles`
--

LOCK TABLES `kemri_roles` WRITE;
/*!40000 ALTER TABLE `kemri_roles` DISABLE KEYS */;
INSERT INTO `kemri_roles` VALUES (1,'admin','Full administrative access to the system.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(2,'manager','Manages projects and oversees staff activities.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(3,'data_entry','Can enter and modify raw data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(4,'viewer','Can view dashboards and reports, but cannot modify data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(5,'project_lead','Leads specific projects, can manage tasks and milestones within their projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(6,'user','Standard user with basic access.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(7,'admin','Full administrative access to the system.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(8,'manager','Manages projects and oversees staff activities.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(9,'data_entry','Can enter and modify raw data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(10,'viewer','Can view dashboards and reports, but cannot modify data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(11,'project_lead','Leads specific projects, can manage tasks and milestones within their projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(12,'user','Standard user with basic access.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(14,'admin','Full administrative access to the system.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(15,'manager','Manages projects and oversees staff activities.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(16,'data_entry','Can enter and modify raw data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(17,'viewer','Can view dashboards and reports, but cannot modify data.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(18,'project_lead','Leads specific projects, can manage tasks and milestones within their projects.','2025-07-19 00:12:32','2025-07-19 00:12:32'),(19,'user','Standard user with basic access.','2025-07-19 00:12:32','2025-07-19 00:12:32');
/*!40000 ALTER TABLE `kemri_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_sectorstrategies`
--

DROP TABLE IF EXISTS `kemri_sectorstrategies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_sectorstrategies` (
  `strategyId` int NOT NULL AUTO_INCREMENT,
  `cidpid` varchar(255) DEFAULT NULL,
  `departmentId` int DEFAULT NULL,
  `sectionId` int DEFAULT NULL,
  `programme` text,
  `needsPriorities` text,
  `strategies` varchar(255) DEFAULT NULL,
  `remarks` text,
  `objectives` text,
  `outcomes` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`strategyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_sectorstrategies`
--

LOCK TABLES `kemri_sectorstrategies` WRITE;
/*!40000 ALTER TABLE `kemri_sectorstrategies` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_sectorstrategies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_sectorsubprogrammes`
--

DROP TABLE IF EXISTS `kemri_sectorsubprogrammes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_sectorsubprogrammes` (
  `subProgramId` int NOT NULL AUTO_INCREMENT,
  `strategyId` int DEFAULT NULL,
  `subProgramme` text,
  `keyOutcome` text,
  `kpi` text,
  `baseline` varchar(255) DEFAULT NULL,
  `yr1Targets` varchar(255) DEFAULT NULL,
  `yr2Targets` varchar(255) DEFAULT NULL,
  `yr3Targets` varchar(255) DEFAULT NULL,
  `yr4Targets` varchar(255) DEFAULT NULL,
  `yr5Targets` varchar(255) DEFAULT NULL,
  `yr1Budget` decimal(15,2) DEFAULT NULL,
  `yr2Budget` decimal(15,2) DEFAULT NULL,
  `yr3Budget` decimal(15,2) DEFAULT NULL,
  `yr4Budget` decimal(15,2) DEFAULT NULL,
  `yr5Budget` decimal(15,2) DEFAULT NULL,
  `totalBudget` decimal(15,2) DEFAULT NULL,
  `remarks` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`subProgramId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_sectorsubprogrammes`
--

LOCK TABLES `kemri_sectorsubprogrammes` WRITE;
/*!40000 ALTER TABLE `kemri_sectorsubprogrammes` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_sectorsubprogrammes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_sentsmsstatus`
--

DROP TABLE IF EXISTS `kemri_sentsmsstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_sentsmsstatus` (
  `statusId` int NOT NULL AUTO_INCREMENT,
  `smsId` int DEFAULT NULL,
  `recipient` varchar(255) DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `log` text,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`statusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_sentsmsstatus`
--

LOCK TABLES `kemri_sentsmsstatus` WRITE;
/*!40000 ALTER TABLE `kemri_sentsmsstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_sentsmsstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_staff`
--

DROP TABLE IF EXISTS `kemri_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_staff` (
  `staffId` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `email` text,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`staffId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_staff`
--

LOCK TABLES `kemri_staff` WRITE;
/*!40000 ALTER TABLE `kemri_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_strategyattachments`
--

DROP TABLE IF EXISTS `kemri_strategyattachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_strategyattachments` (
  `attachmentId` int NOT NULL AUTO_INCREMENT,
  `strategyId` int DEFAULT NULL,
  `typeId` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` text,
  `size` int DEFAULT NULL,
  `contentBlob` varchar(255) DEFAULT NULL,
  `description` text,
  `documentNo` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attachmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_strategyattachments`
--

LOCK TABLES `kemri_strategyattachments` WRITE;
/*!40000 ALTER TABLE `kemri_strategyattachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `kemri_strategyattachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_studyparticipants`
--

DROP TABLE IF EXISTS `kemri_studyparticipants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_studyparticipants` (
  `individualId` int NOT NULL AUTO_INCREMENT,
  `householdId` varchar(50) DEFAULT NULL,
  `gpsLatitudeIndividual` decimal(10,7) DEFAULT NULL,
  `gpsLongitudeIndividual` decimal(10,7) DEFAULT NULL,
  `county` varchar(100) DEFAULT NULL,
  `subCounty` varchar(100) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `educationLevel` varchar(255) DEFAULT NULL,
  `diseaseStatusMalaria` varchar(255) DEFAULT NULL,
  `diseaseStatusDengue` varchar(255) DEFAULT NULL,
  `mosquitoNetUse` varchar(255) DEFAULT NULL,
  `waterStoragePractices` varchar(100) DEFAULT NULL,
  `climatePerception` varchar(100) DEFAULT NULL,
  `recentRainfall` varchar(255) DEFAULT NULL,
  `averageTemperatureC` varchar(100) DEFAULT NULL,
  `householdSize` varchar(100) DEFAULT NULL,
  `accessToHealthcare` varchar(255) DEFAULT NULL,
  `projectId` int DEFAULT NULL,
  PRIMARY KEY (`individualId`)
) ENGINE=InnoDB AUTO_INCREMENT=897 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_studyparticipants`
--

LOCK TABLES `kemri_studyparticipants` WRITE;
/*!40000 ALTER TABLE `kemri_studyparticipants` DISABLE KEYS */;
INSERT INTO `kemri_studyparticipants` VALUES (1,'HH-1-2853',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',35,'Farmer','Primary','No','No','Yes','Covered containers','Moderate','120','24.50','5','Easy',1),(2,'HH-2-7297',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Male',8,'Student','Primary','No','No','Yes','Covered containers','Moderate','120','24.50','5','Easy',1),(3,'HH-3-7928',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',5,'None','None','No','No','Yes','Covered containers','Moderate','120','24.50','5','Easy',1),(4,'HH-4-7747',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Male',40,'Farmer','Secondary','No','No','Yes','Covered containers','Moderate','120','24.50','5','Easy',1),(5,'HH-5-4951',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',1,'None','None','No','No','Yes','Covered containers','Moderate','120','24.50','5','Easy',1),(6,'HH-6-1516',0.5147000,35.2698000,'Nandi','Nandi Hills','Male',52,'Businessman','Tertiary','No','No','No','No storage','Low','70','20.10','4','Moderate',1),(7,'HH-7-2727',0.5147000,35.2698000,'Nandi','Nandi Hills','Female',48,'Housewife','Primary','No','No','No','No storage','Low','70','20.10','4','Moderate',1),(8,'HH-8-9089',0.5147000,35.2698000,'Nandi','Nandi Hills','Female',20,'Student','Tertiary','No','No','No','No storage','Low','70','20.10','4','Moderate',1),(9,'HH-9-7265',0.5147000,35.2698000,'Nandi','Nandi Hills','Male',15,'Student','Secondary','No','No','No','No storage','Low','70','20.10','4','Moderate',1),(10,'HH-10-9059',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Female',28,'Office Worker','Tertiary','No','No','No','Covered containers','High','50','23.80','3','Easy',1),(11,'HH-11-3498',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',30,'Teacher','Tertiary','No','No','No','Covered containers','High','50','23.80','3','Easy',1),(12,'HH-12-0313',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',2,'None','None','No','No','No','Covered containers','High','50','23.80','3','Easy',1),(13,'HH-13-1074',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',60,'Pastoralist','None','Yes','No','Yes','Open containers','High','180','28.20','6','Difficult',1),(14,'HH-14-4432',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',55,'Housewife','None','Yes','No','Yes','Open containers','High','180','28.20','6','Difficult',1),(15,'HH-15-8936',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',25,'None','Primary','No','No','Yes','Open containers','High','180','28.20','6','Difficult',1),(16,'HH-16-1385',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',22,'Pastoralist','Primary','Yes','No','Yes','Open containers','High','180','28.20','6','Difficult',1),(17,'HH-17-0119',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',18,'None','Primary','No','No','Yes','Open containers','High','180','28.20','6','Difficult',1),(18,'HH-18-6442',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',10,'Student','Primary','No','No','Yes','Open containers','High','180','28.20','6','Difficult',1),(19,'HH-19-1851',-0.5000000,39.8000000,'Kilifi','Kilifi North','Female',45,'Fisher','Primary','No','Yes','Yes','Open containers','High','150','29.10','4','Moderate',1),(20,'HH-20-9931',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',47,'Fisher','Primary','No','Yes','Yes','Open containers','High','150','29.10','4','Moderate',1),(22,'HH-22-4101',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',12,'Student','Primary','No','No','Yes','Open containers','High','150','29.10','4','Moderate',1),(23,'HH-23-0713',0.2833000,34.7500000,'Bungoma','Bungoma Central','Male',65,'Retired','None','Yes','No','Yes','Covered containers','Moderate','100','22.00','2','Easy',1),(24,'HH-24-1263',0.2833000,34.7500000,'Bungoma','Bungoma Central','Female',62,'Housewife','None','No','No','Yes','Covered containers','Moderate','100','22.00','2','Easy',1),(25,'HH-25-4176',-0.7833000,35.0000000,'Narok','Narok North','Female',30,'Trader','Primary','No','No','No','No storage','Low','60','25.50','5','Difficult',1),(26,'HH-26-7094',-0.7833000,35.0000000,'Narok','Narok North','Male',32,'Trader','Primary','No','No','No','No storage','Low','60','25.50','5','Difficult',1),(27,'HH-27-2939',-0.7833000,35.0000000,'Narok','Narok North','Female',7,'Student','Primary','No','No','No','No storage','Low','60','25.50','5','Difficult',1),(28,'HH-28-3415',-0.7833000,35.0000000,'Narok','Narok North','Male',5,'None','None','No','No','No','No storage','Low','60','25.50','5','Difficult',1),(29,'HH-29-8259',-0.7833000,35.0000000,'Narok','Narok North','Female',1,'None','None','No','No','No','No storage','Low','60','25.50','5','Difficult',1),(30,'HH-30-1051',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',48,'Teacher','Tertiary','No','No','No','Covered containers','Moderate','80','21.00','4','Easy',1),(31,'HH-31-0478',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',45,'Farmer','Secondary','No','No','No','Covered containers','Moderate','80','21.00','4','Easy',1),(32,'HH-32-9239',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',18,'Student','Secondary','No','No','No','Covered containers','Moderate','80','21.00','4','Easy',1),(33,'HH-33-4761',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',10,'Student','Primary','No','No','No','Covered containers','Moderate','80','21.00','4','Easy',1),(34,'HH-34-6087',2.8000000,36.0000000,'Turkana','Turkana North','Male',70,'Pastoralist','None','Yes','No','No','Open containers','High','200','30.50','5','Difficult',1),(35,'HH-35-6152',2.8000000,36.0000000,'Turkana','Turkana North','Female',68,'Housewife','None','Yes','No','No','Open containers','High','200','30.50','5','Difficult',1),(36,'HH-36-2501',2.8000000,36.0000000,'Turkana','Turkana North','Male',35,'Pastoralist','None','Yes','No','No','Open containers','High','200','30.50','5','Difficult',1),(37,'HH-37-4050',2.8000000,36.0000000,'Turkana','Turkana North','Female',30,'Housewife','None','No','No','No','Open containers','High','200','30.50','5','Difficult',1),(38,'HH-38-2746',2.8000000,36.0000000,'Turkana','Turkana North','Male',8,'None','Primary','No','No','No','Open containers','High','200','30.50','5','Difficult',1),(39,'HH-39-1580',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',25,'Shopkeeper','Secondary','No','No','No','Covered containers','Moderate','40','26.00','3','Easy',1),(40,'HH-40-9663',-0.6000000,37.0000000,'Machakos','Machakos Town','Male',28,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','40','26.00','3','Easy',1),(41,'HH-41-3577',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',3,'None','None','No','No','No','Covered containers','Moderate','40','26.00','3','Easy',1),(42,'HH-42-8895',0.0000000,37.9000000,'Meru','Imenti South','Male',55,'Farmer','Primary','No','No','Yes','Open containers','Moderate','90','23.00','6','Moderate',1),(43,'HH-43-3745',0.0000000,37.9000000,'Meru','Imenti South','Female',50,'Housewife','Primary','No','No','Yes','Open containers','Moderate','90','23.00','6','Moderate',1),(44,'HH-44-2039',0.0000000,37.9000000,'Meru','Imenti South','Male',25,'Farmer','Secondary','No','No','Yes','Open containers','Moderate','90','23.00','6','Moderate',1),(45,'HH-45-8963',0.0000000,37.9000000,'Meru','Imenti South','Female',20,'Student','Secondary','No','No','Yes','Open containers','Moderate','90','23.00','6','Moderate',1),(46,'HH-46-8696',0.0000000,37.9000000,'Meru','Imenti South','Male',15,'Student','Primary','No','No','Yes','Open containers','Moderate','90','23.00','6','Moderate',1),(47,'HH-47-6592',0.0000000,37.9000000,'Meru','Imenti South','Female',8,'Student','Primary','No','No','Yes','Open containers','Moderate','90','23.00','6','Moderate',1),(48,'HH-48-6875',-2.1000000,40.0000000,'Lamu','Lamu West','Female',40,'Fisher','None','No','Yes','Yes','Open containers','High','160','28.80','5','Difficult',1),(49,'HH-49-4597',-2.1000000,40.0000000,'Lamu','Lamu West','Male',42,'Fisher','None','No','Yes','Yes','Open containers','High','160','28.80','5','Difficult',1),(50,'HH-50-2360',-2.1000000,40.0000000,'Lamu','Lamu West','Female',18,'Student','Primary','No','No','Yes','Open containers','High','160','28.80','5','Difficult',1),(51,'HH-51-8012',-2.1000000,40.0000000,'Lamu','Lamu West','Male',10,'Student','Primary','No','No','Yes','Open containers','High','160','28.80','5','Difficult',1),(52,'HH-52-2980',-2.1000000,40.0000000,'Lamu','Lamu West','Female',5,'None','None','No','No','Yes','Open containers','High','160','28.80','5','Difficult',1),(53,'HH-53-0862',-0.6900000,34.2500000,'Siaya','Bondo','Male',38,'Farmer','Secondary','Yes','No','Yes','Covered containers','Moderate','130','25.00','7','Moderate',1),(54,'HH-54-5374',-0.6900000,34.2500000,'Siaya','Bondo','Female',36,'Housewife','Primary','No','No','Yes','Covered containers','Moderate','130','25.00','7','Moderate',1),(55,'HH-55-4281',-0.6900000,34.2500000,'Siaya','Bondo','Male',15,'Student','Secondary','No','No','Yes','Covered containers','Moderate','130','25.00','7','Moderate',1),(56,'HH-56-5285',-0.6900000,34.2500000,'Siaya','Bondo','Female',12,'Student','Primary','Yes','No','Yes','Covered containers','Moderate','130','25.00','7','Moderate',1),(57,'HH-57-3584',-0.6900000,34.2500000,'Siaya','Bondo','Male',8,'Student','Primary','No','No','Yes','Covered containers','Moderate','130','25.00','7','Moderate',1),(58,'HH-58-2066',-0.6900000,34.2500000,'Siaya','Bondo','Female',5,'None','None','No','No','Yes','Covered containers','Moderate','130','25.00','7','Moderate',1),(59,'HH-59-9577',-0.6900000,34.2500000,'Siaya','Bondo','Male',2,'None','None','No','No','Yes','Covered containers','Moderate','130','25.00','7','Moderate',1),(60,'HH-60-1689',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',50,'Farmer','Primary','No','No','No','No storage','Low','65','19.50','3','Moderate',1),(61,'HH-61-9713',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Male',52,'Farmer','Primary','No','No','No','No storage','Low','65','19.50','3','Moderate',1),(62,'HH-62-3498',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',20,'Student','Tertiary','No','No','No','No storage','Low','65','19.50','3','Moderate',1),(63,'HH-63-8351',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',40,'Pastoralist','None','Yes','No','No','Open containers','High','170','27.00','6','Difficult',1),(64,'HH-64-1264',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',38,'Housewife','None','Yes','No','No','Open containers','High','170','27.00','6','Difficult',1),(65,'HH-65-1266',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',15,'Student','Primary','No','No','No','Open containers','High','170','27.00','6','Difficult',1),(66,'HH-66-2540',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',12,'None','None','No','No','No','Open containers','High','170','27.00','6','Difficult',1),(67,'HH-67-8901',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',8,'None','None','No','No','No','Open containers','High','170','27.00','6','Difficult',1),(68,'HH-68-6884',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',3,'None','None','No','No','No','Open containers','High','170','27.00','6','Difficult',1),(69,'HH-69-7719',-0.1000000,37.5000000,'Embu','Embu West','Female',33,'Trader','Secondary','No','No','No','Covered containers','Moderate','75','22.50','4','Easy',1),(70,'HH-70-7941',-0.1000000,37.5000000,'Embu','Embu West','Male',35,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','75','22.50','4','Easy',1),(71,'HH-71-6552',-0.1000000,37.5000000,'Embu','Embu West','Female',10,'Student','Primary','No','No','No','Covered containers','Moderate','75','22.50','4','Easy',1),(72,'HH-72-8938',-0.1000000,37.5000000,'Embu','Embu West','Male',5,'None','None','No','No','No','Covered containers','Moderate','75','22.50','4','Easy',1),(73,'HH-73-5031',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',45,'Farmer','Primary','No','No','Yes','Open containers','High','110','27.00','5','Moderate',1),(74,'HH-74-8344',-0.2000000,38.0000000,'Kitui','Kitui Central','Female',42,'Housewife','Primary','No','No','Yes','Open containers','High','110','27.00','5','Moderate',1),(75,'HH-75-6628',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',20,'Student','Secondary','No','No','Yes','Open containers','High','110','27.00','5','Moderate',1),(76,'HH-76-8108',-0.2000000,38.0000000,'Kitui','Kitui Central','Female',15,'Student','Primary','No','No','Yes','Open containers','High','110','27.00','5','Moderate',1),(77,'HH-77-0656',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',7,'None','None','No','No','Yes','Open containers','High','110','27.00','5','Moderate',1),(78,'HH-78-8956',0.7500000,34.5000000,'Kakamega','Butere','Female',58,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','140','24.00','4','Easy',1),(79,'HH-79-2814',0.7500000,34.5000000,'Kakamega','Butere','Male',60,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','140','24.00','4','Easy',1),(80,'HH-80-7203',0.7500000,34.5000000,'Kakamega','Butere','Female',25,'Teacher','Tertiary','No','No','Yes','Covered containers','Moderate','140','24.00','4','Easy',1),(81,'HH-81-7571',0.7500000,34.5000000,'Kakamega','Butere','Male',22,'Farmer','Secondary','No','No','Yes','Covered containers','Moderate','140','24.00','4','Easy',1),(82,'HH-82-6247',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Male',30,'Salesperson','Secondary','No','No','No','No storage','Low','55','21.50','3','Easy',1),(83,'HH-83-8524',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Female',28,'Hairdresser','Secondary','No','No','No','No storage','Low','55','21.50','3','Easy',1),(84,'HH-84-3881',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Female',4,'None','None','No','No','No','No storage','Low','55','21.50','3','Easy',1),(85,'HH-85-3831',1.5000000,37.5000000,'Marsabit','Moyale','Female',60,'Pastoralist','None','Yes','No','No','Open containers','High','190','31.00','7','Difficult',1),(86,'HH-86-7515',1.5000000,37.5000000,'Marsabit','Moyale','Male',62,'Pastoralist','None','Yes','No','No','Open containers','High','190','31.00','7','Difficult',1),(87,'HH-87-6081',1.5000000,37.5000000,'Marsabit','Moyale','Female',30,'Housewife','None','No','No','No','Open containers','High','190','31.00','7','Difficult',1),(88,'HH-88-7863',1.5000000,37.5000000,'Marsabit','Moyale','Male',28,'Pastoralist','None','Yes','No','No','Open containers','High','190','31.00','7','Difficult',1),(89,'HH-89-1070',1.5000000,37.5000000,'Marsabit','Moyale','Female',15,'None','Primary','No','No','No','Open containers','High','190','31.00','7','Difficult',1),(90,'HH-90-1760',1.5000000,37.5000000,'Marsabit','Moyale','Male',10,'None','None','No','No','No','Open containers','High','190','31.00','7','Difficult',1),(91,'HH-91-5593',1.5000000,37.5000000,'Marsabit','Moyale','Female',5,'None','None','No','No','No','Open containers','High','190','31.00','7','Difficult',1),(92,'HH-92-2685',-0.0500000,35.3000000,'Kericho','Kericho East','Male',40,'Farmer','Secondary','No','No','No','Covered containers','Moderate','95','20.80','5','Moderate',1),(93,'HH-93-6646',-0.0500000,35.3000000,'Kericho','Kericho East','Female',38,'Housewife','Primary','No','No','No','Covered containers','Moderate','95','20.80','5','Moderate',1),(94,'HH-94-5175',-0.0500000,35.3000000,'Kericho','Kericho East','Male',15,'Student','Secondary','No','No','No','Covered containers','Moderate','95','20.80','5','Moderate',1),(95,'HH-95-5938',-0.0500000,35.3000000,'Kericho','Kericho East','Female',10,'Student','Primary','No','No','No','Covered containers','Moderate','95','20.80','5','Moderate',1),(96,'HH-96-4165',-0.0500000,35.3000000,'Kericho','Kericho East','Male',5,'None','None','No','No','No','Covered containers','Moderate','95','20.80','5','Moderate',1),(97,'HH-97-3011',0.6000000,39.0000000,'Garissa','Fafi','Female',50,'Trader','None','Yes','No','No','Open containers','High','210','32.00','6','Difficult',1),(98,'HH-98-2563',0.6000000,39.0000000,'Garissa','Fafi','Male',55,'Trader','None','Yes','No','No','Open containers','High','210','32.00','6','Difficult',1),(99,'HH-99-3780',0.6000000,39.0000000,'Garissa','Fafi','Female',25,'None','Primary','No','No','No','Open containers','High','210','32.00','6','Difficult',1),(100,'HH-100-1212',0.6000000,39.0000000,'Garissa','Fafi','Male',20,'None','Primary','Yes','No','No','Open containers','High','210','32.00','6','Difficult',1),(101,'HH-101-4720',0.6000000,39.0000000,'Garissa','Fafi','Female',10,'None','None','No','No','No','Open containers','High','210','32.00','6','Difficult',1),(102,'HH-102-9967',0.6000000,39.0000000,'Garissa','Fafi','Male',5,'None','None','No','No','No','Open containers','High','210','32.00','6','Difficult',1),(103,'HH-103-5673',-1.0000000,36.5000000,'Kiambu','Limuru','Male',35,'Driver','Secondary','No','No','No','Covered containers','Low','60','20.00','4','Easy',1),(104,'HH-104-8465',-1.0000000,36.5000000,'Kiambu','Limuru','Female',32,'Hairdresser','Secondary','No','No','No','Covered containers','Low','60','20.00','4','Easy',1),(105,'HH-105-5305',-1.0000000,36.5000000,'Kiambu','Limuru','Male',8,'Student','Primary','No','No','No','Covered containers','Low','60','20.00','4','Easy',1),(106,'HH-106-1132',-1.0000000,36.5000000,'Kiambu','Limuru','Female',3,'None','None','No','No','No','Covered containers','Low','60','20.00','4','Easy',1),(107,'HH-107-9747',0.0000000,34.0000000,'Busia','Samia','Female',48,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','135','25.30','6','Moderate',1),(108,'HH-108-5337',0.0000000,34.0000000,'Busia','Samia','Male',50,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','135','25.30','6','Moderate',1),(109,'HH-109-7447',0.0000000,34.0000000,'Busia','Samia','Female',20,'Student','Secondary','No','No','Yes','Covered containers','Moderate','135','25.30','6','Moderate',1),(110,'HH-110-1224',0.0000000,34.0000000,'Busia','Samia','Male',18,'Farmer','Secondary','Yes','No','Yes','Covered containers','Moderate','135','25.30','6','Moderate',1),(111,'HH-111-3778',0.0000000,34.0000000,'Busia','Samia','Female',10,'Student','Primary','No','No','Yes','Covered containers','Moderate','135','25.30','6','Moderate',1),(112,'HH-112-5217',0.0000000,34.0000000,'Busia','Samia','Male',5,'None','None','No','No','Yes','Covered containers','Moderate','135','25.30','6','Moderate',1),(113,'HH-113-4754',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',65,'Pastoralist','None','Yes','No','No','Open containers','High','185','29.00','5','Difficult',1),(114,'HH-114-8121',1.0000000,35.0000000,'West Pokot','Pokot Central','Female',63,'Housewife','None','Yes','No','No','Open containers','High','185','29.00','5','Difficult',1),(115,'HH-115-6341',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',30,'Pastoralist','None','No','No','No','Open containers','High','185','29.00','5','Difficult',1),(116,'HH-116-7343',1.0000000,35.0000000,'West Pokot','Pokot Central','Female',28,'Housewife','None','No','No','No','Open containers','High','185','29.00','5','Difficult',1),(117,'HH-117-7693',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',10,'None','None','No','No','No','Open containers','High','185','29.00','5','Difficult',1),(118,'HH-118-6438',-0.5000000,37.0000000,'Makueni','Makueni','Female',38,'Farmer','Primary','No','No','Yes','Covered containers','Moderate','85','26.50','5','Moderate',1),(119,'HH-119-9110',-0.5000000,37.0000000,'Makueni','Makueni','Male',40,'Farmer','Primary','No','No','Yes','Covered containers','Moderate','85','26.50','5','Moderate',1),(120,'HH-120-6237',-0.5000000,37.0000000,'Makueni','Makueni','Female',15,'Student','Secondary','No','No','Yes','Covered containers','Moderate','85','26.50','5','Moderate',1),(121,'HH-121-3855',-0.5000000,37.0000000,'Makueni','Makueni','Male',12,'Student','Primary','No','No','Yes','Covered containers','Moderate','85','26.50','5','Moderate',1),(122,'HH-122-0566',-0.5000000,37.0000000,'Makueni','Makueni','Female',5,'None','None','No','No','Yes','Covered containers','Moderate','85','26.50','5','Moderate',1),(123,'HH-123-1265',-1.5000000,38.0000000,'Tana River','Galole','Male',55,'Fisher','None','Yes','No','Yes','Open containers','High','170','29.50','6','Difficult',1),(124,'HH-124-4627',-1.5000000,38.0000000,'Tana River','Galole','Female',52,'Housewife','None','Yes','No','Yes','Open containers','High','170','29.50','6','Difficult',1),(125,'HH-125-9340',-1.5000000,38.0000000,'Tana River','Galole','Male',28,'Fisher','Primary','No','No','Yes','Open containers','High','170','29.50','6','Difficult',1),(126,'HH-126-2821',-1.5000000,38.0000000,'Tana River','Galole','Female',25,'None','Primary','No','No','Yes','Open containers','High','170','29.50','6','Difficult',1),(127,'HH-127-6085',-1.5000000,38.0000000,'Tana River','Galole','Male',10,'Student','None','No','No','Yes','Open containers','High','170','29.50','6','Difficult',1),(128,'HH-128-1964',-1.5000000,38.0000000,'Tana River','Galole','Female',5,'None','None','No','No','Yes','Open containers','High','170','29.50','6','Difficult',1),(129,'HH-129-1563',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Female',30,'Trader','Secondary','Yes','No','Yes','Covered containers','Moderate','125','25.80','4','Easy',1),(130,'HH-130-1923',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Male',32,'Fisher','Secondary','Yes','No','Yes','Covered containers','Moderate','125','25.80','4','Easy',1),(131,'HH-131-4927',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Female',8,'Student','Primary','No','No','Yes','Covered containers','Moderate','125','25.80','4','Easy',1),(132,'HH-132-8869',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Male',3,'None','None','No','No','Yes','Covered containers','Moderate','125','25.80','4','Easy',1),(133,'HH-133-9561',0.5000000,36.0000000,'Baringo','Mogotio','Male',45,'Pastoralist','None','Yes','No','No','Open containers','High','195','28.00','5','Difficult',1),(134,'HH-134-1201',0.5000000,36.0000000,'Baringo','Mogotio','Female',42,'Housewife','None','Yes','No','No','Open containers','High','195','28.00','5','Difficult',1),(135,'HH-135-7323',0.5000000,36.0000000,'Baringo','Mogotio','Male',20,'Pastoralist','Primary','No','No','No','Open containers','High','195','28.00','5','Difficult',1),(136,'HH-136-3013',0.5000000,36.0000000,'Baringo','Mogotio','Female',15,'None','None','No','No','No','Open containers','High','195','28.00','5','Difficult',1),(137,'HH-137-3097',0.5000000,36.0000000,'Baringo','Mogotio','Male',7,'None','None','No','No','No','Open containers','High','195','28.00','5','Difficult',1),(138,'HH-138-6446',-0.4500000,36.2000000,'Nyandarua','Kinangop','Female',55,'Farmer','Primary','No','No','No','Covered containers','Low','70','18.50','3','Moderate',1),(139,'HH-139-2937',-0.4500000,36.2000000,'Nyandarua','Kinangop','Male',58,'Farmer','Primary','No','No','No','Covered containers','Low','70','18.50','3','Moderate',1),(140,'HH-140-5349',-0.4500000,36.2000000,'Nyandarua','Kinangop','Female',25,'Teacher','Tertiary','No','No','No','Covered containers','Low','70','18.50','3','Moderate',1),(141,'HH-141-7935',-1.2000000,37.8000000,'Kwale','Kinango','Male',40,'Farmer','Primary','Yes','No','Yes','Open containers','High','155','29.00','5','Difficult',1),(142,'HH-142-3629',-1.2000000,37.8000000,'Kwale','Kinango','Female',38,'Housewife','Primary','No','No','Yes','Open containers','High','155','29.00','5','Difficult',1),(143,'HH-143-4341',-1.2000000,37.8000000,'Kwale','Kinango','Male',15,'Student','Secondary','No','No','Yes','Open containers','High','155','29.00','5','Difficult',1),(144,'HH-144-0817',-1.2000000,37.8000000,'Kwale','Kinango','Female',12,'Student','Primary','No','No','Yes','Open containers','High','155','29.00','5','Difficult',1),(145,'HH-145-1061',-1.2000000,37.8000000,'Kwale','Kinango','Male',5,'None','None','No','No','Yes','Open containers','High','155','29.00','5','Difficult',1),(146,'HH-146-2857',0.5500000,34.7000000,'Vihiga','Sabatia','Female',30,'Businesswoman','Secondary','No','No','Yes','Covered containers','Moderate','115','23.50','4','Easy',1),(147,'HH-147-1102',0.5500000,34.7000000,'Vihiga','Sabatia','Male',32,'Carpenter','Secondary','No','No','Yes','Covered containers','Moderate','115','23.50','4','Easy',1),(148,'HH-148-6941',0.5500000,34.7000000,'Vihiga','Sabatia','Female',8,'Student','Primary','No','No','Yes','Covered containers','Moderate','115','23.50','4','Easy',1),(149,'HH-149-1400',0.5500000,34.7000000,'Vihiga','Sabatia','Male',3,'None','None','No','No','Yes','Covered containers','Moderate','115','23.50','4','Easy',1),(150,'HH-150-6177',-0.7000000,37.5000000,'Kwale','Msambweni','Male',45,'Fisher','Primary','No','Yes','Yes','Open containers','High','160','29.20','5','Difficult',1),(151,'HH-151-6686',-0.7000000,37.5000000,'Kwale','Msambweni','Female',43,'Trader','Primary','No','Yes','Yes','Open containers','High','160','29.20','5','Difficult',1),(152,'HH-152-4897',-0.7000000,37.5000000,'Kwale','Msambweni','Male',20,'Student','Secondary','No','No','Yes','Open containers','High','160','29.20','5','Difficult',1),(153,'HH-153-4428',-0.7000000,37.5000000,'Kwale','Msambweni','Female',15,'Student','Primary','No','No','Yes','Open containers','High','160','29.20','5','Difficult',1),(154,'HH-154-7448',-0.7000000,37.5000000,'Kwale','Msambweni','Male',7,'None','None','No','No','Yes','Open containers','High','160','29.20','5','Difficult',1),(155,'HH-155-3960',-0.0800000,34.9000000,'Nyamira','Nyamira North','Female',50,'Farmer','Primary','No','No','No','Covered containers','Low','80','21.00','4','Moderate',1),(156,'HH-156-7455',-0.0800000,34.9000000,'Nyamira','Nyamira North','Male',52,'Farmer','Primary','No','No','No','Covered containers','Low','80','21.00','4','Moderate',1),(157,'HH-157-5394',-0.0800000,34.9000000,'Nyamira','Nyamira North','Female',25,'Teacher','Tertiary','No','No','No','Covered containers','Low','80','21.00','4','Moderate',1),(158,'HH-158-4605',-0.0800000,34.9000000,'Nyamira','Nyamira North','Male',20,'Student','Secondary','No','No','No','Covered containers','Low','80','21.00','4','Moderate',1),(159,'HH-159-6847',-1.6000000,37.0000000,'Taita Taveta','Voi','Male',60,'Retired','Primary','No','No','No','No storage','Low','50','28.50','2','Easy',1),(160,'HH-160-0417',-1.6000000,37.0000000,'Taita Taveta','Voi','Female',58,'Housewife','Primary','No','No','No','No storage','Low','50','28.50','2','Easy',1),(161,'HH-161-1547',0.5000000,38.0000000,'Wajir','Wajir East','Female',40,'Pastoralist','None','Yes','No','No','Open containers','High','200','33.00','6','Difficult',1),(162,'HH-162-6484',0.5000000,38.0000000,'Wajir','Wajir East','Male',42,'Pastoralist','None','Yes','No','No','Open containers','High','200','33.00','6','Difficult',1),(163,'HH-163-7778',0.5000000,38.0000000,'Wajir','Wajir East','Female',18,'None','None','No','No','No','Open containers','High','200','33.00','6','Difficult',1),(164,'HH-164-9438',0.5000000,38.0000000,'Wajir','Wajir East','Male',15,'None','None','No','No','No','Open containers','High','200','33.00','6','Difficult',1),(165,'HH-165-3857',0.5000000,38.0000000,'Wajir','Wajir East','Female',8,'None','None','No','No','No','Open containers','High','200','33.00','6','Difficult',1),(166,'HH-166-0973',0.5000000,38.0000000,'Wajir','Wajir East','Male',3,'None','None','No','No','No','Open containers','High','200','33.00','6','Difficult',1),(167,'HH-167-3295',-0.2000000,35.5000000,'Nyamira','Manga','Male',35,'Farmer','Secondary','No','No','No','Covered containers','Moderate','105','22.00','5','Moderate',1),(168,'HH-168-3557',-0.2000000,35.5000000,'Nyamira','Manga','Female',33,'Housewife','Primary','No','No','No','Covered containers','Moderate','105','22.00','5','Moderate',1),(169,'HH-169-7898',-0.2000000,35.5000000,'Nyamira','Manga','Male',10,'Student','Primary','No','No','No','Covered containers','Moderate','105','22.00','5','Moderate',1),(170,'HH-170-8822',-0.2000000,35.5000000,'Nyamira','Manga','Female',7,'None','None','No','No','No','Covered containers','Moderate','105','22.00','5','Moderate',1),(171,'HH-171-0413',-0.2000000,35.5000000,'Nyamira','Manga','Male',2,'None','None','No','No','No','Covered containers','Moderate','105','22.00','5','Moderate',1),(172,'HH-172-5603',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',48,'Farmer','Primary','No','No','No','No storage','Low','60','20.50','4','Moderate',1),(173,'HH-173-6776',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',50,'Farmer','Primary','No','No','No','No storage','Low','60','20.50','4','Moderate',1),(174,'HH-174-7073',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',20,'Student','Tertiary','No','No','No','No storage','Low','60','20.50','4','Moderate',1),(175,'HH-175-5036',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',18,'Student','Secondary','No','No','No','No storage','Low','60','20.50','4','Moderate',1),(176,'HH-176-3963',0.0000000,34.5000000,'Kakamega','Lurambi','Male',40,'Teacher','Tertiary','No','No','Yes','Covered containers','Moderate','110','23.00','5','Easy',1),(177,'HH-177-4707',0.0000000,34.5000000,'Kakamega','Lurambi','Female',38,'Housewife','Secondary','No','No','Yes','Covered containers','Moderate','110','23.00','5','Easy',1),(178,'HH-178-1648',0.0000000,34.5000000,'Kakamega','Lurambi','Male',15,'Student','Secondary','No','No','Yes','Covered containers','Moderate','110','23.00','5','Easy',1),(179,'HH-179-4117',0.0000000,34.5000000,'Kakamega','Lurambi','Female',12,'Student','Primary','No','No','Yes','Covered containers','Moderate','110','23.00','5','Easy',1),(180,'HH-180-5642',0.0000000,34.5000000,'Kakamega','Lurambi','Male',5,'None','None','No','No','Yes','Covered containers','Moderate','110','23.00','5','Easy',1),(181,'HH-181-5858',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',55,'Farmer','Primary','No','No','No','Open containers','High','90','27.50','6','Difficult',1),(182,'HH-182-2365',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',58,'Farmer','Primary','No','No','No','Open containers','High','90','27.50','6','Difficult',1),(183,'HH-183-4251',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',25,'Trader','Secondary','No','No','No','Open containers','High','90','27.50','6','Difficult',1),(184,'HH-184-4160',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',22,'Farmer','Secondary','No','No','No','Open containers','High','90','27.50','6','Difficult',1),(185,'HH-185-8050',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',10,'Student','Primary','No','No','No','Open containers','High','90','27.50','6','Difficult',1),(186,'HH-186-7769',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',5,'None','None','No','No','No','Open containers','High','90','27.50','6','Difficult',1),(187,'HH-187-4695',0.2500000,37.0000000,'Nyeri','Nyeri Central','Male',40,'Civil Servant','Tertiary','No','No','No','Covered containers','Low','70','19.00','4','Easy',1),(188,'HH-188-0168',0.2500000,37.0000000,'Nyeri','Nyeri Central','Female',38,'Teacher','Tertiary','No','No','No','Covered containers','Low','70','19.00','4','Easy',1),(189,'HH-189-6755',0.2500000,37.0000000,'Nyeri','Nyeri Central','Male',12,'Student','Primary','No','No','No','Covered containers','Low','70','19.00','4','Easy',1),(190,'HH-190-3270',0.2500000,37.0000000,'Nyeri','Nyeri Central','Female',8,'Student','Primary','No','No','No','Covered containers','Low','70','19.00','4','Easy',1),(191,'HH-191-6088',0.1000000,34.2000000,'Bungoma','Kimilili','Female',50,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','120','23.00','5','Moderate',1),(192,'HH-192-0631',0.1000000,34.2000000,'Bungoma','Kimilili','Male',52,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','120','23.00','5','Moderate',1),(193,'HH-193-4892',0.1000000,34.2000000,'Bungoma','Kimilili','Female',20,'Student','Secondary','No','No','Yes','Covered containers','Moderate','120','23.00','5','Moderate',1),(194,'HH-194-2565',0.1000000,34.2000000,'Bungoma','Kimilili','Male',18,'Farmer','Secondary','No','No','Yes','Covered containers','Moderate','120','23.00','5','Moderate',1),(195,'HH-195-8149',0.1000000,34.2000000,'Bungoma','Kimilili','Female',10,'Student','Primary','No','No','Yes','Covered containers','Moderate','120','23.00','5','Moderate',1),(196,'HH-196-3052',0.0000000,37.0000000,'Kirinyaga','Mwea','Male',35,'Rice Farmer','Secondary','No','No','No','Covered containers','Moderate','80','24.00','4','Easy',1),(197,'HH-197-0812',0.0000000,37.0000000,'Kirinyaga','Mwea','Female',33,'Housewife','Primary','No','No','No','Covered containers','Moderate','80','24.00','4','Easy',1),(198,'HH-198-4905',0.0000000,37.0000000,'Kirinyaga','Mwea','Male',10,'Student','Primary','No','No','No','Covered containers','Moderate','80','24.00','4','Easy',1),(199,'HH-199-2089',0.0000000,37.0000000,'Kirinyaga','Mwea','Female',5,'None','None','No','No','No','Covered containers','Moderate','80','24.00','4','Easy',1),(200,'HH-200-5730',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',45,'Farmer','Primary','No','No','No','No storage','Low','75','20.00','5','Moderate',1),(201,'HH-201-2384',0.7000000,35.0000000,'Trans Nzoia','Kitale','Male',47,'Farmer','Primary','No','No','No','No storage','Low','75','20.00','5','Moderate',1),(202,'HH-202-4729',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',20,'Student','Secondary','No','No','No','No storage','Low','75','20.00','5','Moderate',1),(203,'HH-203-6493',0.7000000,35.0000000,'Trans Nzoia','Kitale','Male',18,'Farmer','Secondary','No','No','No','No storage','Low','75','20.00','5','Moderate',1),(204,'HH-204-8282',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',10,'Student','Primary','No','No','No','No storage','Low','75','20.00','5','Moderate',1),(205,'HH-205-1928',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',28,'Office Worker','Tertiary','No','No','No','Covered containers','Moderate','115','24.20','3','Easy',1),(206,'HH-206-4796',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Male',30,'Teacher','Tertiary','No','No','No','Covered containers','Moderate','115','24.20','3','Easy',1),(207,'HH-207-8196',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',2,'None','None','No','No','No','Covered containers','Moderate','115','24.20','3','Easy',1),(208,'HH-208-6591',0.5147000,35.2698000,'Nandi','Nandi Hills','Male',60,'Retired','Primary','No','No','No','No storage','Low','65','19.80','2','Moderate',1),(209,'HH-209-8367',0.5147000,35.2698000,'Nandi','Nandi Hills','Female',58,'Housewife','Primary','No','No','No','No storage','Low','65','19.80','2','Moderate',1),(210,'HH-210-2065',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Female',35,'Entrepreneur','Secondary','No','No','No','Covered containers','High','45','23.50','4','Easy',1),(211,'HH-211-5222',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',38,'IT Professional','Tertiary','No','No','No','Covered containers','High','45','23.50','4','Easy',1),(212,'HH-212-9915',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Female',10,'Student','Primary','No','No','No','Covered containers','High','45','23.50','4','Easy',1),(213,'HH-213-3909',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',5,'None','None','No','No','No','Covered containers','High','45','23.50','4','Easy',1),(214,'HH-214-9801',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',70,'Pastoralist','None','Yes','No','Yes','Open containers','High','170','28.00','5','Difficult',1),(215,'HH-215-7278',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',68,'Housewife','None','Yes','No','Yes','Open containers','High','170','28.00','5','Difficult',1),(216,'HH-216-6989',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',30,'Pastoralist','Primary','No','No','Yes','Open containers','High','170','28.00','5','Difficult',1),(217,'HH-217-3112',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',25,'None','Primary','No','No','Yes','Open containers','High','170','28.00','5','Difficult',1),(218,'HH-218-4591',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',8,'None','None','No','No','Yes','Open containers','High','170','28.00','5','Difficult',1),(219,'HH-219-3621',-0.5000000,39.8000000,'Kilifi','Kilifi North','Female',50,'Fisher','Primary','No','Yes','Yes','Open containers','High','140','28.90','4','Moderate',1),(220,'HH-220-4330',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',52,'Fisher','Primary','No','Yes','Yes','Open containers','High','140','28.90','4','Moderate',1),(221,'HH-221-0790',-0.5000000,39.8000000,'Kilifi','Kilifi North','Female',20,'Student','Secondary','No','No','Yes','Open containers','High','140','28.90','4','Moderate',1),(222,'HH-222-0959',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',15,'Student','Primary','No','No','Yes','Open containers','High','140','28.90','4','Moderate',1),(223,'HH-223-2428',0.2833000,34.7500000,'Bungoma','Bungoma Central','Male',70,'Retired','Primary','No','No','Yes','Covered containers','Moderate','95','21.80','2','Easy',1),(224,'HH-224-9263',0.2833000,34.7500000,'Bungoma','Bungoma Central','Female',68,'Housewife','Primary','No','No','Yes','Covered containers','Moderate','95','21.80','2','Easy',1),(225,'HH-225-9030',-0.7833000,35.0000000,'Narok','Narok North','Female',35,'Trader','Primary','No','No','No','No storage','Low','55','25.30','5','Difficult',1),(226,'HH-226-7364',-0.7833000,35.0000000,'Narok','Narok North','Male',38,'Trader','Primary','No','No','No','No storage','Low','55','25.30','5','Difficult',1),(227,'HH-227-9729',-0.7833000,35.0000000,'Narok','Narok North','Female',10,'Student','Primary','No','No','No','No storage','Low','55','25.30','5','Difficult',1),(228,'HH-228-6552',-0.7833000,35.0000000,'Narok','Narok North','Male',7,'None','None','No','No','No','No storage','Low','55','25.30','5','Difficult',1),(229,'HH-229-3573',-0.7833000,35.0000000,'Narok','Narok North','Female',2,'None','None','No','No','No','No storage','Low','55','25.30','5','Difficult',1),(230,'HH-230-8209',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',55,'Farmer','Secondary','No','No','No','Covered containers','Moderate','75','20.80','4','Easy',1),(231,'HH-231-0327',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',52,'Housewife','Primary','No','No','No','Covered containers','Moderate','75','20.80','4','Easy',1),(232,'HH-232-7008',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',20,'Student','Tertiary','No','No','No','Covered containers','Moderate','75','20.80','4','Easy',1),(233,'HH-233-4060',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',15,'Student','Secondary','No','No','No','Covered containers','Moderate','75','20.80','4','Easy',1),(234,'HH-234-9277',2.8000000,36.0000000,'Turkana','Turkana North','Male',75,'Pastoralist','None','Yes','No','No','Open containers','High','190','30.20','6','Difficult',1),(235,'HH-235-4204',2.8000000,36.0000000,'Turkana','Turkana North','Female',72,'Housewife','None','Yes','No','No','Open containers','High','190','30.20','6','Difficult',1),(236,'HH-236-3190',2.8000000,36.0000000,'Turkana','Turkana North','Male',40,'Pastoralist','None','Yes','No','No','Open containers','High','190','30.20','6','Difficult',1),(237,'HH-237-3338',2.8000000,36.0000000,'Turkana','Turkana North','Female',38,'Housewife','None','No','No','No','Open containers','High','190','30.20','6','Difficult',1),(238,'HH-238-7121',2.8000000,36.0000000,'Turkana','Turkana North','Male',12,'Student','Primary','No','No','No','Open containers','High','190','30.20','6','Difficult',1),(239,'HH-239-5592',2.8000000,36.0000000,'Turkana','Turkana North','Female',7,'None','None','No','No','No','Open containers','High','190','30.20','6','Difficult',1),(240,'HH-240-6599',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',30,'Shopkeeper','Secondary','No','No','No','Covered containers','Moderate','35','25.80','3','Easy',1),(241,'HH-241-6219',-0.6000000,37.0000000,'Machakos','Machakos Town','Male',33,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','35','25.80','3','Easy',1),(242,'HH-242-1299',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',5,'None','None','No','No','No','Covered containers','Moderate','35','25.80','3','Easy',1),(243,'HH-243-7840',0.0000000,37.9000000,'Meru','Imenti South','Male',60,'Farmer','Primary','No','No','Yes','Open containers','Moderate','85','22.80','6','Moderate',1),(244,'HH-244-5300',0.0000000,37.9000000,'Meru','Imenti South','Female',55,'Housewife','Primary','No','No','Yes','Open containers','Moderate','85','22.80','6','Moderate',1),(245,'HH-245-2981',0.0000000,37.9000000,'Meru','Imenti South','Male',30,'Farmer','Secondary','No','No','Yes','Open containers','Moderate','85','22.80','6','Moderate',1),(246,'HH-246-9007',0.0000000,37.9000000,'Meru','Imenti South','Female',25,'Student','Secondary','No','No','Yes','Open containers','Moderate','85','22.80','6','Moderate',1),(247,'HH-247-6090',0.0000000,37.9000000,'Meru','Imenti South','Male',18,'Student','Primary','No','No','Yes','Open containers','Moderate','85','22.80','6','Moderate',1),(248,'HH-248-3433',0.0000000,37.9000000,'Meru','Imenti South','Female',10,'Student','Primary','No','No','Yes','Open containers','Moderate','85','22.80','6','Moderate',1),(249,'HH-249-8893',-2.1000000,40.0000000,'Lamu','Lamu West','Female',45,'Fisher','Primary','No','Yes','Yes','Open containers','High','150','28.50','5','Difficult',1),(250,'HH-250-4168',-2.1000000,40.0000000,'Lamu','Lamu West','Male',47,'Fisher','Primary','No','Yes','Yes','Open containers','High','150','28.50','5','Difficult',1),(251,'HH-251-4163',-2.1000000,40.0000000,'Lamu','Lamu West','Female',20,'Student','Secondary','No','No','Yes','Open containers','High','150','28.50','5','Difficult',1),(252,'HH-252-8308',-2.1000000,40.0000000,'Lamu','Lamu West','Male',12,'Student','Primary','No','No','Yes','Open containers','High','150','28.50','5','Difficult',1),(253,'HH-253-9053',-2.1000000,40.0000000,'Lamu','Lamu West','Female',7,'None','None','No','No','Yes','Open containers','High','150','28.50','5','Difficult',1),(254,'HH-254-0342',-0.6900000,34.2500000,'Siaya','Bondo','Male',42,'Farmer','Secondary','Yes','No','Yes','Covered containers','Moderate','125','24.80','7','Moderate',1),(255,'HH-255-4550',-0.6900000,34.2500000,'Siaya','Bondo','Female',40,'Housewife','Primary','No','No','Yes','Covered containers','Moderate','125','24.80','7','Moderate',1),(256,'HH-256-1726',-0.6900000,34.2500000,'Siaya','Bondo','Male',18,'Student','Secondary','No','No','Yes','Covered containers','Moderate','125','24.80','7','Moderate',1),(257,'HH-257-4982',-0.6900000,34.2500000,'Siaya','Bondo','Female',15,'Student','Primary','Yes','No','Yes','Covered containers','Moderate','125','24.80','7','Moderate',1),(258,'HH-258-9732',-0.6900000,34.2500000,'Siaya','Bondo','Male',10,'Student','Primary','No','No','Yes','Covered containers','Moderate','125','24.80','7','Moderate',1),(259,'HH-259-3712',-0.6900000,34.2500000,'Siaya','Bondo','Female',7,'None','None','No','No','Yes','Covered containers','Moderate','125','24.80','7','Moderate',1),(260,'HH-260-9368',-0.6900000,34.2500000,'Siaya','Bondo','Male',3,'None','None','No','No','Yes','Covered containers','Moderate','125','24.80','7','Moderate',1),(261,'HH-261-5701',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',55,'Farmer','Primary','No','No','No','No storage','Low','60','19.20','3','Moderate',1),(262,'HH-262-0402',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Male',57,'Farmer','Primary','No','No','No','No storage','Low','60','19.20','3','Moderate',1),(263,'HH-263-4910',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',22,'Student','Tertiary','No','No','No','No storage','Low','60','19.20','3','Moderate',1),(264,'HH-264-3342',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',45,'Pastoralist','None','Yes','No','No','Open containers','High','160','26.80','6','Difficult',1),(265,'HH-265-1981',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',43,'Housewife','None','Yes','No','No','Open containers','High','160','26.80','6','Difficult',1),(266,'HH-266-9878',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',18,'Student','Primary','No','No','No','Open containers','High','160','26.80','6','Difficult',1),(267,'HH-267-3448',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',15,'None','None','No','No','No','Open containers','High','160','26.80','6','Difficult',1),(268,'HH-268-7608',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',10,'None','None','No','No','No','Open containers','High','160','26.80','6','Difficult',1),(269,'HH-269-7698',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',5,'None','None','No','No','No','Open containers','High','160','26.80','6','Difficult',1),(270,'HH-270-5663',-0.1000000,37.5000000,'Embu','Embu West','Female',38,'Trader','Secondary','No','No','No','Covered containers','Moderate','70','22.30','4','Easy',1),(271,'HH-271-5222',-0.1000000,37.5000000,'Embu','Embu West','Male',40,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','70','22.30','4','Easy',1),(272,'HH-272-9124',-0.1000000,37.5000000,'Embu','Embu West','Female',12,'Student','Primary','No','No','No','Covered containers','Moderate','70','22.30','4','Easy',1),(273,'HH-273-9953',-0.1000000,37.5000000,'Embu','Embu West','Male',7,'None','None','No','No','No','Covered containers','Moderate','70','22.30','4','Easy',1),(274,'HH-274-2394',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',50,'Farmer','Primary','No','No','Yes','Open containers','High','105','26.80','5','Moderate',1),(275,'HH-275-2113',-0.2000000,38.0000000,'Kitui','Kitui Central','Female',48,'Housewife','Primary','No','No','Yes','Open containers','High','105','26.80','5','Moderate',1),(276,'HH-276-3381',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',25,'Student','Secondary','No','No','Yes','Open containers','High','105','26.80','5','Moderate',1),(277,'HH-277-0569',-0.2000000,38.0000000,'Kitui','Kitui Central','Female',20,'Student','Primary','No','No','Yes','Open containers','High','105','26.80','5','Moderate',1),(278,'HH-278-2702',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',10,'None','None','No','No','Yes','Open containers','High','105','26.80','5','Moderate',1),(279,'HH-279-1805',0.7500000,34.5000000,'Kakamega','Butere','Female',60,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','130','23.80','4','Easy',1),(280,'HH-280-0917',0.7500000,34.5000000,'Kakamega','Butere','Male',62,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','130','23.80','4','Easy',1),(281,'HH-281-9171',0.7500000,34.5000000,'Kakamega','Butere','Female',30,'Teacher','Tertiary','No','No','Yes','Covered containers','Moderate','130','23.80','4','Easy',1),(282,'HH-282-3107',0.7500000,34.5000000,'Kakamega','Butere','Male',28,'Farmer','Secondary','No','No','Yes','Covered containers','Moderate','130','23.80','4','Easy',1),(283,'HH-283-8019',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Male',35,'Salesperson','Secondary','No','No','No','No storage','Low','50','21.30','3','Easy',1),(284,'HH-284-0777',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Female',33,'Hairdresser','Secondary','No','No','No','No storage','Low','50','21.30','3','Easy',1),(285,'HH-285-9828',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Female',7,'None','None','No','No','No','No storage','Low','50','21.30','3','Easy',1),(286,'HH-286-6811',1.5000000,37.5000000,'Marsabit','Moyale','Female',65,'Pastoralist','None','Yes','No','No','Open containers','High','180','30.80','7','Difficult',1),(287,'HH-287-4572',1.5000000,37.5000000,'Marsabit','Moyale','Male',68,'Pastoralist','None','Yes','No','No','Open containers','High','180','30.80','7','Difficult',1),(288,'HH-288-2425',1.5000000,37.5000000,'Marsabit','Moyale','Female',35,'Housewife','None','No','No','No','Open containers','High','180','30.80','7','Difficult',1),(289,'HH-289-8409',1.5000000,37.5000000,'Marsabit','Moyale','Male',33,'Pastoralist','None','Yes','No','No','Open containers','High','180','30.80','7','Difficult',1),(290,'HH-290-4771',1.5000000,37.5000000,'Marsabit','Moyale','Female',18,'None','Primary','No','No','No','Open containers','High','180','30.80','7','Difficult',1),(291,'HH-291-8627',1.5000000,37.5000000,'Marsabit','Moyale','Male',12,'None','None','No','No','No','Open containers','High','180','30.80','7','Difficult',1),(292,'HH-292-8825',1.5000000,37.5000000,'Marsabit','Moyale','Female',7,'None','None','No','No','No','Open containers','High','180','30.80','7','Difficult',1),(293,'HH-293-8244',-0.0500000,35.3000000,'Kericho','Kericho East','Male',45,'Farmer','Secondary','No','No','No','Covered containers','Moderate','90','20.50','5','Moderate',1),(294,'HH-294-4746',-0.0500000,35.3000000,'Kericho','Kericho East','Female',43,'Housewife','Primary','No','No','No','Covered containers','Moderate','90','20.50','5','Moderate',1),(295,'HH-295-9000',-0.0500000,35.3000000,'Kericho','Kericho East','Male',18,'Student','Secondary','No','No','No','Covered containers','Moderate','90','20.50','5','Moderate',1),(296,'HH-296-0760',-0.0500000,35.3000000,'Kericho','Kericho East','Female',12,'Student','Primary','No','No','No','Covered containers','Moderate','90','20.50','5','Moderate',1),(297,'HH-297-6803',-0.0500000,35.3000000,'Kericho','Kericho East','Male',7,'None','None','No','No','No','Covered containers','Moderate','90','20.50','5','Moderate',1),(298,'HH-298-1735',0.6000000,39.0000000,'Garissa','Fafi','Female',55,'Trader','None','Yes','No','No','Open containers','High','200','31.80','6','Difficult',1),(299,'HH-299-8268',0.6000000,39.0000000,'Garissa','Fafi','Male',60,'Trader','None','Yes','No','No','Open containers','High','200','31.80','6','Difficult',1),(300,'HH-300-6133',0.6000000,39.0000000,'Garissa','Fafi','Female',30,'None','Primary','No','No','No','Open containers','High','200','31.80','6','Difficult',1),(301,'HH-301-5864',0.6000000,39.0000000,'Garissa','Fafi','Male',25,'None','Primary','Yes','No','No','Open containers','High','200','31.80','6','Difficult',1),(302,'HH-302-0922',0.6000000,39.0000000,'Garissa','Fafi','Female',15,'None','None','No','No','No','Open containers','High','200','31.80','6','Difficult',1),(303,'HH-303-7016',0.6000000,39.0000000,'Garissa','Fafi','Male',10,'None','None','No','No','No','Open containers','High','200','31.80','6','Difficult',1),(304,'HH-304-2315',-1.0000000,36.5000000,'Kiambu','Limuru','Male',40,'Driver','Secondary','No','No','No','Covered containers','Low','55','19.80','4','Easy',1),(305,'HH-305-0530',-1.0000000,36.5000000,'Kiambu','Limuru','Female',38,'Hairdresser','Secondary','No','No','No','Covered containers','Low','55','19.80','4','Easy',1),(306,'HH-306-5703',-1.0000000,36.5000000,'Kiambu','Limuru','Male',10,'Student','Primary','No','No','No','Covered containers','Low','55','19.80','4','Easy',1),(307,'HH-307-6928',-1.0000000,36.5000000,'Kiambu','Limuru','Female',5,'None','None','No','No','No','Covered containers','Low','55','19.80','4','Easy',1),(308,'HH-308-7530',0.0000000,34.0000000,'Busia','Samia','Female',52,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','125','25.00','6','Moderate',1),(309,'HH-309-6865',0.0000000,34.0000000,'Busia','Samia','Male',55,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','125','25.00','6','Moderate',1),(310,'HH-310-1736',0.0000000,34.0000000,'Busia','Samia','Female',22,'Student','Secondary','No','No','Yes','Covered containers','Moderate','125','25.00','6','Moderate',1),(311,'HH-311-8086',0.0000000,34.0000000,'Busia','Samia','Male',20,'Farmer','Secondary','Yes','No','Yes','Covered containers','Moderate','125','25.00','6','Moderate',1),(312,'HH-312-5224',0.0000000,34.0000000,'Busia','Samia','Female',12,'Student','Primary','No','No','Yes','Covered containers','Moderate','125','25.00','6','Moderate',1),(313,'HH-313-1863',0.0000000,34.0000000,'Busia','Samia','Male',7,'None','None','No','No','Yes','Covered containers','Moderate','125','25.00','6','Moderate',1),(314,'HH-314-3643',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',70,'Pastoralist','None','Yes','No','No','Open containers','High','175','28.80','5','Difficult',1),(315,'HH-315-2625',1.0000000,35.0000000,'West Pokot','Pokot Central','Female',68,'Housewife','None','Yes','No','No','Open containers','High','175','28.80','5','Difficult',1),(316,'HH-316-2196',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',35,'Pastoralist','None','No','No','No','Open containers','High','175','28.80','5','Difficult',1),(317,'HH-317-3108',1.0000000,35.0000000,'West Pokot','Pokot Central','Female',33,'Housewife','None','No','No','No','Open containers','High','175','28.80','5','Difficult',1),(318,'HH-318-8953',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',12,'None','None','No','No','No','Open containers','High','175','28.80','5','Difficult',1),(319,'HH-319-5439',-0.5000000,37.0000000,'Makueni','Makueni','Female',42,'Farmer','Primary','No','No','Yes','Covered containers','Moderate','80','26.20','5','Moderate',1),(320,'HH-320-0336',-0.5000000,37.0000000,'Makueni','Makueni','Male',45,'Farmer','Primary','No','No','Yes','Covered containers','Moderate','80','26.20','5','Moderate',1),(321,'HH-321-5364',-0.5000000,37.0000000,'Makueni','Makueni','Female',18,'Student','Secondary','No','No','Yes','Covered containers','Moderate','80','26.20','5','Moderate',1),(322,'HH-322-5811',-0.5000000,37.0000000,'Makueni','Makueni','Male',15,'Student','Primary','No','No','Yes','Covered containers','Moderate','80','26.20','5','Moderate',1),(323,'HH-323-2964',-0.5000000,37.0000000,'Makueni','Makueni','Female',7,'None','None','No','No','Yes','Covered containers','Moderate','80','26.20','5','Moderate',1),(324,'HH-324-7387',-1.5000000,38.0000000,'Tana River','Galole','Male',60,'Fisher','Primary','Yes','No','Yes','Open containers','High','160','29.30','6','Difficult',1),(325,'HH-325-8046',-1.5000000,38.0000000,'Tana River','Galole','Female',58,'Housewife','Primary','Yes','No','Yes','Open containers','High','160','29.30','6','Difficult',1),(326,'HH-326-8067',-1.5000000,38.0000000,'Tana River','Galole','Male',30,'Fisher','Secondary','No','No','Yes','Open containers','High','160','29.30','6','Difficult',1),(327,'HH-327-6199',-1.5000000,38.0000000,'Tana River','Galole','Female',28,'None','Primary','No','No','Yes','Open containers','High','160','29.30','6','Difficult',1),(328,'HH-328-6792',-1.5000000,38.0000000,'Tana River','Galole','Male',12,'Student','None','No','No','Yes','Open containers','High','160','29.30','6','Difficult',1),(329,'HH-329-5365',-1.5000000,38.0000000,'Tana River','Galole','Female',7,'None','None','No','No','Yes','Open containers','High','160','29.30','6','Difficult',1),(330,'HH-330-6451',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Female',35,'Trader','Secondary','Yes','No','Yes','Covered containers','Moderate','120','25.50','4','Easy',1),(331,'HH-331-6161',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Male',38,'Fisher','Secondary','Yes','No','Yes','Covered containers','Moderate','120','25.50','4','Easy',1),(332,'HH-332-1452',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Female',10,'Student','Primary','No','No','Yes','Covered containers','Moderate','120','25.50','4','Easy',1),(333,'HH-333-8778',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Male',5,'None','None','No','No','Yes','Covered containers','Moderate','120','25.50','4','Easy',1),(334,'HH-334-9534',0.5000000,36.0000000,'Baringo','Mogotio','Male',50,'Pastoralist','None','Yes','No','No','Open containers','High','185','27.80','5','Difficult',1),(335,'HH-335-1336',0.5000000,36.0000000,'Baringo','Mogotio','Female',48,'Housewife','None','Yes','No','No','Open containers','High','185','27.80','5','Difficult',1),(336,'HH-336-8077',0.5000000,36.0000000,'Baringo','Mogotio','Male',25,'Pastoralist','Primary','No','No','No','Open containers','High','185','27.80','5','Difficult',1),(337,'HH-337-6377',0.5000000,36.0000000,'Baringo','Mogotio','Female',20,'None','None','No','No','No','Open containers','High','185','27.80','5','Difficult',1),(338,'HH-338-7657',0.5000000,36.0000000,'Baringo','Mogotio','Male',10,'None','None','No','No','No','Open containers','High','185','27.80','5','Difficult',1),(339,'HH-339-9155',-0.4500000,36.2000000,'Nyandarua','Kinangop','Female',60,'Farmer','Primary','No','No','No','Covered containers','Low','65','18.30','3','Moderate',1),(340,'HH-340-2804',-0.4500000,36.2000000,'Nyandarua','Kinangop','Male',62,'Farmer','Primary','No','No','No','Covered containers','Low','65','18.30','3','Moderate',1),(341,'HH-341-6556',-0.4500000,36.2000000,'Nyandarua','Kinangop','Female',30,'Teacher','Tertiary','No','No','No','Covered containers','Low','65','18.30','3','Moderate',1),(342,'HH-342-4367',-1.2000000,37.8000000,'Kwale','Kinango','Male',45,'Farmer','Primary','Yes','No','Yes','Open containers','High','145','28.80','5','Difficult',1),(343,'HH-343-2169',-1.2000000,37.8000000,'Kwale','Kinango','Female',43,'Housewife','Primary','No','No','Yes','Open containers','High','145','28.80','5','Difficult',1),(344,'HH-344-7742',-1.2000000,37.8000000,'Kwale','Kinango','Male',18,'Student','Secondary','No','No','Yes','Open containers','High','145','28.80','5','Difficult',1),(345,'HH-345-2205',-1.2000000,37.8000000,'Kwale','Kinango','Female',15,'Student','Primary','No','No','Yes','Open containers','High','145','28.80','5','Difficult',1),(346,'HH-346-7801',-1.2000000,37.8000000,'Kwale','Kinango','Male',7,'None','None','No','No','Yes','Open containers','High','145','28.80','5','Difficult',1),(347,'HH-347-2389',0.5500000,34.7000000,'Vihiga','Sabatia','Female',35,'Businesswoman','Secondary','No','No','Yes','Covered containers','Moderate','110','23.30','4','Easy',1),(348,'HH-348-8543',0.5500000,34.7000000,'Vihiga','Sabatia','Male',38,'Carpenter','Secondary','No','No','Yes','Covered containers','Moderate','110','23.30','4','Easy',1),(349,'HH-349-5548',0.5500000,34.7000000,'Vihiga','Sabatia','Female',10,'Student','Primary','No','No','Yes','Covered containers','Moderate','110','23.30','4','Easy',1),(350,'HH-350-2112',0.5500000,34.7000000,'Vihiga','Sabatia','Male',5,'None','None','No','No','Yes','Covered containers','Moderate','110','23.30','4','Easy',1),(351,'HH-351-3917',-0.7000000,37.5000000,'Kwale','Msambweni','Male',50,'Fisher','Primary','No','Yes','Yes','Open containers','High','150','29.00','5','Difficult',1),(352,'HH-352-3249',-0.7000000,37.5000000,'Kwale','Msambweni','Female',48,'Trader','Primary','No','Yes','Yes','Open containers','High','150','29.00','5','Difficult',1),(353,'HH-353-4492',-0.7000000,37.5000000,'Kwale','Msambweni','Male',25,'Student','Secondary','No','No','Yes','Open containers','High','150','29.00','5','Difficult',1),(354,'HH-354-2717',-0.7000000,37.5000000,'Kwale','Msambweni','Female',20,'Student','Primary','No','No','Yes','Open containers','High','150','29.00','5','Difficult',1),(355,'HH-355-0109',-0.7000000,37.5000000,'Kwale','Msambweni','Male',10,'None','None','No','No','Yes','Open containers','High','150','29.00','5','Difficult',1),(356,'HH-356-2392',-0.0800000,34.9000000,'Nyamira','Nyamira North','Female',55,'Farmer','Primary','No','No','No','Covered containers','Low','75','20.80','4','Moderate',1),(357,'HH-357-1636',-0.0800000,34.9000000,'Nyamira','Nyamira North','Male',58,'Farmer','Primary','No','No','No','Covered containers','Low','75','20.80','4','Moderate',1),(358,'HH-358-1004',-0.0800000,34.9000000,'Nyamira','Nyamira North','Female',30,'Teacher','Tertiary','No','No','No','Covered containers','Low','75','20.80','4','Moderate',1),(359,'HH-359-0113',-0.0800000,34.9000000,'Nyamira','Nyamira North','Male',25,'Student','Secondary','No','No','No','Covered containers','Low','75','20.80','4','Moderate',1),(360,'HH-360-7554',-1.6000000,37.0000000,'Taita Taveta','Voi','Male',65,'Retired','Primary','No','No','No','No storage','Low','45','28.30','2','Easy',1),(361,'HH-361-7429',-1.6000000,37.0000000,'Taita Taveta','Voi','Female',63,'Housewife','Primary','No','No','No','No storage','Low','45','28.30','2','Easy',1),(362,'HH-362-4485',0.5000000,38.0000000,'Wajir','Wajir East','Female',45,'Pastoralist','None','Yes','No','No','Open containers','High','190','32.80','6','Difficult',1),(363,'HH-363-0138',0.5000000,38.0000000,'Wajir','Wajir East','Male',48,'Pastoralist','None','Yes','No','No','Open containers','High','190','32.80','6','Difficult',1),(364,'HH-364-7236',0.5000000,38.0000000,'Wajir','Wajir East','Female',20,'None','None','No','No','No','Open containers','High','190','32.80','6','Difficult',1),(365,'HH-365-5764',0.5000000,38.0000000,'Wajir','Wajir East','Male',18,'None','None','No','No','No','Open containers','High','190','32.80','6','Difficult',1),(366,'HH-366-7115',0.5000000,38.0000000,'Wajir','Wajir East','Female',10,'None','None','No','No','No','Open containers','High','190','32.80','6','Difficult',1),(367,'HH-367-8282',0.5000000,38.0000000,'Wajir','Wajir East','Male',5,'None','None','No','No','No','Open containers','High','190','32.80','6','Difficult',1),(368,'HH-368-0068',-0.2000000,35.5000000,'Nyamira','Manga','Male',40,'Farmer','Secondary','No','No','No','Covered containers','Moderate','100','21.80','5','Moderate',1),(369,'HH-369-5492',-0.2000000,35.5000000,'Nyamira','Manga','Female',38,'Housewife','Primary','No','No','No','Covered containers','Moderate','100','21.80','5','Moderate',1),(370,'HH-370-7255',-0.2000000,35.5000000,'Nyamira','Manga','Male',12,'Student','Primary','No','No','No','Covered containers','Moderate','100','21.80','5','Moderate',1),(371,'HH-371-9803',-0.2000000,35.5000000,'Nyamira','Manga','Female',10,'None','None','No','No','No','Covered containers','Moderate','100','21.80','5','Moderate',1),(372,'HH-372-7248',-0.2000000,35.5000000,'Nyamira','Manga','Male',5,'None','None','No','No','No','Covered containers','Moderate','100','21.80','5','Moderate',1),(373,'HH-373-6831',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',52,'Farmer','Primary','No','No','No','No storage','Low','55','20.30','4','Moderate',1),(374,'HH-374-2412',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',55,'Farmer','Primary','No','No','No','No storage','Low','55','20.30','4','Moderate',1),(375,'HH-375-1567',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',22,'Student','Tertiary','No','No','No','No storage','Low','55','20.30','4','Moderate',1),(376,'HH-376-0600',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',20,'Student','Secondary','No','No','No','No storage','Low','55','20.30','4','Moderate',1),(377,'HH-377-8300',0.0000000,34.5000000,'Kakamega','Lurambi','Male',45,'Teacher','Tertiary','No','No','Yes','Covered containers','Moderate','105','22.80','5','Easy',1),(378,'HH-378-9700',0.0000000,34.5000000,'Kakamega','Lurambi','Female',43,'Housewife','Secondary','No','No','Yes','Covered containers','Moderate','105','22.80','5','Easy',1),(379,'HH-379-3600',0.0000000,34.5000000,'Kakamega','Lurambi','Male',18,'Student','Secondary','No','No','Yes','Covered containers','Moderate','105','22.80','5','Easy',1),(380,'HH-380-8901',0.0000000,34.5000000,'Kakamega','Lurambi','Female',15,'Student','Primary','No','No','Yes','Covered containers','Moderate','105','22.80','5','Easy',1),(381,'HH-381-3706',0.0000000,34.5000000,'Kakamega','Lurambi','Male',7,'None','None','No','No','Yes','Covered containers','Moderate','105','22.80','5','Easy',1),(382,'HH-382-1828',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',60,'Farmer','Primary','No','No','No','Open containers','High','85','27.30','6','Difficult',1),(383,'HH-383-8020',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',62,'Farmer','Primary','No','No','No','Open containers','High','85','27.30','6','Difficult',1),(384,'HH-384-4618',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',30,'Trader','Secondary','No','No','No','Open containers','High','85','27.30','6','Difficult',1),(385,'HH-385-9029',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',28,'Farmer','Secondary','No','No','No','Open containers','High','85','27.30','6','Difficult',1),(386,'HH-386-1292',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',12,'Student','Primary','No','No','No','Open containers','High','85','27.30','6','Difficult',1),(387,'HH-387-9375',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',7,'None','None','No','No','No','Open containers','High','85','27.30','6','Difficult',1),(388,'HH-388-2998',0.2500000,37.0000000,'Nyeri','Nyeri Central','Male',45,'Civil Servant','Tertiary','No','No','No','Covered containers','Low','65','18.80','4','Easy',1),(389,'HH-389-6868',0.2500000,37.0000000,'Nyeri','Nyeri Central','Female',43,'Teacher','Tertiary','No','No','No','Covered containers','Low','65','18.80','4','Easy',1),(390,'HH-390-5346',0.2500000,37.0000000,'Nyeri','Nyeri Central','Male',15,'Student','Primary','No','No','No','Covered containers','Low','65','18.80','4','Easy',1),(391,'HH-391-6124',0.2500000,37.0000000,'Nyeri','Nyeri Central','Female',10,'Student','Primary','No','No','No','Covered containers','Low','65','18.80','4','Easy',1),(392,'HH-392-4583',0.1000000,34.2000000,'Bungoma','Kimilili','Female',55,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','115','22.80','5','Moderate',1),(393,'HH-393-4543',0.1000000,34.2000000,'Bungoma','Kimilili','Male',57,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','115','22.80','5','Moderate',1),(394,'HH-394-8965',0.1000000,34.2000000,'Bungoma','Kimilili','Female',22,'Student','Secondary','No','No','Yes','Covered containers','Moderate','115','22.80','5','Moderate',1),(395,'HH-395-1199',0.1000000,34.2000000,'Bungoma','Kimilili','Male',20,'Farmer','Secondary','No','No','Yes','Covered containers','Moderate','115','22.80','5','Moderate',1),(396,'HH-396-9101',0.1000000,34.2000000,'Bungoma','Kimilili','Female',12,'Student','Primary','No','No','Yes','Covered containers','Moderate','115','22.80','5','Moderate',1),(397,'HH-397-1906',0.0000000,37.0000000,'Kirinyaga','Mwea','Male',40,'Rice Farmer','Secondary','No','No','No','Covered containers','Moderate','75','23.80','4','Easy',1),(398,'HH-398-2229',0.0000000,37.0000000,'Kirinyaga','Mwea','Female',38,'Housewife','Primary','No','No','No','Covered containers','Moderate','75','23.80','4','Easy',1),(399,'HH-399-5426',0.0000000,37.0000000,'Kirinyaga','Mwea','Male',12,'Student','Primary','No','No','No','Covered containers','Moderate','75','23.80','4','Easy',1),(400,'HH-400-0445',0.0000000,37.0000000,'Kirinyaga','Mwea','Female',7,'None','None','No','No','No','Covered containers','Moderate','75','23.80','4','Easy',1),(401,'HH-401-5947',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',50,'Farmer','Primary','No','No','No','No storage','Low','70','19.80','5','Moderate',1),(402,'HH-402-8402',0.7000000,35.0000000,'Trans Nzoia','Kitale','Male',52,'Farmer','Primary','No','No','No','No storage','Low','70','19.80','5','Moderate',1),(403,'HH-403-4170',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',22,'Student','Secondary','No','No','No','No storage','Low','70','19.80','5','Moderate',1),(404,'HH-404-5645',0.7000000,35.0000000,'Trans Nzoia','Kitale','Male',20,'Farmer','Secondary','No','No','No','No storage','Low','70','19.80','5','Moderate',1),(405,'HH-405-5712',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',12,'Student','Primary','No','No','No','No storage','Low','70','19.80','5','Moderate',1),(406,'HH-406-1629',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',30,'Office Worker','Tertiary','No','No','No','Covered containers','Moderate','110','24.00','3','Easy',1),(407,'HH-407-1006',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Male',32,'Teacher','Tertiary','No','No','No','Covered containers','Moderate','110','24.00','3','Easy',1),(408,'HH-408-0146',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',3,'None','None','No','No','No','Covered containers','Moderate','110','24.00','3','Easy',1),(409,'HH-409-7711',0.5147000,35.2698000,'Nandi','Nandi Hills','Male',65,'Retired','Primary','No','No','No','No storage','Low','60','19.60','2','Moderate',1),(410,'HH-410-8118',0.5147000,35.2698000,'Nandi','Nandi Hills','Female',63,'Housewife','Primary','No','No','No','No storage','Low','60','19.60','2','Moderate',1),(411,'HH-411-7458',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Female',40,'Entrepreneur','Secondary','No','No','No','Covered containers','High','40','23.30','4','Easy',1),(412,'HH-412-2935',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',42,'IT Professional','Tertiary','No','No','No','Covered containers','High','40','23.30','4','Easy',1),(413,'HH-413-2300',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Female',12,'Student','Primary','No','No','No','Covered containers','High','40','23.30','4','Easy',1),(414,'HH-414-2699',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',7,'None','None','No','No','No','Covered containers','High','40','23.30','4','Easy',1),(415,'HH-415-6593',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',75,'Pastoralist','None','Yes','No','Yes','Open containers','High','160','27.80','5','Difficult',1),(416,'HH-416-4870',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',72,'Housewife','None','Yes','No','Yes','Open containers','High','160','27.80','5','Difficult',1),(417,'HH-417-4569',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',35,'Pastoralist','Primary','No','No','Yes','Open containers','High','160','27.80','5','Difficult',1),(418,'HH-418-8239',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',30,'None','Primary','No','No','Yes','Open containers','High','160','27.80','5','Difficult',1),(419,'HH-419-7485',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',10,'None','None','No','No','Yes','Open containers','High','160','27.80','5','Difficult',1),(420,'HH-420-2712',-0.5000000,39.8000000,'Kilifi','Kilifi North','Female',55,'Fisher','Primary','No','Yes','Yes','Open containers','High','130','28.70','4','Moderate',1),(421,'HH-421-1104',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',57,'Fisher','Primary','No','Yes','Yes','Open containers','High','130','28.70','4','Moderate',1),(422,'HH-422-7383',-0.5000000,39.8000000,'Kilifi','Kilifi North','Female',22,'Student','Secondary','No','No','Yes','Open containers','High','130','28.70','4','Moderate',1),(423,'HH-423-3605',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',18,'Student','Primary','No','No','Yes','Open containers','High','130','28.70','4','Moderate',1),(424,'HH-424-5877',0.2833000,34.7500000,'Bungoma','Bungoma Central','Male',75,'Retired','Primary','No','No','Yes','Covered containers','Moderate','90','21.60','2','Easy',1),(425,'HH-425-8571',0.2833000,34.7500000,'Bungoma','Bungoma Central','Female',73,'Housewife','Primary','No','No','Yes','Covered containers','Moderate','90','21.60','2','Easy',1),(426,'HH-426-5225',-0.7833000,35.0000000,'Narok','Narok North','Female',40,'Trader','Primary','No','No','No','No storage','Low','50','25.10','5','Difficult',1),(427,'HH-427-0411',-0.7833000,35.0000000,'Narok','Narok North','Male',42,'Trader','Primary','No','No','No','No storage','Low','50','25.10','5','Difficult',1),(428,'HH-428-6381',-0.7833000,35.0000000,'Narok','Narok North','Female',12,'Student','Primary','No','No','No','No storage','Low','50','25.10','5','Difficult',1),(429,'HH-429-0673',-0.7833000,35.0000000,'Narok','Narok North','Male',10,'None','None','No','No','No','No storage','Low','50','25.10','5','Difficult',1),(430,'HH-430-4223',-0.7833000,35.0000000,'Narok','Narok North','Female',5,'None','None','No','No','No','No storage','Low','50','25.10','5','Difficult',1),(431,'HH-431-9096',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',60,'Farmer','Secondary','No','No','No','Covered containers','Moderate','70','20.60','4','Easy',1),(432,'HH-432-2810',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',58,'Housewife','Primary','No','No','No','Covered containers','Moderate','70','20.60','4','Easy',1),(433,'HH-433-6763',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',22,'Student','Tertiary','No','No','No','Covered containers','Moderate','70','20.60','4','Easy',1),(434,'HH-434-5384',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',18,'Student','Secondary','No','No','No','Covered containers','Moderate','70','20.60','4','Easy',1),(435,'HH-435-6632',2.8000000,36.0000000,'Turkana','Turkana North','Male',80,'Pastoralist','None','Yes','No','No','Open containers','High','180','30.00','6','Difficult',1),(436,'HH-436-7009',2.8000000,36.0000000,'Turkana','Turkana North','Female',78,'Housewife','None','Yes','No','No','Open containers','High','180','30.00','6','Difficult',1),(437,'HH-437-5151',2.8000000,36.0000000,'Turkana','Turkana North','Male',45,'Pastoralist','None','Yes','No','No','Open containers','High','180','30.00','6','Difficult',1),(438,'HH-438-4727',2.8000000,36.0000000,'Turkana','Turkana North','Female',43,'Housewife','None','No','No','No','Open containers','High','180','30.00','6','Difficult',1),(439,'HH-439-8182',2.8000000,36.0000000,'Turkana','Turkana North','Male',15,'Student','Primary','No','No','No','Open containers','High','180','30.00','6','Difficult',1),(440,'HH-440-6730',2.8000000,36.0000000,'Turkana','Turkana North','Female',10,'None','None','No','No','No','Open containers','High','180','30.00','6','Difficult',1),(441,'HH-441-9105',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',35,'Shopkeeper','Secondary','No','No','No','Covered containers','Moderate','30','25.60','3','Easy',1),(442,'HH-442-5333',-0.6000000,37.0000000,'Machakos','Machakos Town','Male',38,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','30','25.60','3','Easy',1),(443,'HH-443-9354',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',7,'None','None','No','No','No','Covered containers','Moderate','30','25.60','3','Easy',1),(444,'HH-444-0769',0.0000000,37.9000000,'Meru','Imenti South','Male',65,'Farmer','Primary','No','No','Yes','Open containers','Moderate','80','22.60','6','Moderate',1),(445,'HH-445-5784',0.0000000,37.9000000,'Meru','Imenti South','Female',60,'Housewife','Primary','No','No','Yes','Open containers','Moderate','80','22.60','6','Moderate',1),(446,'HH-446-6614',0.0000000,37.9000000,'Meru','Imenti South','Male',35,'Farmer','Secondary','No','No','Yes','Open containers','Moderate','80','22.60','6','Moderate',1),(447,'HH-447-5718',0.0000000,37.9000000,'Meru','Imenti South','Female',30,'Student','Secondary','No','No','Yes','Open containers','Moderate','80','22.60','6','Moderate',1),(448,'HH-448-8748',0.0000000,37.9000000,'Meru','Imenti South','Male',20,'Student','Primary','No','No','Yes','Open containers','Moderate','80','22.60','6','Moderate',1),(449,'HH-449-6587',0.0000000,37.9000000,'Meru','Imenti South','Female',12,'Student','Primary','No','No','Yes','Open containers','Moderate','80','22.60','6','Moderate',1),(450,'HH-450-6693',-2.1000000,40.0000000,'Lamu','Lamu West','Female',50,'Fisher','Primary','No','Yes','Yes','Open containers','High','140','28.30','5','Difficult',1),(451,'HH-451-3704',-2.1000000,40.0000000,'Lamu','Lamu West','Male',52,'Fisher','Primary','No','Yes','Yes','Open containers','High','140','28.30','5','Difficult',1),(452,'HH-452-8443',-2.1000000,40.0000000,'Lamu','Lamu West','Female',25,'Student','Secondary','No','No','Yes','Open containers','High','140','28.30','5','Difficult',1),(453,'HH-453-1102',-2.1000000,40.0000000,'Lamu','Lamu West','Male',18,'Student','Primary','No','No','Yes','Open containers','High','140','28.30','5','Difficult',1),(454,'HH-454-0184',-2.1000000,40.0000000,'Lamu','Lamu West','Female',10,'None','None','No','No','Yes','Open containers','High','140','28.30','5','Difficult',1),(455,'HH-455-7612',-0.6900000,34.2500000,'Siaya','Bondo','Male',48,'Farmer','Secondary','Yes','No','Yes','Covered containers','Moderate','120','24.60','7','Moderate',1),(456,'HH-456-7508',-0.6900000,34.2500000,'Siaya','Bondo','Female',46,'Housewife','Primary','No','No','Yes','Covered containers','Moderate','120','24.60','7','Moderate',1),(457,'HH-457-4707',-0.6900000,34.2500000,'Siaya','Bondo','Male',20,'Student','Secondary','No','No','Yes','Covered containers','Moderate','120','24.60','7','Moderate',1),(458,'HH-458-1011',-0.6900000,34.2500000,'Siaya','Bondo','Female',18,'Student','Primary','Yes','No','Yes','Covered containers','Moderate','120','24.60','7','Moderate',1),(459,'HH-459-0934',-0.6900000,34.2500000,'Siaya','Bondo','Male',12,'Student','Primary','No','No','Yes','Covered containers','Moderate','120','24.60','7','Moderate',1),(460,'HH-460-1638',-0.6900000,34.2500000,'Siaya','Bondo','Female',10,'None','None','No','No','Yes','Covered containers','Moderate','120','24.60','7','Moderate',1),(461,'HH-461-5388',-0.6900000,34.2500000,'Siaya','Bondo','Male',5,'None','None','No','No','Yes','Covered containers','Moderate','120','24.60','7','Moderate',1),(462,'HH-462-2027',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',60,'Farmer','Primary','No','No','No','No storage','Low','55','19.00','3','Moderate',1),(463,'HH-463-3969',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Male',62,'Farmer','Primary','No','No','No','No storage','Low','55','19.00','3','Moderate',1),(464,'HH-464-3768',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',25,'Student','Tertiary','No','No','No','No storage','Low','55','19.00','3','Moderate',1),(465,'HH-465-6932',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',50,'Pastoralist','None','Yes','No','No','Open containers','High','150','26.60','6','Difficult',1),(466,'HH-466-3359',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',48,'Housewife','None','Yes','No','No','Open containers','High','150','26.60','6','Difficult',1),(467,'HH-467-5996',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',20,'Student','Primary','No','No','No','Open containers','High','150','26.60','6','Difficult',1),(468,'HH-468-9904',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',18,'None','None','No','No','No','Open containers','High','150','26.60','6','Difficult',1),(469,'HH-469-1532',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',12,'None','None','No','No','No','Open containers','High','150','26.60','6','Difficult',1),(470,'HH-470-7949',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',7,'None','None','No','No','No','Open containers','High','150','26.60','6','Difficult',1),(471,'HH-471-5151',-0.1000000,37.5000000,'Embu','Embu West','Female',42,'Trader','Secondary','No','No','No','Covered containers','Moderate','65','22.10','4','Easy',1),(472,'HH-472-1906',-0.1000000,37.5000000,'Embu','Embu West','Male',45,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','65','22.10','4','Easy',1),(473,'HH-473-4078',-0.1000000,37.5000000,'Embu','Embu West','Female',15,'Student','Primary','No','No','No','Covered containers','Moderate','65','22.10','4','Easy',1),(474,'HH-474-4675',-0.1000000,37.5000000,'Embu','Embu West','Male',10,'None','None','No','No','No','Covered containers','Moderate','65','22.10','4','Easy',1),(475,'HH-475-1139',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',55,'Farmer','Primary','No','No','Yes','Open containers','High','100','26.60','5','Moderate',1),(476,'HH-476-1673',-0.2000000,38.0000000,'Kitui','Kitui Central','Female',52,'Housewife','Primary','No','No','Yes','Open containers','High','100','26.60','5','Moderate',1),(477,'HH-477-4949',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',30,'Student','Secondary','No','No','Yes','Open containers','High','100','26.60','5','Moderate',1),(478,'HH-478-9724',-0.2000000,38.0000000,'Kitui','Kitui Central','Female',25,'Student','Primary','No','No','Yes','Open containers','High','100','26.60','5','Moderate',1),(479,'HH-479-3776',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',12,'None','None','No','No','Yes','Open containers','High','100','26.60','5','Moderate',1),(480,'HH-480-9709',0.7500000,34.5000000,'Kakamega','Butere','Female',65,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','125','23.60','4','Easy',1),(481,'HH-481-7214',0.7500000,34.5000000,'Kakamega','Butere','Male',68,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','125','23.60','4','Easy',1),(482,'HH-482-6947',0.7500000,34.5000000,'Kakamega','Butere','Female',35,'Teacher','Tertiary','No','No','Yes','Covered containers','Moderate','125','23.60','4','Easy',1),(483,'HH-483-3091',0.7500000,34.5000000,'Kakamega','Butere','Male',33,'Farmer','Secondary','No','No','Yes','Covered containers','Moderate','125','23.60','4','Easy',1),(484,'HH-484-4617',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Male',40,'Salesperson','Secondary','No','No','No','No storage','Low','45','21.10','3','Easy',1),(485,'HH-485-3812',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Female',38,'Hairdresser','Secondary','No','No','No','No storage','Low','45','21.10','3','Easy',1),(486,'HH-486-5209',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Female',10,'None','None','No','No','No','No storage','Low','45','21.10','3','Easy',1),(487,'HH-487-4608',1.5000000,37.5000000,'Marsabit','Moyale','Female',70,'Pastoralist','None','Yes','No','No','Open containers','High','170','30.60','7','Difficult',1),(488,'HH-488-7414',1.5000000,37.5000000,'Marsabit','Moyale','Male',72,'Pastoralist','None','Yes','No','No','Open containers','High','170','30.60','7','Difficult',1),(489,'HH-489-3245',1.5000000,37.5000000,'Marsabit','Moyale','Female',40,'Housewife','None','No','No','No','Open containers','High','170','30.60','7','Difficult',1),(490,'HH-490-3986',1.5000000,37.5000000,'Marsabit','Moyale','Male',38,'Pastoralist','None','Yes','No','No','Open containers','High','170','30.60','7','Difficult',1),(491,'HH-491-0195',1.5000000,37.5000000,'Marsabit','Moyale','Female',20,'None','Primary','No','No','No','Open containers','High','170','30.60','7','Difficult',1),(492,'HH-492-9016',1.5000000,37.5000000,'Marsabit','Moyale','Male',15,'None','None','No','No','No','Open containers','High','170','30.60','7','Difficult',1),(493,'HH-493-4496',1.5000000,37.5000000,'Marsabit','Moyale','Female',10,'None','None','No','No','No','Open containers','High','170','30.60','7','Difficult',1),(494,'HH-494-5433',-0.0500000,35.3000000,'Kericho','Kericho East','Male',50,'Farmer','Secondary','No','No','No','Covered containers','Moderate','85','20.30','5','Moderate',1),(495,'HH-495-3676',-0.0500000,35.3000000,'Kericho','Kericho East','Female',48,'Housewife','Primary','No','No','No','Covered containers','Moderate','85','20.30','5','Moderate',1),(496,'HH-496-2082',-0.0500000,35.3000000,'Kericho','Kericho East','Male',20,'Student','Secondary','No','No','No','Covered containers','Moderate','85','20.30','5','Moderate',1),(497,'HH-497-9383',-0.0500000,35.3000000,'Kericho','Kericho East','Female',15,'Student','Primary','No','No','No','Covered containers','Moderate','85','20.30','5','Moderate',1),(498,'HH-498-0670',-0.0500000,35.3000000,'Kericho','Kericho East','Male',10,'None','None','No','No','No','Covered containers','Moderate','85','20.30','5','Moderate',1),(499,'HH-499-5201',0.6000000,39.0000000,'Garissa','Fafi','Female',60,'Trader','None','Yes','No','No','Open containers','High','190','31.60','6','Difficult',1),(500,'HH-500-3996',0.6000000,39.0000000,'Garissa','Fafi','Male',65,'Trader','None','Yes','No','No','Open containers','High','190','31.60','6','Difficult',1),(501,'HH-501-4379',0.6000000,39.0000000,'Garissa','Fafi','Female',35,'None','Primary','No','No','No','Open containers','High','190','31.60','6','Difficult',1),(502,'HH-502-9905',0.6000000,39.0000000,'Garissa','Fafi','Male',30,'None','Primary','Yes','No','No','Open containers','High','190','31.60','6','Difficult',1),(503,'HH-503-6391',0.6000000,39.0000000,'Garissa','Fafi','Female',18,'None','None','No','No','No','Open containers','High','190','31.60','6','Difficult',1),(504,'HH-504-2239',0.6000000,39.0000000,'Garissa','Fafi','Male',12,'None','None','No','No','No','Open containers','High','190','31.60','6','Difficult',1),(505,'HH-505-2023',-1.0000000,36.5000000,'Kiambu','Limuru','Male',45,'Driver','Secondary','No','No','No','Covered containers','Low','50','19.60','4','Easy',1),(506,'HH-506-3398',-1.0000000,36.5000000,'Kiambu','Limuru','Female',43,'Hairdresser','Secondary','No','No','No','Covered containers','Low','50','19.60','4','Easy',1),(507,'HH-507-0921',-1.0000000,36.5000000,'Kiambu','Limuru','Male',12,'Student','Primary','No','No','No','Covered containers','Low','50','19.60','4','Easy',1),(508,'HH-508-4412',-1.0000000,36.5000000,'Kiambu','Limuru','Female',7,'None','None','No','No','No','Covered containers','Low','50','19.60','4','Easy',1),(509,'HH-509-9300',0.0000000,34.0000000,'Busia','Samia','Female',58,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','120','24.80','6','Moderate',1),(510,'HH-510-3261',0.0000000,34.0000000,'Busia','Samia','Male',60,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','120','24.80','6','Moderate',1),(511,'HH-511-8406',0.0000000,34.0000000,'Busia','Samia','Female',25,'Student','Secondary','No','No','Yes','Covered containers','Moderate','120','24.80','6','Moderate',1),(512,'HH-512-2248',0.0000000,34.0000000,'Busia','Samia','Male',22,'Farmer','Secondary','Yes','No','Yes','Covered containers','Moderate','120','24.80','6','Moderate',1),(513,'HH-513-6024',0.0000000,34.0000000,'Busia','Samia','Female',15,'Student','Primary','No','No','Yes','Covered containers','Moderate','120','24.80','6','Moderate',1),(514,'HH-514-3374',0.0000000,34.0000000,'Busia','Samia','Male',10,'None','None','No','No','Yes','Covered containers','Moderate','120','24.80','6','Moderate',1),(515,'HH-515-8800',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',75,'Pastoralist','None','Yes','No','No','Open containers','High','165','28.60','5','Difficult',1),(516,'HH-516-3878',1.0000000,35.0000000,'West Pokot','Pokot Central','Female',73,'Housewife','None','Yes','No','No','Open containers','High','165','28.60','5','Difficult',1),(517,'HH-517-2993',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',40,'Pastoralist','None','No','No','No','Open containers','High','165','28.60','5','Difficult',1),(518,'HH-518-3329',1.0000000,35.0000000,'West Pokot','Pokot Central','Female',38,'Housewife','None','No','No','No','Open containers','High','165','28.60','5','Difficult',1),(519,'HH-519-7665',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',15,'None','None','No','No','No','Open containers','High','165','28.60','5','Difficult',1),(520,'HH-520-8340',-0.5000000,37.0000000,'Makueni','Makueni','Female',48,'Farmer','Primary','No','No','Yes','Covered containers','Moderate','75','26.00','5','Moderate',1),(521,'HH-521-8705',-0.5000000,37.0000000,'Makueni','Makueni','Male',50,'Farmer','Primary','No','No','Yes','Covered containers','Moderate','75','26.00','5','Moderate',1),(522,'HH-522-8505',-0.5000000,37.0000000,'Makueni','Makueni','Female',20,'Student','Secondary','No','No','Yes','Covered containers','Moderate','75','26.00','5','Moderate',1),(523,'HH-523-6413',-0.5000000,37.0000000,'Makueni','Makueni','Male',18,'Student','Primary','No','No','Yes','Covered containers','Moderate','75','26.00','5','Moderate',1),(524,'HH-524-6548',-0.5000000,37.0000000,'Makueni','Makueni','Female',10,'None','None','No','No','Yes','Covered containers','Moderate','75','26.00','5','Moderate',1),(525,'HH-525-3501',-1.5000000,38.0000000,'Tana River','Galole','Male',65,'Fisher','Primary','Yes','No','Yes','Open containers','High','150','29.10','6','Difficult',1),(526,'HH-526-7864',-1.5000000,38.0000000,'Tana River','Galole','Female',63,'Housewife','Primary','Yes','No','Yes','Open containers','High','150','29.10','6','Difficult',1),(527,'HH-527-8816',-1.5000000,38.0000000,'Tana River','Galole','Male',35,'Fisher','Secondary','No','No','Yes','Open containers','High','150','29.10','6','Difficult',1),(528,'HH-528-0488',-1.5000000,38.0000000,'Tana River','Galole','Female',33,'None','Primary','No','No','Yes','Open containers','High','150','29.10','6','Difficult',1),(529,'HH-529-5995',-1.5000000,38.0000000,'Tana River','Galole','Male',15,'Student','None','No','No','Yes','Open containers','High','150','29.10','6','Difficult',1),(530,'HH-530-8510',-1.5000000,38.0000000,'Tana River','Galole','Female',10,'None','None','No','No','Yes','Open containers','High','150','29.10','6','Difficult',1),(531,'HH-531-4565',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Female',40,'Trader','Secondary','Yes','No','Yes','Covered containers','Moderate','115','25.30','4','Easy',1),(532,'HH-532-7297',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Male',42,'Fisher','Secondary','Yes','No','Yes','Covered containers','Moderate','115','25.30','4','Easy',1),(533,'HH-533-2790',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Female',12,'Student','Primary','No','No','Yes','Covered containers','Moderate','115','25.30','4','Easy',1),(534,'HH-534-2060',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Male',7,'None','None','No','No','Yes','Covered containers','Moderate','115','25.30','4','Easy',1),(535,'HH-535-1928',0.5000000,36.0000000,'Baringo','Mogotio','Male',55,'Pastoralist','None','Yes','No','No','Open containers','High','175','27.60','5','Difficult',1),(536,'HH-536-3463',0.5000000,36.0000000,'Baringo','Mogotio','Female',53,'Housewife','None','Yes','No','No','Open containers','High','175','27.60','5','Difficult',1),(537,'HH-537-1530',0.5000000,36.0000000,'Baringo','Mogotio','Male',28,'Pastoralist','Primary','No','No','No','Open containers','High','175','27.60','5','Difficult',1),(538,'HH-538-7261',0.5000000,36.0000000,'Baringo','Mogotio','Female',22,'None','None','No','No','No','Open containers','High','175','27.60','5','Difficult',1),(539,'HH-539-1716',0.5000000,36.0000000,'Baringo','Mogotio','Male',12,'None','None','No','No','No','Open containers','High','175','27.60','5','Difficult',1),(540,'HH-540-6798',-0.4500000,36.2000000,'Nyandarua','Kinangop','Female',65,'Farmer','Primary','No','No','No','Covered containers','Low','60','18.10','3','Moderate',1),(541,'HH-541-8841',-0.4500000,36.2000000,'Nyandarua','Kinangop','Male',68,'Farmer','Primary','No','No','No','Covered containers','Low','60','18.10','3','Moderate',1),(542,'HH-542-3810',-0.4500000,36.2000000,'Nyandarua','Kinangop','Female',35,'Teacher','Tertiary','No','No','No','Covered containers','Low','60','18.10','3','Moderate',1),(543,'HH-543-2531',-1.2000000,37.8000000,'Kwale','Kinango','Male',50,'Farmer','Primary','Yes','No','Yes','Open containers','High','135','28.60','5','Difficult',1),(544,'HH-544-1223',-1.2000000,37.8000000,'Kwale','Kinango','Female',48,'Housewife','Primary','No','No','Yes','Open containers','High','135','28.60','5','Difficult',1),(545,'HH-545-8524',-1.2000000,37.8000000,'Kwale','Kinango','Male',20,'Student','Secondary','No','No','Yes','Open containers','High','135','28.60','5','Difficult',1),(546,'HH-546-8951',-1.2000000,37.8000000,'Kwale','Kinango','Female',18,'Student','Primary','No','No','Yes','Open containers','High','135','28.60','5','Difficult',1),(547,'HH-547-9183',-1.2000000,37.8000000,'Kwale','Kinango','Male',10,'None','None','No','No','Yes','Open containers','High','135','28.60','5','Difficult',1),(548,'HH-548-9062',0.5500000,34.7000000,'Vihiga','Sabatia','Female',40,'Businesswoman','Secondary','No','No','Yes','Covered containers','Moderate','105','23.10','4','Easy',1),(549,'HH-549-7760',0.5500000,34.7000000,'Vihiga','Sabatia','Male',42,'Carpenter','Secondary','No','No','Yes','Covered containers','Moderate','105','23.10','4','Easy',1),(550,'HH-550-1617',0.5500000,34.7000000,'Vihiga','Sabatia','Female',12,'Student','Primary','No','No','Yes','Covered containers','Moderate','105','23.10','4','Easy',1),(551,'HH-551-4804',0.5500000,34.7000000,'Vihiga','Sabatia','Male',7,'None','None','No','No','Yes','Covered containers','Moderate','105','23.10','4','Easy',1),(552,'HH-552-9172',-0.7000000,37.5000000,'Kwale','Msambweni','Male',55,'Fisher','Primary','No','Yes','Yes','Open containers','High','140','28.80','5','Difficult',1),(553,'HH-553-1447',-0.7000000,37.5000000,'Kwale','Msambweni','Female',53,'Trader','Primary','No','Yes','Yes','Open containers','High','140','28.80','5','Difficult',1),(554,'HH-554-9719',-0.7000000,37.5000000,'Kwale','Msambweni','Male',28,'Student','Secondary','No','No','Yes','Open containers','High','140','28.80','5','Difficult',1),(555,'HH-555-4254',-0.7000000,37.5000000,'Kwale','Msambweni','Female',22,'Student','Primary','No','No','Yes','Open containers','High','140','28.80','5','Difficult',1),(556,'HH-556-2112',-0.7000000,37.5000000,'Kwale','Msambweni','Male',12,'None','None','No','No','Yes','Open containers','High','140','28.80','5','Difficult',1),(557,'HH-557-7801',-0.0800000,34.9000000,'Nyamira','Nyamira North','Female',60,'Farmer','Primary','No','No','No','Covered containers','Low','70','20.60','4','Moderate',1),(558,'HH-558-2668',-0.0800000,34.9000000,'Nyamira','Nyamira North','Male',62,'Farmer','Primary','No','No','No','Covered containers','Low','70','20.60','4','Moderate',1),(559,'HH-559-9940',-0.0800000,34.9000000,'Nyamira','Nyamira North','Female',35,'Teacher','Tertiary','No','No','No','Covered containers','Low','70','20.60','4','Moderate',1),(560,'HH-560-1694',-0.0800000,34.9000000,'Nyamira','Nyamira North','Male',30,'Student','Secondary','No','No','No','Covered containers','Low','70','20.60','4','Moderate',1),(561,'HH-561-8649',-1.6000000,37.0000000,'Taita Taveta','Voi','Male',70,'Retired','Primary','No','No','No','No storage','Low','40','28.10','2','Easy',1),(562,'HH-562-8167',-1.6000000,37.0000000,'Taita Taveta','Voi','Female',68,'Housewife','Primary','No','No','No','No storage','Low','40','28.10','2','Easy',1),(563,'HH-563-4886',0.5000000,38.0000000,'Wajir','Wajir East','Female',50,'Pastoralist','None','Yes','No','No','Open containers','High','180','32.60','6','Difficult',1),(564,'HH-564-9929',0.5000000,38.0000000,'Wajir','Wajir East','Male',52,'Pastoralist','None','Yes','No','No','Open containers','High','180','32.60','6','Difficult',1),(565,'HH-565-4988',0.5000000,38.0000000,'Wajir','Wajir East','Female',25,'None','None','No','No','No','Open containers','High','180','32.60','6','Difficult',1),(566,'HH-566-5153',0.5000000,38.0000000,'Wajir','Wajir East','Male',22,'None','None','No','No','No','Open containers','High','180','32.60','6','Difficult',1),(567,'HH-567-0800',0.5000000,38.0000000,'Wajir','Wajir East','Female',12,'None','None','No','No','No','Open containers','High','180','32.60','6','Difficult',1),(568,'HH-568-8545',0.5000000,38.0000000,'Wajir','Wajir East','Male',7,'None','None','No','No','No','Open containers','High','180','32.60','6','Difficult',1),(569,'HH-569-0322',-0.2000000,35.5000000,'Nyamira','Manga','Male',45,'Farmer','Secondary','No','No','No','Covered containers','Moderate','95','21.60','5','Moderate',1),(570,'HH-570-5979',-0.2000000,35.5000000,'Nyamira','Manga','Female',43,'Housewife','Primary','No','No','No','Covered containers','Moderate','95','21.60','5','Moderate',1),(571,'HH-571-8927',-0.2000000,35.5000000,'Nyamira','Manga','Male',15,'Student','Primary','No','No','No','Covered containers','Moderate','95','21.60','5','Moderate',1),(572,'HH-572-6698',-0.2000000,35.5000000,'Nyamira','Manga','Female',12,'None','None','No','No','No','Covered containers','Moderate','95','21.60','5','Moderate',1),(573,'HH-573-6710',-0.2000000,35.5000000,'Nyamira','Manga','Male',7,'None','None','No','No','No','Covered containers','Moderate','95','21.60','5','Moderate',1),(574,'HH-574-3459',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',58,'Farmer','Primary','No','No','No','No storage','Low','50','20.10','4','Moderate',1),(575,'HH-575-7162',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',60,'Farmer','Primary','No','No','No','No storage','Low','50','20.10','4','Moderate',1),(576,'HH-576-5436',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',25,'Student','Tertiary','No','No','No','No storage','Low','50','20.10','4','Moderate',1),(577,'HH-577-5693',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',22,'Student','Secondary','No','No','No','No storage','Low','50','20.10','4','Moderate',1),(578,'HH-578-2159',0.0000000,34.5000000,'Kakamega','Lurambi','Male',50,'Teacher','Tertiary','No','No','Yes','Covered containers','Moderate','100','22.60','5','Easy',1),(579,'HH-579-3716',0.0000000,34.5000000,'Kakamega','Lurambi','Female',48,'Housewife','Secondary','No','No','Yes','Covered containers','Moderate','100','22.60','5','Easy',1),(580,'HH-580-2103',0.0000000,34.5000000,'Kakamega','Lurambi','Male',20,'Student','Secondary','No','No','Yes','Covered containers','Moderate','100','22.60','5','Easy',1),(581,'HH-581-9366',0.0000000,34.5000000,'Kakamega','Lurambi','Female',18,'Student','Primary','No','No','Yes','Covered containers','Moderate','100','22.60','5','Easy',1),(582,'HH-582-0524',0.0000000,34.5000000,'Kakamega','Lurambi','Male',10,'None','None','No','No','Yes','Covered containers','Moderate','100','22.60','5','Easy',1),(583,'HH-583-4522',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',65,'Farmer','Primary','No','No','No','Open containers','High','80','27.10','6','Difficult',1),(584,'HH-584-1036',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',68,'Farmer','Primary','No','No','No','Open containers','High','80','27.10','6','Difficult',1),(585,'HH-585-1618',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',35,'Trader','Secondary','No','No','No','Open containers','High','80','27.10','6','Difficult',1),(586,'HH-586-4982',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',33,'Farmer','Secondary','No','No','No','Open containers','High','80','27.10','6','Difficult',1),(587,'HH-587-0055',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',15,'Student','Primary','No','No','No','Open containers','High','80','27.10','6','Difficult',1),(588,'HH-588-5332',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',10,'None','None','No','No','No','Open containers','High','80','27.10','6','Difficult',1),(589,'HH-589-6492',0.2500000,37.0000000,'Nyeri','Nyeri Central','Male',50,'Civil Servant','Tertiary','No','No','No','Covered containers','Low','60','18.60','4','Easy',1),(590,'HH-590-6467',0.2500000,37.0000000,'Nyeri','Nyeri Central','Female',48,'Teacher','Tertiary','No','No','No','Covered containers','Low','60','18.60','4','Easy',1),(591,'HH-591-2857',0.2500000,37.0000000,'Nyeri','Nyeri Central','Male',18,'Student','Primary','No','No','No','Covered containers','Low','60','18.60','4','Easy',1),(592,'HH-592-4888',0.2500000,37.0000000,'Nyeri','Nyeri Central','Female',12,'Student','Primary','No','No','No','Covered containers','Low','60','18.60','4','Easy',1),(593,'HH-593-5866',0.1000000,34.2000000,'Bungoma','Kimilili','Female',60,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','110','22.60','5','Moderate',1),(594,'HH-594-4668',0.1000000,34.2000000,'Bungoma','Kimilili','Male',62,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','110','22.60','5','Moderate',1),(595,'HH-595-5740',0.1000000,34.2000000,'Bungoma','Kimilili','Female',25,'Student','Secondary','No','No','Yes','Covered containers','Moderate','110','22.60','5','Moderate',1),(596,'HH-596-4700',0.1000000,34.2000000,'Bungoma','Kimilili','Male',22,'Farmer','Secondary','No','No','Yes','Covered containers','Moderate','110','22.60','5','Moderate',1),(597,'HH-597-6279',0.1000000,34.2000000,'Bungoma','Kimilili','Female',15,'Student','Primary','No','No','Yes','Covered containers','Moderate','110','22.60','5','Moderate',1),(598,'HH-598-7296',0.0000000,37.0000000,'Kirinyaga','Mwea','Male',45,'Rice Farmer','Secondary','No','No','No','Covered containers','Moderate','70','23.60','4','Easy',1),(599,'HH-599-7642',0.0000000,37.0000000,'Kirinyaga','Mwea','Female',43,'Housewife','Primary','No','No','No','Covered containers','Moderate','70','23.60','4','Easy',1),(600,'HH-600-6322',0.0000000,37.0000000,'Kirinyaga','Mwea','Male',15,'Student','Primary','No','No','No','Covered containers','Moderate','70','23.60','4','Easy',1),(601,'HH-601-8686',0.0000000,37.0000000,'Kirinyaga','Mwea','Female',10,'None','None','No','No','No','Covered containers','Moderate','70','23.60','4','Easy',1),(602,'HH-602-4462',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',55,'Farmer','Primary','No','No','No','No storage','Low','65','19.60','5','Moderate',1),(603,'HH-603-6254',0.7000000,35.0000000,'Trans Nzoia','Kitale','Male',57,'Farmer','Primary','No','No','No','No storage','Low','65','19.60','5','Moderate',1),(604,'HH-604-7886',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',25,'Student','Secondary','No','No','No','No storage','Low','65','19.60','5','Moderate',1),(605,'HH-605-0667',0.7000000,35.0000000,'Trans Nzoia','Kitale','Male',22,'Farmer','Secondary','No','No','No','No storage','Low','65','19.60','5','Moderate',1),(606,'HH-606-9676',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',15,'Student','Primary','No','No','No','No storage','Low','65','19.60','5','Moderate',1),(607,'HH-607-6380',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',35,'Office Worker','Tertiary','No','No','No','Covered containers','Moderate','105','23.80','3','Easy',1),(608,'HH-608-2873',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Male',38,'Teacher','Tertiary','No','No','No','Covered containers','Moderate','105','23.80','3','Easy',1),(609,'HH-609-5225',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',5,'None','None','No','No','No','Covered containers','Moderate','105','23.80','3','Easy',1),(610,'HH-610-7508',0.5147000,35.2698000,'Nandi','Nandi Hills','Male',70,'Retired','Primary','No','No','No','No storage','Low','55','19.40','2','Moderate',1),(611,'HH-611-1863',0.5147000,35.2698000,'Nandi','Nandi Hills','Female',68,'Housewife','Primary','No','No','No','No storage','Low','55','19.40','2','Moderate',1),(612,'HH-612-6794',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Female',45,'Entrepreneur','Secondary','No','No','No','Covered containers','High','35','23.10','4','Easy',1),(613,'HH-613-8381',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',48,'IT Professional','Tertiary','No','No','No','Covered containers','High','35','23.10','4','Easy',1),(614,'HH-614-1522',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Female',15,'Student','Primary','No','No','No','Covered containers','High','35','23.10','4','Easy',1),(615,'HH-615-2468',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',10,'None','None','No','No','No','Covered containers','High','35','23.10','4','Easy',1),(616,'HH-616-7775',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',80,'Pastoralist','None','Yes','No','Yes','Open containers','High','150','27.60','5','Difficult',1),(617,'HH-617-1472',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',78,'Housewife','None','Yes','No','Yes','Open containers','High','150','27.60','5','Difficult',1),(618,'HH-618-4035',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',40,'Pastoralist','Primary','No','No','Yes','Open containers','High','150','27.60','5','Difficult',1),(619,'HH-619-5760',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',35,'None','Primary','No','No','Yes','Open containers','High','150','27.60','5','Difficult',1),(620,'HH-620-6696',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',12,'None','None','No','No','Yes','Open containers','High','150','27.60','5','Difficult',1),(621,'HH-621-6200',-0.5000000,39.8000000,'Kilifi','Kilifi North','Female',60,'Fisher','Primary','No','Yes','Yes','Open containers','High','120','28.50','4','Moderate',1),(622,'HH-622-0910',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',62,'Fisher','Primary','No','Yes','Yes','Open containers','High','120','28.50','4','Moderate',1),(623,'HH-623-5954',-0.5000000,39.8000000,'Kilifi','Kilifi North','Female',25,'Student','Secondary','No','No','Yes','Open containers','High','120','28.50','4','Moderate',1),(624,'HH-624-7040',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',20,'Student','Primary','No','No','Yes','Open containers','High','120','28.50','4','Moderate',1),(625,'HH-625-7338',0.2833000,34.7500000,'Bungoma','Bungoma Central','Male',80,'Retired','Primary','No','No','Yes','Covered containers','Moderate','85','21.40','2','Easy',1),(626,'HH-626-5570',0.2833000,34.7500000,'Bungoma','Bungoma Central','Female',78,'Housewife','Primary','No','No','Yes','Covered containers','Moderate','85','21.40','2','Easy',1),(627,'HH-627-5836',-0.7833000,35.0000000,'Narok','Narok North','Female',45,'Trader','Primary','No','No','No','No storage','Low','45','24.90','5','Difficult',1),(628,'HH-628-2472',-0.7833000,35.0000000,'Narok','Narok North','Male',48,'Trader','Primary','No','No','No','No storage','Low','45','24.90','5','Difficult',1),(629,'HH-629-4852',-0.7833000,35.0000000,'Narok','Narok North','Female',15,'Student','Primary','No','No','No','No storage','Low','45','24.90','5','Difficult',1),(630,'HH-630-6845',-0.7833000,35.0000000,'Narok','Narok North','Male',12,'None','None','No','No','No','No storage','Low','45','24.90','5','Difficult',1),(631,'HH-631-9668',-0.7833000,35.0000000,'Narok','Narok North','Female',7,'None','None','No','No','No','No storage','Low','45','24.90','5','Difficult',1),(632,'HH-632-7808',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',65,'Farmer','Secondary','No','No','No','Covered containers','Moderate','65','20.40','4','Easy',1),(633,'HH-633-0034',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',63,'Housewife','Primary','No','No','No','Covered containers','Moderate','65','20.40','4','Easy',1),(634,'HH-634-6749',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',25,'Student','Tertiary','No','No','No','Covered containers','Moderate','65','20.40','4','Easy',1),(635,'HH-635-3640',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',20,'Student','Secondary','No','No','No','Covered containers','Moderate','65','20.40','4','Easy',1),(636,'HH-636-7957',2.8000000,36.0000000,'Turkana','Turkana North','Male',85,'Pastoralist','None','Yes','No','No','Open containers','High','170','29.80','6','Difficult',1),(637,'HH-637-8864',2.8000000,36.0000000,'Turkana','Turkana North','Female',82,'Housewife','None','Yes','No','No','Open containers','High','170','29.80','6','Difficult',1),(638,'HH-638-0449',2.8000000,36.0000000,'Turkana','Turkana North','Male',50,'Pastoralist','None','Yes','No','No','Open containers','High','170','29.80','6','Difficult',1),(639,'HH-639-5652',2.8000000,36.0000000,'Turkana','Turkana North','Female',48,'Housewife','None','No','No','No','Open containers','High','170','29.80','6','Difficult',1),(640,'HH-640-6915',2.8000000,36.0000000,'Turkana','Turkana North','Male',18,'Student','Primary','No','No','No','Open containers','High','170','29.80','6','Difficult',1),(641,'HH-641-7621',2.8000000,36.0000000,'Turkana','Turkana North','Female',12,'None','None','No','No','No','Open containers','High','170','29.80','6','Difficult',1),(642,'HH-642-7357',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',40,'Shopkeeper','Secondary','No','No','No','Covered containers','Moderate','25','25.40','3','Easy',1),(643,'HH-643-3925',-0.6000000,37.0000000,'Machakos','Machakos Town','Male',42,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','25','25.40','3','Easy',1),(644,'HH-644-7556',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',10,'None','None','No','No','No','Covered containers','Moderate','25','25.40','3','Easy',1),(645,'HH-645-6003',0.0000000,37.9000000,'Meru','Imenti South','Male',70,'Farmer','Primary','No','No','Yes','Open containers','Moderate','75','22.40','6','Moderate',1),(646,'HH-646-7346',0.0000000,37.9000000,'Meru','Imenti South','Female',65,'Housewife','Primary','No','No','Yes','Open containers','Moderate','75','22.40','6','Moderate',1),(647,'HH-647-8725',0.0000000,37.9000000,'Meru','Imenti South','Male',40,'Farmer','Secondary','No','No','Yes','Open containers','Moderate','75','22.40','6','Moderate',1),(648,'HH-648-1587',0.0000000,37.9000000,'Meru','Imenti South','Female',35,'Student','Secondary','No','No','Yes','Open containers','Moderate','75','22.40','6','Moderate',1),(649,'HH-649-1759',0.0000000,37.9000000,'Meru','Imenti South','Male',22,'Student','Primary','No','No','Yes','Open containers','Moderate','75','22.40','6','Moderate',1),(650,'HH-650-4035',0.0000000,37.9000000,'Meru','Imenti South','Female',15,'Student','Primary','No','No','Yes','Open containers','Moderate','75','22.40','6','Moderate',1),(651,'HH-651-4899',-2.1000000,40.0000000,'Lamu','Lamu West','Female',55,'Fisher','Primary','No','Yes','Yes','Open containers','High','130','28.10','5','Difficult',1),(652,'HH-652-2392',-2.1000000,40.0000000,'Lamu','Lamu West','Male',57,'Fisher','Primary','No','Yes','Yes','Open containers','High','130','28.10','5','Difficult',1),(653,'HH-653-7261',-2.1000000,40.0000000,'Lamu','Lamu West','Female',28,'Student','Secondary','No','No','Yes','Open containers','High','130','28.10','5','Difficult',1),(654,'HH-654-9131',-2.1000000,40.0000000,'Lamu','Lamu West','Male',20,'Student','Primary','No','No','Yes','Open containers','High','130','28.10','5','Difficult',1),(655,'HH-655-3872',-2.1000000,40.0000000,'Lamu','Lamu West','Female',12,'None','None','No','No','Yes','Open containers','High','130','28.10','5','Difficult',1),(656,'HH-656-1967',-0.6900000,34.2500000,'Siaya','Bondo','Male',55,'Farmer','Secondary','Yes','No','Yes','Covered containers','Moderate','115','24.40','7','Moderate',1),(657,'HH-657-8218',-0.6900000,34.2500000,'Siaya','Bondo','Female',53,'Housewife','Primary','No','No','Yes','Covered containers','Moderate','115','24.40','7','Moderate',1),(658,'HH-658-5193',-0.6900000,34.2500000,'Siaya','Bondo','Male',25,'Student','Secondary','No','No','Yes','Covered containers','Moderate','115','24.40','7','Moderate',1),(659,'HH-659-1308',-0.6900000,34.2500000,'Siaya','Bondo','Female',22,'Student','Primary','Yes','No','Yes','Covered containers','Moderate','115','24.40','7','Moderate',1),(660,'HH-660-0964',-0.6900000,34.2500000,'Siaya','Bondo','Male',15,'Student','Primary','No','No','Yes','Covered containers','Moderate','115','24.40','7','Moderate',1),(661,'HH-661-0894',-0.6900000,34.2500000,'Siaya','Bondo','Female',12,'None','None','No','No','Yes','Covered containers','Moderate','115','24.40','7','Moderate',1),(662,'HH-662-1578',-0.6900000,34.2500000,'Siaya','Bondo','Male',7,'None','None','No','No','Yes','Covered containers','Moderate','115','24.40','7','Moderate',1),(663,'HH-663-5211',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',65,'Farmer','Primary','No','No','No','No storage','Low','50','18.80','3','Moderate',1),(664,'HH-664-1323',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Male',67,'Farmer','Primary','No','No','No','No storage','Low','50','18.80','3','Moderate',1),(665,'HH-665-0979',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',28,'Student','Tertiary','No','No','No','No storage','Low','50','18.80','3','Moderate',1),(666,'HH-666-0929',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',55,'Pastoralist','None','Yes','No','No','Open containers','High','140','26.40','6','Difficult',1),(667,'HH-667-1708',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',53,'Housewife','None','Yes','No','No','Open containers','High','140','26.40','6','Difficult',1),(668,'HH-668-5752',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',25,'Student','Primary','No','No','No','Open containers','High','140','26.40','6','Difficult',1),(669,'HH-669-3636',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',22,'None','None','No','No','No','Open containers','High','140','26.40','6','Difficult',1),(670,'HH-670-0925',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',15,'None','None','No','No','No','Open containers','High','140','26.40','6','Difficult',1),(671,'HH-671-3720',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',10,'None','None','No','No','No','Open containers','High','140','26.40','6','Difficult',1),(672,'HH-672-5822',-0.1000000,37.5000000,'Embu','Embu West','Female',48,'Trader','Secondary','No','No','No','Covered containers','Moderate','60','21.90','4','Easy',1),(673,'HH-673-7951',-0.1000000,37.5000000,'Embu','Embu West','Male',50,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','60','21.90','4','Easy',1),(674,'HH-674-2291',-0.1000000,37.5000000,'Embu','Embu West','Female',18,'Student','Primary','No','No','No','Covered containers','Moderate','60','21.90','4','Easy',1),(675,'HH-675-7604',-0.1000000,37.5000000,'Embu','Embu West','Male',12,'None','None','No','No','No','Covered containers','Moderate','60','21.90','4','Easy',1),(676,'HH-676-1146',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',60,'Farmer','Primary','No','No','Yes','Open containers','High','95','26.40','5','Moderate',1),(677,'HH-677-2918',-0.2000000,38.0000000,'Kitui','Kitui Central','Female',58,'Housewife','Primary','No','No','Yes','Open containers','High','95','26.40','5','Moderate',1),(678,'HH-678-1154',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',35,'Student','Secondary','No','No','Yes','Open containers','High','95','26.40','5','Moderate',1),(679,'HH-679-7017',-0.2000000,38.0000000,'Kitui','Kitui Central','Female',30,'Student','Primary','No','No','Yes','Open containers','High','95','26.40','5','Moderate',1),(680,'HH-680-1621',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',15,'None','None','No','No','Yes','Open containers','High','95','26.40','5','Moderate',1),(681,'HH-681-7056',0.7500000,34.5000000,'Kakamega','Butere','Female',70,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','120','23.40','4','Easy',1),(682,'HH-682-0419',0.7500000,34.5000000,'Kakamega','Butere','Male',72,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','120','23.40','4','Easy',1),(683,'HH-683-0927',0.7500000,34.5000000,'Kakamega','Butere','Female',40,'Teacher','Tertiary','No','No','Yes','Covered containers','Moderate','120','23.40','4','Easy',1),(684,'HH-684-3380',0.7500000,34.5000000,'Kakamega','Butere','Male',38,'Farmer','Secondary','No','No','Yes','Covered containers','Moderate','120','23.40','4','Easy',1),(685,'HH-685-4118',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Male',45,'Salesperson','Secondary','No','No','No','No storage','Low','40','20.90','3','Easy',1),(686,'HH-686-0450',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Female',43,'Hairdresser','Secondary','No','No','No','No storage','Low','40','20.90','3','Easy',1),(687,'HH-687-9896',-0.3000000,36.0000000,'Nakuru','Nakuru Town East','Female',12,'None','None','No','No','No','No storage','Low','40','20.90','3','Easy',1),(688,'HH-688-8132',1.5000000,37.5000000,'Marsabit','Moyale','Female',75,'Pastoralist','None','Yes','No','No','Open containers','High','160','30.40','7','Difficult',1),(689,'HH-689-0971',1.5000000,37.5000000,'Marsabit','Moyale','Male',78,'Pastoralist','None','Yes','No','No','Open containers','High','160','30.40','7','Difficult',1),(690,'HH-690-0458',1.5000000,37.5000000,'Marsabit','Moyale','Female',45,'Housewife','None','No','No','No','Open containers','High','160','30.40','7','Difficult',1),(691,'HH-691-9380',1.5000000,37.5000000,'Marsabit','Moyale','Male',43,'Pastoralist','None','Yes','No','No','Open containers','High','160','30.40','7','Difficult',1),(692,'HH-692-5525',1.5000000,37.5000000,'Marsabit','Moyale','Female',22,'None','Primary','No','No','No','Open containers','High','160','30.40','7','Difficult',1),(693,'HH-693-9484',1.5000000,37.5000000,'Marsabit','Moyale','Male',18,'None','None','No','No','No','Open containers','High','160','30.40','7','Difficult',1),(694,'HH-694-0849',1.5000000,37.5000000,'Marsabit','Moyale','Female',12,'None','None','No','No','No','Open containers','High','160','30.40','7','Difficult',1),(695,'HH-695-5790',-0.0500000,35.3000000,'Kericho','Kericho East','Male',55,'Farmer','Secondary','No','No','No','Covered containers','Moderate','80','20.10','5','Moderate',1),(696,'HH-696-6407',-0.0500000,35.3000000,'Kericho','Kericho East','Female',53,'Housewife','Primary','No','No','No','Covered containers','Moderate','80','20.10','5','Moderate',1),(697,'HH-697-4663',-0.0500000,35.3000000,'Kericho','Kericho East','Male',22,'Student','Secondary','No','No','No','Covered containers','Moderate','80','20.10','5','Moderate',1),(698,'HH-698-4093',-0.0500000,35.3000000,'Kericho','Kericho East','Female',18,'Student','Primary','No','No','No','Covered containers','Moderate','80','20.10','5','Moderate',1),(699,'HH-699-6478',-0.0500000,35.3000000,'Kericho','Kericho East','Male',12,'None','None','No','No','No','Covered containers','Moderate','80','20.10','5','Moderate',1),(700,'HH-700-0114',0.6000000,39.0000000,'Garissa','Fafi','Female',65,'Trader','None','Yes','No','No','Open containers','High','180','31.40','6','Difficult',1),(701,'HH-701-1133',0.6000000,39.0000000,'Garissa','Fafi','Male',70,'Trader','None','Yes','No','No','Open containers','High','180','31.40','6','Difficult',1),(702,'HH-702-5326',0.6000000,39.0000000,'Garissa','Fafi','Female',40,'None','Primary','No','No','No','Open containers','High','180','31.40','6','Difficult',1),(703,'HH-703-3229',0.6000000,39.0000000,'Garissa','Fafi','Male',35,'None','Primary','Yes','No','No','Open containers','High','180','31.40','6','Difficult',1),(704,'HH-704-0168',0.6000000,39.0000000,'Garissa','Fafi','Female',20,'None','None','No','No','No','Open containers','High','180','31.40','6','Difficult',1),(705,'HH-705-1153',0.6000000,39.0000000,'Garissa','Fafi','Male',15,'None','None','No','No','No','Open containers','High','180','31.40','6','Difficult',1),(706,'HH-706-5262',-1.0000000,36.5000000,'Kiambu','Limuru','Male',50,'Driver','Secondary','No','No','No','Covered containers','Low','45','19.40','4','Easy',1),(707,'HH-707-2850',-1.0000000,36.5000000,'Kiambu','Limuru','Female',48,'Hairdresser','Secondary','No','No','No','Covered containers','Low','45','19.40','4','Easy',1),(708,'HH-708-8464',-1.0000000,36.5000000,'Kiambu','Limuru','Male',15,'Student','Primary','No','No','No','Covered containers','Low','45','19.40','4','Easy',1),(709,'HH-709-3772',-1.0000000,36.5000000,'Kiambu','Limuru','Female',10,'None','None','No','No','No','Covered containers','Low','45','19.40','4','Easy',1),(710,'HH-710-3467',0.0000000,34.0000000,'Busia','Samia','Female',65,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','115','24.60','6','Moderate',1),(711,'HH-711-6022',0.0000000,34.0000000,'Busia','Samia','Male',68,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','115','24.60','6','Moderate',1),(712,'HH-712-9710',0.0000000,34.0000000,'Busia','Samia','Female',30,'Student','Secondary','No','No','Yes','Covered containers','Moderate','115','24.60','6','Moderate',1),(713,'HH-713-0483',0.0000000,34.0000000,'Busia','Samia','Male',28,'Farmer','Secondary','Yes','No','Yes','Covered containers','Moderate','115','24.60','6','Moderate',1),(714,'HH-714-3286',0.0000000,34.0000000,'Busia','Samia','Female',18,'Student','Primary','No','No','Yes','Covered containers','Moderate','115','24.60','6','Moderate',1),(715,'HH-715-4982',0.0000000,34.0000000,'Busia','Samia','Male',12,'None','None','No','No','Yes','Covered containers','Moderate','115','24.60','6','Moderate',1),(716,'HH-716-5053',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',80,'Pastoralist','None','Yes','No','No','Open containers','High','155','28.40','5','Difficult',1),(717,'HH-717-0317',1.0000000,35.0000000,'West Pokot','Pokot Central','Female',78,'Housewife','None','Yes','No','No','Open containers','High','155','28.40','5','Difficult',1),(718,'HH-718-6429',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',45,'Pastoralist','None','No','No','No','Open containers','High','155','28.40','5','Difficult',1),(719,'HH-719-1194',1.0000000,35.0000000,'West Pokot','Pokot Central','Female',43,'Housewife','None','No','No','No','Open containers','High','155','28.40','5','Difficult',1),(720,'HH-720-6681',1.0000000,35.0000000,'West Pokot','Pokot Central','Male',18,'None','None','No','No','No','Open containers','High','155','28.40','5','Difficult',1),(721,'HH-721-9826',-0.5000000,37.0000000,'Makueni','Makueni','Female',52,'Farmer','Primary','No','No','Yes','Covered containers','Moderate','70','25.80','5','Moderate',1),(722,'HH-722-9088',-0.5000000,37.0000000,'Makueni','Makueni','Male',55,'Farmer','Primary','No','No','Yes','Covered containers','Moderate','70','25.80','5','Moderate',1),(723,'HH-723-5961',-0.5000000,37.0000000,'Makueni','Makueni','Female',22,'Student','Secondary','No','No','Yes','Covered containers','Moderate','70','25.80','5','Moderate',1),(724,'HH-724-2540',-0.5000000,37.0000000,'Makueni','Makueni','Male',20,'Student','Primary','No','No','Yes','Covered containers','Moderate','70','25.80','5','Moderate',1),(725,'HH-725-4821',-0.5000000,37.0000000,'Makueni','Makueni','Female',12,'None','None','No','No','Yes','Covered containers','Moderate','70','25.80','5','Moderate',1),(726,'HH-726-6484',-1.5000000,38.0000000,'Tana River','Galole','Male',70,'Fisher','Primary','Yes','No','Yes','Open containers','High','140','28.90','6','Difficult',1),(727,'HH-727-7958',-1.5000000,38.0000000,'Tana River','Galole','Female',68,'Housewife','Primary','Yes','No','Yes','Open containers','High','140','28.90','6','Difficult',1),(728,'HH-728-0337',-1.5000000,38.0000000,'Tana River','Galole','Male',40,'Fisher','Secondary','No','No','Yes','Open containers','High','140','28.90','6','Difficult',1),(729,'HH-729-7813',-1.5000000,38.0000000,'Tana River','Galole','Female',38,'None','Primary','No','No','Yes','Open containers','High','140','28.90','6','Difficult',1),(730,'HH-730-8054',-1.5000000,38.0000000,'Tana River','Galole','Male',18,'Student','None','No','No','Yes','Open containers','High','140','28.90','6','Difficult',1),(731,'HH-731-6833',-1.5000000,38.0000000,'Tana River','Galole','Female',12,'None','None','No','No','Yes','Open containers','High','140','28.90','6','Difficult',1),(732,'HH-732-0001',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Female',45,'Trader','Secondary','Yes','No','Yes','Covered containers','Moderate','110','25.10','4','Easy',1),(733,'HH-733-9507',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Male',48,'Fisher','Secondary','Yes','No','Yes','Covered containers','Moderate','110','25.10','4','Easy',1),(734,'HH-734-7532',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Female',15,'Student','Primary','No','No','Yes','Covered containers','Moderate','110','25.10','4','Easy',1),(735,'HH-735-9139',-0.2500000,34.7000000,'Homa Bay','Homa Bay Town','Male',10,'None','None','No','No','Yes','Covered containers','Moderate','110','25.10','4','Easy',1),(736,'HH-736-3099',0.5000000,36.0000000,'Baringo','Mogotio','Male',60,'Pastoralist','None','Yes','No','No','Open containers','High','165','27.40','5','Difficult',1),(737,'HH-737-8078',0.5000000,36.0000000,'Baringo','Mogotio','Female',58,'Housewife','None','Yes','No','No','Open containers','High','165','27.40','5','Difficult',1),(738,'HH-738-1093',0.5000000,36.0000000,'Baringo','Mogotio','Male',30,'Pastoralist','Primary','No','No','No','Open containers','High','165','27.40','5','Difficult',1),(739,'HH-739-1233',0.5000000,36.0000000,'Baringo','Mogotio','Female',25,'None','None','No','No','No','Open containers','High','165','27.40','5','Difficult',1),(740,'HH-740-2886',0.5000000,36.0000000,'Baringo','Mogotio','Male',15,'None','None','No','No','No','Open containers','High','165','27.40','5','Difficult',1),(741,'HH-741-0730',-0.4500000,36.2000000,'Nyandarua','Kinangop','Female',70,'Farmer','Primary','No','No','No','Covered containers','Low','55','17.90','3','Moderate',1),(742,'HH-742-4994',-0.4500000,36.2000000,'Nyandarua','Kinangop','Male',72,'Farmer','Primary','No','No','No','Covered containers','Low','55','17.90','3','Moderate',1),(743,'HH-743-2781',-0.4500000,36.2000000,'Nyandarua','Kinangop','Female',40,'Teacher','Tertiary','No','No','No','Covered containers','Low','55','17.90','3','Moderate',1),(744,'HH-744-8922',-1.2000000,37.8000000,'Kwale','Kinango','Male',55,'Farmer','Primary','Yes','No','Yes','Open containers','High','125','28.40','5','Difficult',1),(745,'HH-745-6268',-1.2000000,37.8000000,'Kwale','Kinango','Female',53,'Housewife','Primary','No','No','Yes','Open containers','High','125','28.40','5','Difficult',1),(746,'HH-746-4575',-1.2000000,37.8000000,'Kwale','Kinango','Male',22,'Student','Secondary','No','No','Yes','Open containers','High','125','28.40','5','Difficult',1),(747,'HH-747-4072',-1.2000000,37.8000000,'Kwale','Kinango','Female',20,'Student','Primary','No','No','Yes','Open containers','High','125','28.40','5','Difficult',1),(748,'HH-748-6636',-1.2000000,37.8000000,'Kwale','Kinango','Male',12,'None','None','No','No','Yes','Open containers','High','125','28.40','5','Difficult',1),(749,'HH-749-0964',0.5500000,34.7000000,'Vihiga','Sabatia','Female',45,'Businesswoman','Secondary','No','No','Yes','Covered containers','Moderate','100','22.90','4','Easy',1),(750,'HH-750-4914',0.5500000,34.7000000,'Vihiga','Sabatia','Male',48,'Carpenter','Secondary','No','No','Yes','Covered containers','Moderate','100','22.90','4','Easy',1),(751,'HH-751-1676',0.5500000,34.7000000,'Vihiga','Sabatia','Female',15,'Student','Primary','No','No','Yes','Covered containers','Moderate','100','22.90','4','Easy',1),(752,'HH-752-3639',0.5500000,34.7000000,'Vihiga','Sabatia','Male',10,'None','None','No','No','Yes','Covered containers','Moderate','100','22.90','4','Easy',1),(753,'HH-753-3167',-0.7000000,37.5000000,'Kwale','Msambweni','Male',60,'Fisher','Primary','No','Yes','Yes','Open containers','High','130','28.60','5','Difficult',1),(754,'HH-754-4920',-0.7000000,37.5000000,'Kwale','Msambweni','Female',58,'Trader','Primary','No','Yes','Yes','Open containers','High','130','28.60','5','Difficult',1),(755,'HH-755-5097',-0.7000000,37.5000000,'Kwale','Msambweni','Male',30,'Student','Secondary','No','No','Yes','Open containers','High','130','28.60','5','Difficult',1),(756,'HH-756-0726',-0.7000000,37.5000000,'Kwale','Msambweni','Female',25,'Student','Primary','No','No','Yes','Open containers','High','130','28.60','5','Difficult',1),(757,'HH-757-8338',-0.7000000,37.5000000,'Kwale','Msambweni','Male',15,'None','None','No','No','Yes','Open containers','High','130','28.60','5','Difficult',1),(758,'HH-758-9514',-0.0800000,34.9000000,'Nyamira','Nyamira North','Female',65,'Farmer','Primary','No','No','No','Covered containers','Low','65','20.40','4','Moderate',1),(759,'HH-759-2558',-0.0800000,34.9000000,'Nyamira','Nyamira North','Male',68,'Farmer','Primary','No','No','No','Covered containers','Low','65','20.40','4','Moderate',1),(760,'HH-760-4248',-0.0800000,34.9000000,'Nyamira','Nyamira North','Female',40,'Teacher','Tertiary','No','No','No','Covered containers','Low','65','20.40','4','Moderate',1),(761,'HH-761-3567',-0.0800000,34.9000000,'Nyamira','Nyamira North','Male',35,'Student','Secondary','No','No','No','Covered containers','Low','65','20.40','4','Moderate',1),(762,'HH-762-5091',-1.6000000,37.0000000,'Taita Taveta','Voi','Male',75,'Retired','Primary','No','No','No','No storage','Low','35','27.90','2','Easy',1),(763,'HH-763-4755',-1.6000000,37.0000000,'Taita Taveta','Voi','Female',73,'Housewife','Primary','No','No','No','No storage','Low','35','27.90','2','Easy',1),(764,'HH-764-8503',0.5000000,38.0000000,'Wajir','Wajir East','Female',55,'Pastoralist','None','Yes','No','No','Open containers','High','170','32.40','6','Difficult',1),(765,'HH-765-8251',0.5000000,38.0000000,'Wajir','Wajir East','Male',58,'Pastoralist','None','Yes','No','No','Open containers','High','170','32.40','6','Difficult',1),(766,'HH-766-5747',0.5000000,38.0000000,'Wajir','Wajir East','Female',30,'None','None','No','No','No','Open containers','High','170','32.40','6','Difficult',1),(767,'HH-767-3981',0.5000000,38.0000000,'Wajir','Wajir East','Male',28,'None','None','No','No','No','Open containers','High','170','32.40','6','Difficult',1),(768,'HH-768-2665',0.5000000,38.0000000,'Wajir','Wajir East','Female',15,'None','None','No','No','No','Open containers','High','170','32.40','6','Difficult',1),(769,'HH-769-1381',0.5000000,38.0000000,'Wajir','Wajir East','Male',10,'None','None','No','No','No','Open containers','High','170','32.40','6','Difficult',1),(770,'HH-770-8912',-0.2000000,35.5000000,'Nyamira','Manga','Male',50,'Farmer','Secondary','No','No','No','Covered containers','Moderate','90','21.40','5','Moderate',1),(771,'HH-771-0416',-0.2000000,35.5000000,'Nyamira','Manga','Female',48,'Housewife','Primary','No','No','No','Covered containers','Moderate','90','21.40','5','Moderate',1),(772,'HH-772-5346',-0.2000000,35.5000000,'Nyamira','Manga','Male',18,'Student','Primary','No','No','No','Covered containers','Moderate','90','21.40','5','Moderate',1),(773,'HH-773-5480',-0.2000000,35.5000000,'Nyamira','Manga','Female',15,'None','None','No','No','No','Covered containers','Moderate','90','21.40','5','Moderate',1),(774,'HH-774-1366',-0.2000000,35.5000000,'Nyamira','Manga','Male',10,'None','None','No','No','No','Covered containers','Moderate','90','21.40','5','Moderate',1),(775,'HH-775-0387',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',63,'Farmer','Primary','No','No','No','No storage','Low','45','19.90','4','Moderate',1),(776,'HH-776-7840',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',65,'Farmer','Primary','No','No','No','No storage','Low','45','19.90','4','Moderate',1),(777,'HH-777-8039',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',28,'Student','Tertiary','No','No','No','No storage','Low','45','19.90','4','Moderate',1),(778,'HH-778-6676',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',25,'Student','Secondary','No','No','No','No storage','Low','45','19.90','4','Moderate',1),(779,'HH-779-9263',0.0000000,34.5000000,'Kakamega','Lurambi','Male',55,'Teacher','Tertiary','No','No','Yes','Covered containers','Moderate','95','22.40','5','Easy',1),(780,'HH-780-6286',0.0000000,34.5000000,'Kakamega','Lurambi','Female',53,'Housewife','Secondary','No','No','Yes','Covered containers','Moderate','95','22.40','5','Easy',1),(781,'HH-781-3644',0.0000000,34.5000000,'Kakamega','Lurambi','Male',22,'Student','Secondary','No','No','Yes','Covered containers','Moderate','95','22.40','5','Easy',1),(782,'HH-782-9363',0.0000000,34.5000000,'Kakamega','Lurambi','Female',20,'Student','Primary','No','No','Yes','Covered containers','Moderate','95','22.40','5','Easy',1),(783,'HH-783-5882',0.0000000,34.5000000,'Kakamega','Lurambi','Male',12,'None','None','No','No','Yes','Covered containers','Moderate','95','22.40','5','Easy',1),(784,'HH-784-1320',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',70,'Farmer','Primary','No','No','No','Open containers','High','75','26.90','6','Difficult',1),(785,'HH-785-8958',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',72,'Farmer','Primary','No','No','No','Open containers','High','75','26.90','6','Difficult',1),(786,'HH-786-0828',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',40,'Trader','Secondary','No','No','No','Open containers','High','75','26.90','6','Difficult',1),(787,'HH-787-7268',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',38,'Farmer','Secondary','No','No','No','Open containers','High','75','26.90','6','Difficult',1),(788,'HH-788-3854',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',18,'Student','Primary','No','No','No','Open containers','High','75','26.90','6','Difficult',1),(789,'HH-789-7467',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',12,'None','None','No','No','No','Open containers','High','75','26.90','6','Difficult',1),(790,'HH-790-5774',0.2500000,37.0000000,'Nyeri','Nyeri Central','Male',55,'Civil Servant','Tertiary','No','No','No','Covered containers','Low','55','18.40','4','Easy',1),(791,'HH-791-6468',0.2500000,37.0000000,'Nyeri','Nyeri Central','Female',53,'Teacher','Tertiary','No','No','No','Covered containers','Low','55','18.40','4','Easy',1),(792,'HH-792-5017',0.2500000,37.0000000,'Nyeri','Nyeri Central','Male',20,'Student','Primary','No','No','No','Covered containers','Low','55','18.40','4','Easy',1),(793,'HH-793-5685',0.2500000,37.0000000,'Nyeri','Nyeri Central','Female',15,'Student','Primary','No','No','No','Covered containers','Low','55','18.40','4','Easy',1),(794,'HH-794-3375',0.1000000,34.2000000,'Bungoma','Kimilili','Female',65,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','105','22.40','5','Moderate',1),(795,'HH-795-9820',0.1000000,34.2000000,'Bungoma','Kimilili','Male',67,'Farmer','Primary','Yes','No','Yes','Covered containers','Moderate','105','22.40','5','Moderate',1),(796,'HH-796-8973',0.1000000,34.2000000,'Bungoma','Kimilili','Female',28,'Student','Secondary','No','No','Yes','Covered containers','Moderate','105','22.40','5','Moderate',1),(797,'HH-797-5408',0.1000000,34.2000000,'Bungoma','Kimilili','Male',25,'Farmer','Secondary','No','No','Yes','Covered containers','Moderate','105','22.40','5','Moderate',1),(798,'HH-798-0120',0.1000000,34.2000000,'Bungoma','Kimilili','Female',18,'Student','Primary','No','No','Yes','Covered containers','Moderate','105','22.40','5','Moderate',1),(799,'HH-799-4379',0.0000000,37.0000000,'Kirinyaga','Mwea','Male',50,'Rice Farmer','Secondary','No','No','No','Covered containers','Moderate','65','23.40','4','Easy',1),(800,'HH-800-1535',0.0000000,37.0000000,'Kirinyaga','Mwea','Female',48,'Housewife','Primary','No','No','No','Covered containers','Moderate','65','23.40','4','Easy',1),(801,'HH-801-4536',0.0000000,37.0000000,'Kirinyaga','Mwea','Male',18,'Student','Primary','No','No','No','Covered containers','Moderate','65','23.40','4','Easy',1),(802,'HH-802-8076',0.0000000,37.0000000,'Kirinyaga','Mwea','Female',12,'None','None','No','No','No','Covered containers','Moderate','65','23.40','4','Easy',1),(803,'HH-803-6772',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',60,'Farmer','Primary','No','No','No','No storage','Low','60','19.40','5','Moderate',1),(804,'HH-804-9635',0.7000000,35.0000000,'Trans Nzoia','Kitale','Male',62,'Farmer','Primary','No','No','No','No storage','Low','60','19.40','5','Moderate',1),(805,'HH-805-7857',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',28,'Student','Secondary','No','No','No','No storage','Low','60','19.40','5','Moderate',1),(806,'HH-806-0379',0.7000000,35.0000000,'Trans Nzoia','Kitale','Male',25,'Farmer','Secondary','No','No','No','No storage','Low','60','19.40','5','Moderate',1),(807,'HH-807-8328',0.7000000,35.0000000,'Trans Nzoia','Kitale','Female',18,'Student','Primary','No','No','No','No storage','Low','60','19.40','5','Moderate',1),(808,'HH-808-0502',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',40,'Office Worker','Tertiary','No','No','No','Covered containers','Moderate','100','23.60','3','Easy',1),(809,'HH-809-7528',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Male',42,'Teacher','Tertiary','No','No','No','Covered containers','Moderate','100','23.60','3','Easy',1),(810,'HH-810-6134',-0.0245000,34.7678000,'Kisumu','Kisumu Central','Female',7,'None','None','No','No','No','Covered containers','Moderate','100','23.60','3','Easy',1),(811,'HH-811-8086',0.5147000,35.2698000,'Nandi','Nandi Hills','Male',75,'Retired','Primary','No','No','No','No storage','Low','50','19.20','2','Moderate',1),(812,'HH-812-2029',0.5147000,35.2698000,'Nandi','Nandi Hills','Female',73,'Housewife','Primary','No','No','No','No storage','Low','50','19.20','2','Moderate',1),(813,'HH-813-5887',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Female',50,'Entrepreneur','Secondary','No','No','No','Covered containers','High','30','22.90','4','Easy',1),(814,'HH-814-3347',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',52,'IT Professional','Tertiary','No','No','No','Covered containers','High','30','22.90','4','Easy',1),(815,'HH-815-9075',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Female',18,'Student','Primary','No','No','No','Covered containers','High','30','22.90','4','Easy',1),(816,'HH-816-5334',-1.2921000,36.8219000,'Nairobi','Dagoretti North','Male',12,'None','None','No','No','No','Covered containers','High','30','22.90','4','Easy',1),(817,'HH-817-9446',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',85,'Pastoralist','None','Yes','No','Yes','Open containers','High','140','27.40','5','Difficult',1),(818,'HH-818-1228',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',83,'Housewife','None','Yes','No','Yes','Open containers','High','140','27.40','5','Difficult',1),(819,'HH-819-7804',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',45,'Pastoralist','Primary','No','No','Yes','Open containers','High','140','27.40','5','Difficult',1),(820,'HH-820-5337',1.0456000,37.0000000,'Isiolo','Isiolo Central','Female',40,'None','Primary','No','No','Yes','Open containers','High','140','27.40','5','Difficult',1),(821,'HH-821-3275',1.0456000,37.0000000,'Isiolo','Isiolo Central','Male',15,'None','None','No','No','Yes','Open containers','High','140','27.40','5','Difficult',1),(822,'HH-822-0361',-0.5000000,39.8000000,'Kilifi','Kilifi North','Female',65,'Fisher','Primary','No','Yes','Yes','Open containers','High','110','28.30','4','Moderate',1),(823,'HH-823-1984',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',67,'Fisher','Primary','No','Yes','Yes','Open containers','High','110','28.30','4','Moderate',1),(824,'HH-824-8834',-0.5000000,39.8000000,'Kilifi','Kilifi North','Female',28,'Student','Secondary','No','No','Yes','Open containers','High','110','28.30','4','Moderate',1),(825,'HH-825-8220',-0.5000000,39.8000000,'Kilifi','Kilifi North','Male',22,'Student','Primary','No','No','Yes','Open containers','High','110','28.30','4','Moderate',1),(826,'HH-826-4600',0.2833000,34.7500000,'Bungoma','Bungoma Central','Male',85,'Retired','Primary','No','No','Yes','Covered containers','Moderate','80','21.20','2','Easy',1),(827,'HH-827-8338',0.2833000,34.7500000,'Bungoma','Bungoma Central','Female',83,'Housewife','Primary','No','No','Yes','Covered containers','Moderate','80','21.20','2','Easy',1),(828,'HH-828-7892',-0.7833000,35.0000000,'Narok','Narok North','Female',50,'Trader','Primary','No','No','No','No storage','Low','40','24.70','5','Difficult',1),(829,'HH-829-4444',-0.7833000,35.0000000,'Narok','Narok North','Male',52,'Trader','Primary','No','No','No','No storage','Low','40','24.70','5','Difficult',1),(830,'HH-830-8547',-0.7833000,35.0000000,'Narok','Narok North','Female',18,'Student','Primary','No','No','No','No storage','Low','40','24.70','5','Difficult',1),(831,'HH-831-9402',-0.7833000,35.0000000,'Narok','Narok North','Male',15,'None','None','No','No','No','No storage','Low','40','24.70','5','Difficult',1),(832,'HH-832-1372',-0.7833000,35.0000000,'Narok','Narok North','Female',10,'None','None','No','No','No','No storage','Low','40','24.70','5','Difficult',1),(833,'HH-833-8653',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',70,'Farmer','Secondary','No','No','No','Covered containers','Moderate','60','20.20','4','Easy',1),(834,'HH-834-9147',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',68,'Housewife','Primary','No','No','No','Covered containers','Moderate','60','20.20','4','Easy',1),(835,'HH-835-9780',-0.4000000,36.9000000,'Murang\'a','Kandara','Female',28,'Student','Tertiary','No','No','No','Covered containers','Moderate','60','20.20','4','Easy',1),(836,'HH-836-1460',-0.4000000,36.9000000,'Murang\'a','Kandara','Male',22,'Student','Secondary','No','No','No','Covered containers','Moderate','60','20.20','4','Easy',1),(837,'HH-837-7959',2.8000000,36.0000000,'Turkana','Turkana North','Male',90,'Pastoralist','None','Yes','No','No','Open containers','High','160','29.60','6','Difficult',1),(838,'HH-838-5416',2.8000000,36.0000000,'Turkana','Turkana North','Female',88,'Housewife','None','Yes','No','No','Open containers','High','160','29.60','6','Difficult',1),(839,'HH-839-3203',2.8000000,36.0000000,'Turkana','Turkana North','Male',55,'Pastoralist','None','Yes','No','No','Open containers','High','160','29.60','6','Difficult',1),(840,'HH-840-9766',2.8000000,36.0000000,'Turkana','Turkana North','Female',53,'Housewife','None','No','No','No','Open containers','High','160','29.60','6','Difficult',1),(841,'HH-841-9221',2.8000000,36.0000000,'Turkana','Turkana North','Male',20,'Student','Primary','No','No','No','Open containers','High','160','29.60','6','Difficult',1),(842,'HH-842-6809',2.8000000,36.0000000,'Turkana','Turkana North','Female',15,'None','None','No','No','No','Open containers','High','160','29.60','6','Difficult',1),(843,'HH-843-6384',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',45,'Shopkeeper','Secondary','No','No','No','Covered containers','Moderate','20','25.20','3','Easy',1),(844,'HH-844-1493',-0.6000000,37.0000000,'Machakos','Machakos Town','Male',48,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','20','25.20','3','Easy',1),(845,'HH-845-8312',-0.6000000,37.0000000,'Machakos','Machakos Town','Female',12,'None','None','No','No','No','Covered containers','Moderate','20','25.20','3','Easy',1),(846,'HH-846-7082',0.0000000,37.9000000,'Meru','Imenti South','Male',75,'Farmer','Primary','No','No','Yes','Open containers','Moderate','70','22.20','6','Moderate',1),(847,'HH-847-0475',0.0000000,37.9000000,'Meru','Imenti South','Female',70,'Housewife','Primary','No','No','Yes','Open containers','Moderate','70','22.20','6','Moderate',1),(848,'HH-848-1130',0.0000000,37.9000000,'Meru','Imenti South','Male',45,'Farmer','Secondary','No','No','Yes','Open containers','Moderate','70','22.20','6','Moderate',1),(849,'HH-849-4224',0.0000000,37.9000000,'Meru','Imenti South','Female',40,'Student','Secondary','No','No','Yes','Open containers','Moderate','70','22.20','6','Moderate',1),(850,'HH-850-7730',0.0000000,37.9000000,'Meru','Imenti South','Male',25,'Student','Primary','No','No','Yes','Open containers','Moderate','70','22.20','6','Moderate',1),(851,'HH-851-5981',0.0000000,37.9000000,'Meru','Imenti South','Female',18,'Student','Primary','No','No','Yes','Open containers','Moderate','70','22.20','6','Moderate',1),(852,'HH-852-6715',-2.1000000,40.0000000,'Lamu','Lamu West','Female',60,'Fisher','Primary','No','Yes','Yes','Open containers','High','120','27.90','5','Difficult',1),(853,'HH-853-5631',-2.1000000,40.0000000,'Lamu','Lamu West','Male',62,'Fisher','Primary','No','Yes','Yes','Open containers','High','120','27.90','5','Difficult',1),(854,'HH-854-8011',-2.1000000,40.0000000,'Lamu','Lamu West','Female',30,'Student','Secondary','No','No','Yes','Open containers','High','120','27.90','5','Difficult',1),(855,'HH-855-3162',-2.1000000,40.0000000,'Lamu','Lamu West','Male',25,'Student','Primary','No','No','Yes','Open containers','High','120','27.90','5','Difficult',1),(856,'HH-856-1778',-2.1000000,40.0000000,'Lamu','Lamu West','Female',15,'None','None','No','No','Yes','Open containers','High','120','27.90','5','Difficult',1),(857,'HH-857-9404',-0.6900000,34.2500000,'Siaya','Bondo','Male',60,'Farmer','Secondary','Yes','No','Yes','Covered containers','Moderate','110','24.20','7','Moderate',1),(858,'HH-858-1686',-0.6900000,34.2500000,'Siaya','Bondo','Female',58,'Housewife','Primary','No','No','Yes','Covered containers','Moderate','110','24.20','7','Moderate',1),(859,'HH-859-0217',-0.6900000,34.2500000,'Siaya','Bondo','Male',30,'Student','Secondary','No','No','Yes','Covered containers','Moderate','110','24.20','7','Moderate',1),(860,'HH-860-6029',-0.6900000,34.2500000,'Siaya','Bondo','Female',28,'Student','Primary','Yes','No','Yes','Covered containers','Moderate','110','24.20','7','Moderate',1),(861,'HH-861-9496',-0.6900000,34.2500000,'Siaya','Bondo','Male',18,'Student','Primary','No','No','Yes','Covered containers','Moderate','110','24.20','7','Moderate',1),(862,'HH-862-9394',-0.6900000,34.2500000,'Siaya','Bondo','Female',15,'None','None','No','No','Yes','Covered containers','Moderate','110','24.20','7','Moderate',1),(863,'HH-863-8481',-0.6900000,34.2500000,'Siaya','Bondo','Male',10,'None','None','No','No','Yes','Covered containers','Moderate','110','24.20','7','Moderate',1),(864,'HH-864-4222',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',70,'Farmer','Primary','No','No','No','No storage','Low','45','18.60','3','Moderate',1),(865,'HH-865-5671',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Male',72,'Farmer','Primary','No','No','No','No storage','Low','45','18.60','3','Moderate',1),(866,'HH-866-5687',0.3000000,36.5000000,'Nyandarua','Ol Kalou','Female',30,'Student','Tertiary','No','No','No','No storage','Low','45','18.60','3','Moderate',1),(867,'HH-867-1423',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',60,'Pastoralist','None','Yes','No','No','Open containers','High','130','26.20','6','Difficult',1),(868,'HH-868-0056',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',58,'Housewife','None','Yes','No','No','Open containers','High','130','26.20','6','Difficult',1),(869,'HH-869-6009',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',30,'Student','Primary','No','No','No','Open containers','High','130','26.20','6','Difficult',1),(870,'HH-870-9877',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',28,'None','None','No','No','No','Open containers','High','130','26.20','6','Difficult',1),(871,'HH-871-1361',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Male',18,'None','None','No','No','No','Open containers','High','130','26.20','6','Difficult',1),(872,'HH-872-7172',-1.0000000,35.0000000,'Kajiado','Kajiado Central','Female',12,'None','None','No','No','No','Open containers','High','130','26.20','6','Difficult',1),(873,'HH-873-1781',-0.1000000,37.5000000,'Embu','Embu West','Female',52,'Trader','Secondary','No','No','No','Covered containers','Moderate','55','21.70','4','Easy',1),(874,'HH-874-7386',-0.1000000,37.5000000,'Embu','Embu West','Male',55,'Mechanic','Secondary','No','No','No','Covered containers','Moderate','55','21.70','4','Easy',1),(875,'HH-875-1590',-0.1000000,37.5000000,'Embu','Embu West','Female',20,'Student','Primary','No','No','No','Covered containers','Moderate','55','21.70','4','Easy',1),(876,'HH-876-5793',-0.1000000,37.5000000,'Embu','Embu West','Male',15,'None','None','No','No','No','Covered containers','Moderate','55','21.70','4','Easy',1),(877,'HH-877-4194',-0.2000000,38.0000000,'Kitui','Kitui Central','Male',65,'Farmer','Primary','No','No','Yes','Open containers','High','90','26.20','5','Moderate',1),(878,'HH-878-3592',-0.2000000,38.0000000,'Kitui','Kitui Central','Female',63,'Housewife','Primary','No','No','Yes','Open containers','High','90','26.20','5','Moderate',1),(879,'HH-879-5378',0.5000000,38.0000000,'Wajir','Wajir East','Female',18,'None','None','No','No','No','Open containers','High','160','32.20','6','Difficult',1),(880,'HH-880-6113',0.5000000,38.0000000,'Wajir','Wajir East','Male',15,'None','None','No','No','No','Open containers','High','160','32.20','6','Difficult',1),(881,'HH-881-4432',-0.2000000,35.5000000,'Nyamira','Manga','Male',55,'Farmer','Secondary','No','No','No','Covered containers','Moderate','85','21.20','5','Moderate',1),(882,'HH-882-3821',-0.2000000,35.5000000,'Nyamira','Manga','Female',53,'Housewife','Primary','No','No','No','Covered containers','Moderate','85','21.20','5','Moderate',1),(883,'HH-883-5810',-0.2000000,35.5000000,'Nyamira','Manga','Male',22,'Student','Primary','No','No','No','Covered containers','Moderate','85','21.20','5','Moderate',1),(884,'HH-884-7587',-0.2000000,35.5000000,'Nyamira','Manga','Female',20,'None','None','No','No','No','Covered containers','Moderate','85','21.20','5','Moderate',1),(885,'HH-885-0505',-0.2000000,35.5000000,'Nyamira','Manga','Male',12,'None','None','No','No','No','Covered containers','Moderate','85','21.20','5','Moderate',1),(886,'HH-886-9764',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',68,'Farmer','Primary','No','No','No','No storage','Low','40','19.70','4','Moderate',1),(887,'HH-887-7305',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',70,'Farmer','Primary','No','No','No','No storage','Low','40','19.70','4','Moderate',1),(888,'HH-888-7235',-0.1500000,36.0000000,'Laikipia','Laikipia West','Female',30,'Student','Tertiary','No','No','No','No storage','Low','40','19.70','4','Moderate',1),(889,'HH-889-4258',-0.1500000,36.0000000,'Laikipia','Laikipia West','Male',28,'Student','Secondary','No','No','No','No storage','Low','40','19.70','4','Moderate',1),(890,'HH-890-9588',0.0000000,34.5000000,'Kakamega','Lurambi','Male',60,'Teacher','Tertiary','No','No','Yes','Covered containers','Moderate','90','22.20','5','Easy',1),(891,'HH-891-5164',0.0000000,34.5000000,'Kakamega','Lurambi','Female',58,'Housewife','Secondary','No','No','Yes','Covered containers','Moderate','90','22.20','5','Easy',1),(892,'HH-892-7057',0.0000000,34.5000000,'Kakamega','Lurambi','Male',25,'Student','Secondary','No','No','Yes','Covered containers','Moderate','90','22.20','5','Easy',1),(893,'HH-893-9793',0.0000000,34.5000000,'Kakamega','Lurambi','Female',22,'Student','Primary','No','No','Yes','Covered containers','Moderate','90','22.20','5','Easy',1),(894,'HH-894-7796',0.0000000,34.5000000,'Kakamega','Lurambi','Male',15,'None','None','No','No','Yes','Covered containers','Moderate','90','22.20','5','Easy',1),(895,'HH-895-9603',-1.5000000,36.0000000,'Kajiado','Loitokitok','Female',75,'Farmer','Primary','No','No','No','Open containers','High','70','26.70','6','Difficult',1),(896,'HH-896-4626',-1.5000000,36.0000000,'Kajiado','Loitokitok','Male',78,'Farmer','Primary','No','No','No','Open containers','High','70','26.70','6','Difficult',1);
/*!40000 ALTER TABLE `kemri_studyparticipants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_subcounties`
--

DROP TABLE IF EXISTS `kemri_subcounties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_subcounties` (
  `subcountyId` int NOT NULL AUTO_INCREMENT,
  `countyId` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `postalCode` varchar(255) DEFAULT NULL,
  `email` text,
  `phone` varchar(255) DEFAULT NULL,
  `address` text,
  `geoSpatial` varchar(255) DEFAULT NULL,
  `polygon` text,
  `geoCode` varchar(255) DEFAULT NULL,
  `geoLat` varchar(255) DEFAULT NULL,
  `geoLon` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`subcountyId`),
  KEY `fk_subcounty_county` (`countyId`),
  CONSTRAINT `fk_subcounty_county` FOREIGN KEY (`countyId`) REFERENCES `kemri_counties` (`countyId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_subcounties`
--

LOCK TABLES `kemri_subcounties` WRITE;
/*!40000 ALTER TABLE `kemri_subcounties` DISABLE KEYS */;
INSERT INTO `kemri_subcounties` VALUES (101,1,'Kisumu Central','40100','ksumcentral@county.gov','0700101101','Kisumu Central Office','POINT(34.7617 -0.1022)','{}','KSC','-0.1022','34.7617',0,NULL),(102,1,'Kisumu East','40100','ksumeast@county.gov','0700101102','Kisumu East Office','POINT(34.8000 -0.0500)','{}','KSE','-0.0500','34.8000',0,NULL),(103,1,'Kisumu West','40100','ksumwest@county.gov','0700101103','Kisumu West Office','POINT(34.6500 -0.1500)','{}','KSW','-0.1500','34.6500',0,NULL),(104,4,'Turkana Central','30500','turkanacentral@county.gov','0700305104','Turkana Central Office','POINT(35.5975 3.1118)','{}','TRC','3.1118','35.5975',0,NULL),(105,2,'Dagoretti North','00606','dagorettinorth@county.gov','0700001105','Dagoretti North Office','POINT(36.75 -1.28)','{}','DNN','-1.28','36.75',0,NULL);
/*!40000 ALTER TABLE `kemri_subcounties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_task_assignees`
--

DROP TABLE IF EXISTS `kemri_task_assignees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_task_assignees` (
  `taskAssigneeId` int NOT NULL AUTO_INCREMENT,
  `taskId` int DEFAULT NULL,
  `staffId` int DEFAULT NULL,
  `assignedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`taskAssigneeId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_task_assignees`
--

LOCK TABLES `kemri_task_assignees` WRITE;
/*!40000 ALTER TABLE `kemri_task_assignees` DISABLE KEYS */;
INSERT INTO `kemri_task_assignees` VALUES (1,1,1,'2025-07-15 23:07:58'),(2,1,2,'2025-07-15 23:07:58'),(3,2,2,'2025-07-16 17:08:20'),(4,2,1,'2025-07-16 17:08:20'),(6,10,2,'2025-07-17 08:23:02'),(10,7,2,'2025-07-17 10:07:35'),(11,8,1,'2025-07-17 11:31:49'),(12,8,2,'2025-07-17 11:31:49');
/*!40000 ALTER TABLE `kemri_task_assignees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_task_dependencies`
--

DROP TABLE IF EXISTS `kemri_task_dependencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_task_dependencies` (
  `dependencyId` int NOT NULL AUTO_INCREMENT,
  `taskId` int DEFAULT NULL,
  `dependsOnTaskId` int DEFAULT NULL,
  PRIMARY KEY (`dependencyId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_task_dependencies`
--

LOCK TABLES `kemri_task_dependencies` WRITE;
/*!40000 ALTER TABLE `kemri_task_dependencies` DISABLE KEYS */;
INSERT INTO `kemri_task_dependencies` VALUES (1,2,1),(2,3,2),(3,4,3),(4,10,4),(7,7,6),(8,8,1);
/*!40000 ALTER TABLE `kemri_task_dependencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_tasks`
--

DROP TABLE IF EXISTS `kemri_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_tasks` (
  `taskId` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `taskName` varchar(255) DEFAULT NULL,
  `description` text,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `progressPercentage` int DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `dueDate` datetime DEFAULT NULL,
  PRIMARY KEY (`taskId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_tasks`
--

LOCK TABLES `kemri_tasks` WRITE;
/*!40000 ALTER TABLE `kemri_tasks` DISABLE KEYS */;
INSERT INTO `kemri_tasks` VALUES (1,1,'Data Collection Phase',NULL,'2025-08-13 00:00:00','2025-10-13 00:00:00','In Progress',0,'2025-07-15 22:50:32','2025-07-16 19:55:37',NULL),(2,1,'Environmental assessments',NULL,'2025-03-14 00:00:00','2025-08-15 00:00:00','Completed',0,'2025-07-15 23:25:06','2025-07-16 17:08:20',NULL),(3,1,'Community health surveys','Implement community health surveys.','2025-05-15 00:00:00','2025-06-30 00:00:00','Completed',0,'2025-07-15 23:26:27','2025-07-15 23:26:27',NULL),(4,1,'Water source sampling',NULL,'2025-05-14 00:00:00','2025-06-29 00:00:00','Completed',0,'2025-07-15 23:27:34','2025-07-16 17:44:22',NULL),(5,1,'Assessment of Vector breeding sites',NULL,'2025-06-13 00:00:00','2025-08-28 00:00:00','In Progress',0,'2025-07-15 23:32:09','2025-07-16 18:38:51',NULL),(6,1,'Document land use changes','sasas','2025-07-11 00:00:00','2025-07-28 00:00:00','Not Started',0,'2025-07-16 03:17:46','2025-07-16 19:49:15',NULL),(7,1,'asante sana te','weda moses','2025-07-06 00:00:00','2025-07-22 00:00:00','In Progress',0,'2025-07-16 19:57:59','2025-07-17 10:07:35','2025-07-25 00:00:00'),(8,1,'ASDUE has delayed','sema','2025-07-18 00:00:00','2025-08-01 00:00:00','Delayed',0,'2025-07-17 07:47:25','2025-07-17 11:31:49','2025-08-08 00:00:00'),(9,1,'were','dsds','2025-07-18 00:00:00','2025-07-18 00:00:00','Not Started',0,'2025-07-17 08:11:14','2025-07-17 08:11:14','2025-07-15 00:00:00'),(10,1,'weqwewqe','wewqe','2025-07-23 00:00:00','2025-07-31 00:00:00','Not Started',0,'2025-07-17 08:23:02','2025-07-17 08:23:02','2025-07-24 00:00:00');
/*!40000 ALTER TABLE `kemri_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_users`
--

DROP TABLE IF EXISTS `kemri_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_users` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `passwordHash` varchar(255) DEFAULT NULL,
  `email` text,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_users`
--

LOCK TABLES `kemri_users` WRITE;
/*!40000 ALTER TABLE `kemri_users` DISABLE KEYS */;
INSERT INTO `kemri_users` VALUES (1,'testuser','$2b$10$AK.zhA7okyFJtXgyF12NhezYzKENXqMeHZ2c3l8z7Q.u0y9Zd1mCa','test@example.com','Test','User','admin',1,'2025-07-15 18:21:53','2025-07-18 20:17:20'),(2,'akwatuha','$2b$10$QtfPgO.TsMeK/hkWEvY6vOOcKtbYxqG7kBM.cEKned64YTWi2Us6.','kwatuha@gmail.com','Alfayo','Kwatuha','admin',1,'2025-07-15 18:36:23','2025-07-18 18:34:44'),(3,'emaru','$2b$10$rw1otXRYFaSSL2p7xOE3SOV3NJ3oqx0eebF6eNQe02GuYLz3GkrJ.','maru@gmail.com','Ezekiel','Maru','manager',1,'2025-07-18 20:09:54','2025-07-18 20:09:54'),(4,'testal','$2b$10$7IzckbsdsdV7CzLzMW2y0.0WqLfNdHwxrtnqqwT35uyhWLXdmAMtu','test@gmail.com','Testing','Teser','admin',1,'2025-07-18 20:20:27','2025-07-18 20:20:27'),(5,'testuser','$2b$10$AK.zhA7okyFJtXgyF12NhezYzKENXqMeHZ2c3l8z7Q.u0y9Zd1mCa','test@example.com','Test','User','admin',1,'2025-07-15 21:21:53','2025-07-18 23:17:20'),(6,'akwatuha','$2b$10$QtfPgO.TsMeK/hkWEvY6vOOcKtbYxqG7kBM.cEKned64YTWi2Us6.','kwatuha@gmail.com','Alfayo','Kwatuha','admin',1,'2025-07-15 21:36:23','2025-07-18 21:34:44'),(7,'emaru','$2b$10$rw1otXRYFaSSL2p7xOE3SOV3NJ3oqx0eebF6eNQe02GuYLz3GkrJ.','maru@gmail.com','Ezekiel','Maru','manager',1,'2025-07-18 23:09:54','2025-07-18 23:09:54'),(8,'testal','$2b$10$7IzckbsdsdV7CzLzMW2y0.0WqLfNdHwxrtnqqwT35uyhWLXdmAMtu','test@gmail.com','Testing','Teser','admin',1,'2025-07-18 23:20:27','2025-07-18 23:20:27');
/*!40000 ALTER TABLE `kemri_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kemri_wards`
--

DROP TABLE IF EXISTS `kemri_wards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kemri_wards` (
  `wardId` int NOT NULL AUTO_INCREMENT,
  `subcountyId` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `postalCode` varchar(255) DEFAULT NULL,
  `email` text,
  `phone` varchar(255) DEFAULT NULL,
  `address` text,
  `polygon` text,
  `geoSpatial` varchar(255) DEFAULT NULL,
  `geoCode` varchar(255) DEFAULT NULL,
  `geoLat` varchar(255) DEFAULT NULL,
  `geoLon` varchar(255) DEFAULT NULL,
  `voided` tinyint(1) DEFAULT NULL,
  `voidedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`wardId`),
  KEY `fk_ward_subcounty` (`subcountyId`),
  CONSTRAINT `fk_ward_subcounty` FOREIGN KEY (`subcountyId`) REFERENCES `kemri_subcounties` (`subcountyId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kemri_wards`
--

LOCK TABLES `kemri_wards` WRITE;
/*!40000 ALTER TABLE `kemri_wards` DISABLE KEYS */;
INSERT INTO `kemri_wards` VALUES (201,101,'Market Milimani','40100','marketmilimani@ward.gov','0711201201','Market Milimani Office','{}','POINT(34.7610 -0.1010)','MMW','-0.1010','34.7610',0,NULL),(202,101,'Shauri Moyo','40100','shaurimoyo@ward.gov','0711201202','Shauri Moyo Office','{}','POINT(34.7650 -0.1050)','SMW','-0.1050','34.7650',0,NULL),(203,101,'Kaloleni','40100','kaloleni@ward.gov','0711201203','Kaloleni Office','{}','POINT(34.7700 -0.1100)','KLW','-0.1100','34.7700',0,NULL),(204,102,'Kondele','40100','kondele@ward.gov','0711201204','Kondele Office','{}','POINT(34.7800 -0.0900)','KND','-0.0900','34.7800',0,NULL);
/*!40000 ALTER TABLE `kemri_wards` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-22  7:10:54
