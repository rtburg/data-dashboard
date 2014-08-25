-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: crime
-- ------------------------------------------------------
-- Server version	5.6.20

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
-- Table structure for table `geocoded_addresses`
--

DROP TABLE IF EXISTS `geocoded_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geocoded_addresses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `county` varchar(100) DEFAULT NULL,
  `agency` varchar(100) DEFAULT NULL,
  `original_address` varchar(250) DEFAULT NULL,
  `standardized_address` varchar(250) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` char(3) DEFAULT 'NC',
  `zip` mediumint(9) DEFAULT NULL,
  `lat` float(16,13) DEFAULT NULL,
  `lon` float(16,13) DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `geocoder` varchar(100) DEFAULT NULL,
  `geocoder_score` char(20) DEFAULT NULL,
  `standardized_full_address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `original_address` (`original_address`),
  KEY `county` (`county`),
  KEY `agency` (`agency`),
  KEY `standardized_address` (`standardized_address`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `geocoded_addresses`
--

LOCK TABLES `geocoded_addresses` WRITE;
/*!40000 ALTER TABLE `geocoded_addresses` DISABLE KEYS */;
INSERT INTO `geocoded_addresses` VALUES (1,'Cumberland','Fayetteville Police Department','3296 VILLAGE DR/OWEN DR, Cumberland County, NC','3296 Village Dr','Fayetteville','NC',28304,35.0313148498535,-78.9299011230469,'2014-08-25 18:02:03','Google','ROOFTOP','3296 Village Drive, Fayetteville, NC 28304, USA'),(2,'Franklin','Wake Forest Police Department','300 DURHAM RD/S WINGATE ST, Franklin County, NC','300 Durham Rd','Wake Forest','NC',27587,35.9800491333008,-78.5148239135742,'2014-08-25 18:02:03','Google','RANGE_INTERPOLATED','300 Durham Road, Wake Forest, NC 27587, USA'),(3,'Cumberland','Fayetteville Police Department','319 OWEN DR/PLAYER AVE, Cumberland County, NC','319 Owen Dr','Fayetteville','NC',28304,35.0397300720215,-78.9337615966797,'2014-08-25 18:02:04','Google','RANGE_INTERPOLATED','319 Owen Drive, Fayetteville, NC 28304, USA'),(4,'Franklin','Wake Forest Police Department','1843 S MAIN ST, Franklin County, NC','1843 S Main St','Louisburg','NC',27549,36.0843048095703,-78.3144531250000,'2014-08-25 18:02:04','Google','RANGE_INTERPOLATED','1843 South Main Street, Louisburg, NC 27549, USA'),(5,'Cumberland','Fayetteville Police Department','225 N MCPHERSON CHURCH RD/VANCOUVER DR, Cumberland County, NC','225 N McPherson Church Rd','Fayetteville','NC',28303,35.0703620910645,-78.9519882202148,'2014-08-25 18:02:05','Google','ROOFTOP','225 North McPherson Church Road, Fayetteville, NC 28303, USA'),(6,'Cabarrus','Kannapolis Police Department','312 PINEVIEW ST/DESOTO AV, Cabarrus County, NC','312 Pineview St','Kannapolis','NC',28083,35.4853057861328,-80.6237869262695,'2014-08-25 18:02:05','Google','ROOFTOP','312 Pineview Street, Kannapolis, NC 28083, USA'),(7,'Caldwell','Lenoir Police Department','2000 SE STARCROSS RD/SE STAR SHAKER LN, Cladwell County, NC','2000 Starcross Rd','Lenoir','NC',28645,35.8819694519043,-81.4917907714844,'2014-08-25 18:02:06','Google','RANGE_INTERPOLATED','2000 Starcross Road, Lenoir, NC 28645, USA'),(8,'Cumberland','Fayetteville Police Department','3025 MORGANTON RD/BAKER ST, Cumberland County, NC','3025 Morganton Rd','Fayetteville','NC',28303,35.0642051696777,-78.9365692138672,'2014-08-25 18:02:06','Google','RANGE_INTERPOLATED','3025 Morganton Road, Fayetteville, NC 28303, USA'),(9,'Cumberland','Fayetteville Police Department','918 COUNTRY CLUB DR/DISTRIBUTION DR, Cumberland County, NC','918 Country Club Dr','Fayetteville','NC',28311,35.0999183654785,-78.9132919311523,'2014-08-25 18:02:06','Google','RANGE_INTERPOLATED','918 Country Club Drive, Fayetteville, NC 28311, USA'),(10,'Cumberland','Fayetteville Police Department','699 MONTCLAIR RD/MORISTON RD, Cumberland County, NC','699 Montclair Rd','Fayetteville','NC',28314,35.0496673583984,-78.9571228027344,'2014-08-25 18:02:07','Google','RANGE_INTERPOLATED','699 Montclair Road, Fayetteville, NC 28314, USA'),(11,'Wake','Wake County Sheriff\'s Office','Green Pace Rd, Raleigh, NC','Pace St','Raleigh','NC',27604,35.7889823913574,-78.6343612670898,'2014-08-25 18:02:07','Google','GEOMETRIC_CENTER','Pace Street, Raleigh, NC 27604, USA'),(12,'Lee','Sanford Police Department','1400 S Horner Blvd, Sanford, NC','1400 S Horner Blvd','Sanford','NC',27330,35.4682998657227,-79.1634902954102,'2014-08-25 18:02:08','Google','RANGE_INTERPOLATED','1400 South Horner Boulevard, Sanford, NC 27330, USA'),(13,'Buncombe','Buncombe County Sheriff\'s Office','45 Wright Farm Rd, Candler, NC','45 Wright Farm Rd','Candler','NC',28715,35.5764503479004,-82.7075347900391,'2014-08-25 18:02:08','Google','ROOFTOP','45 Wright Farm Road, Candler, NC 28715, USA'),(14,'Franklin','Wake Forest Police Department','700 E PINE AVE, Franklin County, NC','700 E Pine Ave','Wake Forest','NC',27587,35.9794502258301,-78.5004959106445,'2014-08-25 18:02:08','Google','RANGE_INTERPOLATED','700 East Pine Avenue, Wake Forest, NC 27587, USA'),(15,'Rowan','Rowan County Sheriff\'s Office','100-BLK Greenfield Rd, China Grove, NC','100 Greenfield Rd','China Grove','NC',28023,35.5591239929199,-80.6348037719727,'2014-08-25 18:02:09','Google','RANGE_INTERPOLATED','100 Greenfield Road, China Grove, NC 28023, USA'),(16,'Wake','Wake County Sheriff\'s Office','716 Peterson St, Raleigh, NC','716 Peterson St','Raleigh','NC',27610,35.7599945068359,-78.6291046142578,'2014-08-25 18:02:09','Google','ROOFTOP','716 Peterson Street, Raleigh, NC 27610, USA'),(17,'Rowan','Rowan County Sheriff\'s Office','700-BLK Old Us 80 Hwy, Gold Hill, NC','700 State Rd 2350','Gold Hill','NC',28071,35.5226783752441,-80.3412780761719,'2014-08-25 18:02:10','Google','RANGE_INTERPOLATED','700 Old US Highway 80, Gold Hill, NC 28071, USA'),(18,'Wake','Wake County Sheriff\'s Office','4325 Glenwood Ave, Raleigh, NC','4325 Glenwood Ave','Raleigh','NC',27612,35.8404541015625,-78.6795959472656,'2014-08-25 18:02:10','Google','ROOFTOP','4325 Glenwood Avenue, Raleigh, NC 27612, USA'),(19,'Lee','Sanford Police Department','799 N Gulf St/queens Rd, Sanford, NC','799 N Gulf St','Sanford','NC',27330,35.4876518249512,-79.1904449462891,'2014-08-25 18:02:10','Google','RANGE_INTERPOLATED','799 North Gulf Street, Sanford, NC 27330, USA'),(20,'Wake','Wake County Sheriff\'s Office','10019 Chapel Hill Rd/morrisville Carpenter Rd, Morrisville, NC','10019 Chapel Hill Rd','Morrisville','NC',27560,35.8237342834473,-78.8255538940430,'2014-08-25 18:02:11','Google','RANGE_INTERPOLATED','10019 Chapel Hill Road, Morrisville, NC 27560, USA'),(21,'Wake','Wake County Sheriff\'s Office','100 Aviation Pkwy/chapel Hill Rd, Morrisville, NC','100 Aviation Pkwy','Morrisville','NC',27560,35.8232879638672,-78.8252868652344,'2014-08-25 18:02:12','Google','RANGE_INTERPOLATED','100 Aviation Parkway, Morrisville, NC 27560, USA'),(22,'Wake','Wake County Sheriff\'s Office','1225 Morrisville Pkwy/fairwood Dr, Morrisville, NC','1225 Morrisville Pkwy','Morrisville','NC',27560,35.8105010986328,-78.8388748168945,'2014-08-25 18:02:12','Google','RANGE_INTERPOLATED','1225 Morrisville Parkway, Morrisville, NC 27560, USA'),(23,'Wake','Wake County Sheriff\'s Office','9899 Chapel Hill Rd/weston Pkwy, Morrisville, NC','9899 Chapel Hill Rd','Morrisville','NC',27560,35.8141365051270,-78.8208084106445,'2014-08-25 18:02:12','Google','RANGE_INTERPOLATED','9899 Chapel Hill Road, Morrisville, NC 27560, USA'),(24,'Wake','Wake County Sheriff\'s Office','563 Garden Square Ln/airport Blvd, Morrisville, NC','563 Garden Square Ln','Morrisville','NC',27560,35.8328437805176,-78.8438644409180,'2014-08-25 18:02:13','Google','RANGE_INTERPOLATED','563 Garden Square Lane, Morrisville, NC 27560, USA'),(25,'Union','Union County Sheriff\'s Office','3099 Meriwether Lewis Tr, Indian Trail, NC','3099 Meriwether Lewis Trail','Monroe','NC',28110,35.0297393798828,-80.6486663818359,'2014-08-25 18:02:13','Google','RANGE_INTERPOLATED','3099 Meriwether Lewis Trail, Monroe, NC 28110, USA'),(26,'Wake','Wake County Sheriff\'s Office','699 Morrisville Carpenter Rd/kudrow Ln, Morrisville, NC','699 Jenks Carpenter Rd','Cary','NC',27519,35.7777061462402,-78.8595581054688,'2014-08-25 18:02:14','Google','RANGE_INTERPOLATED','699 Jenks Carpenter Road, Cary, NC 27519, USA'),(27,'Wake','Wake County Sheriff\'s Office','10019 Chapel Hill Rd/aviation Pkwy, Morrisville, NC','10019 Chapel Hill Rd','Morrisville','NC',27560,35.8237342834473,-78.8255538940430,'2014-08-25 18:02:14','Google','RANGE_INTERPOLATED','10019 Chapel Hill Road, Morrisville, NC 27560, USA'),(28,'Wake','Wake County Sheriff\'s Office','599 Morrisville Carpenter Rd/misty Groves Cir, Morrisville, NC','599 Carpenter Town Ln','Cary','NC',27519,35.8198089599609,-78.8560104370117,'2014-08-25 18:02:15','Google','RANGE_INTERPOLATED','599 Carpenter Town Lane, Cary, NC 27519, USA'),(29,'Wake','Wake County Sheriff\'s Office','10999 Chapel Hill Rd/carrington Mill Blvd, Morrisville, NC','10999 Chapel Hill Rd','Morrisville','NC',27560,35.8565902709961,-78.8428421020508,'2014-08-25 18:02:15','Google','RANGE_INTERPOLATED','10999 Chapel Hill Road, Morrisville, NC 27560, USA'),(30,'Wake','Wake County Sheriff\'s Office','1216 Aruba Court, Knightdale','1216 Aruba Ct','Knightdale','NC',27545,35.7616310119629,-78.4506530761719,'2014-08-25 18:02:15','Google','ROOFTOP','1216 Aruba Court, Knightdale, NC 27545, USA'),(31,'Wake','Wake County Sheriff\'s Office','Us 264 Hwy E, Wendell','264 State Rd 1701','Wendell','NC',27591,35.6965217590332,-78.3732986450195,'2014-08-25 18:02:16','Google','RANGE_INTERPOLATED','264 Wendell Road, Wendell, NC 27591, USA'),(32,'Wake','Wake County Sheriff\'s Office','269 S. Selma, Wendell','269 S Selma Rd','Wendell','NC',27591,35.7753143310547,-78.3608856201172,'2014-08-25 18:02:16','Google','ROOFTOP','269 South Selma Road, Wendell, NC 27591, USA'),(33,'Wake','Wake County Sheriff\'s Office','400 Wood Green Dr., Wendell, NC','400 Wood Green Dr','Wendell','NC',27591,35.7926940917969,-78.3529129028320,'2014-08-25 18:02:17','Google','ROOFTOP','400 Wood Green Drive, Wendell, NC 27591, USA'),(34,'Wake','Wake County Sheriff\'s Office','123 Church St, Wendell, NC','123 Church St','Wendell','NC',27591,35.7867698669434,-78.3822402954102,'2014-08-25 18:02:17','Google','ROOFTOP','123 Church Street, Wendell, NC 27591, USA'),(35,'Wake','Wake County Sheriff\'s Office','304 Cedarfield Ct, Wendell, NC','304 Cedarfield St','Wendell','NC',27591,35.7873306274414,-78.3765792846680,'2014-08-25 18:02:17','Google','RANGE_INTERPOLATED','304 Cedarfield Street, Wendell, NC 27591, USA'),(36,'Wake','Wake County Sheriff\'s Office','615 Marshburn Rd., Wendell, NC','615 Marshburn Rd','Wendell','NC',27591,35.7890472412109,-78.3747253417969,'2014-08-25 18:02:18','Google','ROOFTOP','615 Marshburn Road, Wendell, NC 27591, USA'),(37,'Wake','Wake County Sheriff\'s Office','430 N, Main St, Wendell, NC','430 N Main St','Wendell','NC',27591,35.7879638671875,-78.3688507080078,'2014-08-25 18:02:18','Google','ROOFTOP','430 North Main Street, Wendell, NC 27591, USA'),(38,'Wake','Wake County Sheriff\'s Office','215 Mattox St, Wendell, NC','215 Mattox St','Wendell','NC',27591,35.7851791381836,-78.3666458129883,'2014-08-25 18:02:18','Google','ROOFTOP','215 Mattox Street, Wendell, NC 27591, USA'),(39,'Wake','Wake County Sheriff\'s Office','Selma Rd & Third St, Wendell','N Selma Rd','Wendell','NC',27591,35.7805213928223,-78.3622894287109,'2014-08-25 18:02:19','Google','APPROXIMATE','North Selma Road & East 3rd Street, Wendell, NC 27591, USA'),(40,'Cumberland','Fayetteville Police Department','511 OWEN DR/SANDHURST DR, Cumberland County, NC','511 Owen Dr','Fayetteville','NC',28304,35.0358886718750,-78.9320831298828,'2014-08-25 18:13:21','Google','ROOFTOP','511 Owen Drive, Fayetteville, NC 28304, USA'),(41,'Cumberland','Fayetteville Police Department','3718 RAMSEY ST/LONGVIEW DR, Cumberland County, NC','3718 Ramsey St','Fayetteville','NC',28311,35.1107978820801,-78.8791961669922,'2014-08-25 18:13:22','Google','RANGE_INTERPOLATED','3718 Ramsey Street, Fayetteville, NC 28311, USA'),(42,'Cumberland','Fayetteville Police Department','1529 BOROS DR/MINTZ AVE, Cumberland County, NC','1529 Boros Dr','Fayetteville','NC',28303,35.0968208312988,-78.9275360107422,'2014-08-25 18:13:22','Google','RANGE_INTERPOLATED','1529 Boros Drive, Fayetteville, NC 28303, USA'),(43,'Cumberland','Fayetteville Police Department','2633 RAEFORD RD/EXECUTIVE PL, Cumberland County, NC','2633 Raeford Rd','Fayetteville','NC',28303,35.0457725524902,-78.9221420288086,'2014-08-25 18:13:23','Google','RANGE_INTERPOLATED','2633 Raeford Road, Fayetteville, NC 28303, USA'),(44,'Cabarrus','Kannapolis Police Department','597 N CANNON BLVD/LANE ST, Cabarrus County, NC','597 N Cannon Blvd','Kannapolis','NC',28083,35.5023498535156,-80.6092224121094,'2014-08-25 18:23:42','Google','RANGE_INTERPOLATED','597 North Cannon Boulevard, Kannapolis, NC 28083, USA'),(45,'Cumberland','Fayetteville Police Department','3535 BRAGG BLVD/SYCAMORE DAIRY RD, Cumberland County, NC','3535 Bragg Blvd','Fayetteville','NC',28303,35.0792732238770,-78.9406814575195,'2014-08-25 18:23:42','Google','RANGE_INTERPOLATED','3535 Bragg Boulevard, Fayetteville, NC 28303, USA'),(46,'Cumberland','Fayetteville Police Department','6160 RAEFORD RD/REVERE ST, Cumberland County, NC','6160 Raeford Rd','Fayetteville','NC',28304,35.0441741943359,-78.9820175170898,'2014-08-25 18:23:43','Google','RANGE_INTERPOLATED','6160 Raeford Road, Fayetteville, NC 28304, USA'),(47,'Cumberland','Fayetteville Police Department','6400 RAMSEY ST/ANDREWS RD, Cumberland County, NC','6400 Ramsey St','Fayetteville','NC',28311,35.1575508117676,-78.8691635131836,'2014-08-25 18:23:44','Google','RANGE_INTERPOLATED','6400 Ramsey Street, Fayetteville, NC 28311, USA'),(48,'Cumberland','Fayetteville Police Department','3605 BOONE TRL/ROXIE AVE, Cumberland County, NC','3605 Boone Trail','Fayetteville','NC',28306,35.0193634033203,-78.9351730346680,'2014-08-25 18:23:44','Google','RANGE_INTERPOLATED','3605 Boone Trail, Fayetteville, NC 28306, USA'),(49,'Cumberland','Fayetteville Police Department','5117 MORGANTON RD/OLD GATE RD, Cumberland County, NC','5117 Morganton Rd','Fayetteville','NC',28314,35.0711669921875,-78.9660873413086,'2014-08-25 18:23:45','Google','RANGE_INTERPOLATED','5117 Morganton Road, Fayetteville, NC 28314, USA'),(50,'Cumberland','Fayetteville Police Department','721 PAMALEE DR/BRAGG BLVD ON RAMP, Cumberland County, NC','721 Pamalee Dr','Fayetteville','NC',28303,35.0859909057617,-78.9505844116211,'2014-08-25 18:23:45','Google','RANGE_INTERPOLATED','721 Pamalee Drive, Fayetteville, NC 28303, USA'),(51,'Franklin','Wake Forest Police Department','1045 S MAIN ST/DR CALVIN JONES HWY, Franklin County, NC','1045 S Main St','Louisburg','NC',27549,36.0849266052246,-78.3136596679688,'2014-08-25 18:23:46','Google','RANGE_INTERPOLATED','1045 South Main Street, Louisburg, NC 27549, USA'),(52,'Wake','Wake County Sheriff\'s Office','1207 Lake Wheeler Rd, Raleigh, NC','1207 Lake Wheeler Rd','Raleigh','NC',27603,35.7677993774414,-78.6508102416992,'2014-08-25 18:23:46','Google','RANGE_INTERPOLATED','1207 Lake Wheeler Road, Raleigh, NC 27603, USA'),(53,'Buncombe','Buncombe County Sheriff\'s Office','20 Davidson Dr, Asheville, NC','20 Davidson Dr','Asheville','NC',28801,35.5960998535156,-82.5477905273438,'2014-08-25 18:23:46','Google','ROOFTOP','20 Davidson Drive, Asheville, NC 28801, USA'),(54,'Wake','Wake County Sheriff\'s Office','3301 Hammond Rd, Raleigh, NC','3301 Hammond Rd','Raleigh','NC',27603,35.7337913513184,-78.6388854980469,'2014-08-25 18:23:47','Google','ROOFTOP','3301 Hammond Road, Raleigh, NC 27603, USA'),(55,'Buncombe','Asheville Police Department','1 Page Ave, Asheville, NC','1 Page Ave','Asheville','NC',28801,35.5955581665039,-82.5565948486328,'2014-08-25 18:23:48','Google','ROOFTOP','1 Page Avenue, Asheville, NC 28801, USA'),(56,'Wake','Wake County Sheriff\'s Office','2108 Leadenhall Way, Raleigh, NC','2108 Leadenhall Way','Raleigh','NC',27603,35.7479743957520,-78.6872787475586,'2014-08-25 18:23:49','Google','ROOFTOP','2108 Leadenhall Way, Raleigh, NC 27603, USA'),(57,'Wake','Wake County Sheriff\'s Office','200 Oberlin Rd, Raleigh, NC','200 Oberlin Rd','Raleigh','NC',27605,35.7863769531250,-78.6612930297852,'2014-08-25 18:23:49','Google','RANGE_INTERPOLATED','200 Oberlin Road, Raleigh, NC 27605, USA'),(58,'Wake','Wake County Sheriff\'s Office','300 S Salisbury St, Raleigh, NC','300 S Salisbury St','Raleigh','NC',27601,35.7763481140137,-78.6400375366211,'2014-08-25 18:23:50','Google','ROOFTOP','300 South Salisbury Street, Raleigh, NC 27601, USA'),(59,'Buncombe','Asheville Police Department','I40/i240, Asheville, NC','Asheville Hwy','','NC',29303,34.9958648681641,-81.9987716674805,'2014-08-25 18:23:50','Google','APPROXIMATE','Asheville Highway & South 40, SC 29303, USA'),(60,'Wake','Wake County Sheriff\'s Office','2114 S Main St, Wake Forest, NC','2114 S Main St','Wake Forest','NC',27587,35.9524726867676,-78.5349578857422,'2014-08-25 18:23:51','Google','ROOFTOP','2114 South Main Street, Wake Forest, NC 27587, USA'),(61,'Wake','Wake County Sheriff\'s Office','3608 Davis Dr/lake Grove Blvd, Morrisville, NC','3608 Davis Dr','Morrisville','NC',27560,35.8215637207031,-78.8475570678711,'2014-08-25 18:23:51','Google','ROOFTOP','3608 Davis Drive, Morrisville, NC 27560, USA'),(62,'Wake','Wake County Sheriff\'s Office','9799 Chapel Hill Rd/ridgemere Dr, Morrisville, NC','9799 Chapel Hill Rd','Morrisville','NC',27560,35.8082504272461,-78.8146667480469,'2014-08-25 18:23:52','Google','RANGE_INTERPOLATED','9799 Chapel Hill Road, Morrisville, NC 27560, USA'),(63,'Wake','Wake County Sheriff\'s Office','10249 Chapel Hill Rd/green Dr, Morrisville, NC','10249 Chapel Hill Rd','Morrisville','NC',27560,35.8303108215332,-78.8270263671875,'2014-08-25 18:23:52','Google','RANGE_INTERPOLATED','10249 Chapel Hill Road, Morrisville, NC 27560, USA'),(64,'New Hanover','Wilmington Police Department','4184 Abbington Ter, Wilmington, NC','4184 Abbington Terrace','Wilmington','NC',28403,34.2027511596680,-77.8947982788086,'2014-08-25 18:23:52','Google','RANGE_INTERPOLATED','4184 Abbington Terrace, Wilmington, NC 28403, USA'),(65,'Wake','Wake County Sheriff\'s Office','725 Heather Park Dr, Garner, NC','725 Heather Park Dr','Garner','NC',27529,35.6914329528809,-78.6168518066406,'2014-08-25 18:23:53','Google','RANGE_INTERPOLATED','725 Heather Park Drive, Garner, NC 27529, USA'),(66,'Wake','Wake County Sheriff\'s Office','101 Timber Dr, Garner, NC','101 Timber Dr','Garner','NC',27529,35.6856002807617,-78.6044158935547,'2014-08-25 18:23:53','Google','ROOFTOP','101 Timber Drive, Garner, NC 27529, USA'),(67,'Wake','Wake County Sheriff\'s Office','1225 Us 70 Hwy W, Garner, NC','1225 US-70','Garner','NC',27529,35.7176246643066,-78.6372604370117,'2014-08-25 18:23:54','Google','ROOFTOP','1225 U.S. 70, Garner, NC 27529, USA'),(68,'Wake','Wake County Sheriff\'s Office','2520 Timber Dr, Garner, NC','2520 Timber Dr','Garner','NC',27529,35.7138786315918,-78.6398315429688,'2014-08-25 18:23:54','Google','ROOFTOP','2520 Timber Drive, Garner, NC 27529, USA'),(69,'Wake','Wake County Sheriff\'s Office','4305 Fayetteville Rd, Garner, NC','4305 Fayetteville Rd','Raleigh','NC',27603,35.7204627990723,-78.6530685424805,'2014-08-25 18:23:55','Google','ROOFTOP','4305 Fayetteville Road, Raleigh, NC 27603, USA'),(70,'Guilford','Greensboro Police Department','1205 Martin Luther King Jr Dr, Greensboro, NC','1205 Martin Luther King Jr Dr','Greensboro','NC',27406,36.0561141967773,-79.7840042114258,'2014-08-25 18:23:55','Google','ROOFTOP','1205 Martin Luther King Junior Drive, Greensboro, NC 27406, USA'),(71,'Wake','Wake County Sheriff\'s Office','914 Edgemont Rd, Wendell, NC','914 Edgemont Rd','Wendell','NC',27591,35.8031501770020,-78.3995742797852,'2014-08-25 18:23:55','Google','RANGE_INTERPOLATED','914 Edgemont Road, Wendell, NC 27591, USA'),(72,'Wake','Wake County Sheriff\'s Office','450 E. Third Street, Wendell, NC','450 E 3rd St','Wendell','NC',27591,35.7801437377930,-78.3625183105469,'2014-08-25 18:23:56','Google','ROOFTOP','450 East 3rd Street, Wendell, NC 27591, USA'),(73,'Wake','Wake County Sheriff\'s Office','505 Wendell Blvd, Wendell','505 State Rd 1701','Wendell','NC',27591,35.7022018432617,-78.3720550537109,'2014-08-25 18:23:56','Google','ROOFTOP','505 Wendell Road, Wendell, NC 27591, USA'),(74,'Wake','Wake County Sheriff\'s Office','95 Northwinds North, Wendell','95 Northwinds N Dr','Wendell','NC',27591,35.8006477355957,-78.3564682006836,'2014-08-25 18:23:57','Google','ROOFTOP','95 Northwinds North Drive, Wendell, NC 27591, USA'),(75,'Wake','Wake County Sheriff\'s Office','450 E Third St, Wendell','450 E 3rd St','Wendell','NC',27591,35.7801437377930,-78.3625183105469,'2014-08-25 18:23:57','Google','ROOFTOP','450 East 3rd Street, Wendell, NC 27591, USA'),(76,'Wake','Wake County Sheriff\'s Office','505 Wendell Blvd, Wendell, NC','505 State Rd 1701','Wendell','NC',27591,35.7022018432617,-78.3720550537109,'2014-08-25 18:23:58','Google','ROOFTOP','505 Wendell Road, Wendell, NC 27591, USA'),(77,'Wake','Wake County Sheriff\'s Office','2921 Wendell Blvd, Wendell','2921 Wendell Blvd','Wendell','NC',27591,35.7921333312988,-78.3777008056641,'2014-08-25 18:23:58','Google','ROOFTOP','2921 Wendell Boulevard, Wendell, NC 27591, USA'),(78,'Wake','Wake County Sheriff\'s Office','2000 Wendell Blvd., Wendell, NC','2000 Wendell Blvd','Wendell','NC',27591,35.8011283874512,-78.3930053710938,'2014-08-25 18:23:59','Google','RANGE_INTERPOLATED','2000 Wendell Boulevard, Wendell, NC 27591, USA'),(79,'Wake','Wake County Sheriff\'s Office','15 Bobbitt St, Wendell, NC','15 Bobbitt St','Wendell','NC',27591,35.7813529968262,-78.3589248657227,'2014-08-25 18:23:59','Google','ROOFTOP','15 Bobbitt Street, Wendell, NC 27591, USA'),(80,'Cumberland','Fayetteville Police Department','7135 CLIFFDALE RD/MARSHTREE LN, Cumberland County, NC','7135 Cliffdale Rd','Fayetteville','NC',28314,35.0624885559082,-79.0177459716797,'2014-08-25 18:24:44','Google','RANGE_INTERPOLATED','7135 Cliffdale Road, Fayetteville, NC 28314, USA'),(81,'Cumberland','Fayetteville Police Department','2509 MURCHISON RD/MCLAMB DR, Cumberland County, NC','2509 Murchison Rd','Fayetteville','NC',28301,35.0891876220703,-78.9088363647461,'2014-08-25 19:32:10','Google','RANGE_INTERPOLATED','2509 Murchison Road, Fayetteville, NC 28301, USA'),(82,'Cumberland','Fayetteville Police Department','1999 SKIBO RD/CLIFFDALE RD, Cumberland County, NC','1999 Skibo Rd','Fayetteville','NC',28314,35.0594444274902,-78.9699783325195,'2014-08-25 19:32:11','Google','RANGE_INTERPOLATED','1999 Skibo Road, Fayetteville, NC 28314, USA'),(83,'Caldwell','Lenoir Police Department','298 NE LOWER CREEK DR/NE EASTOVER CIR, Cladwell County, NC','298 Lower Creek Dr NE','Lenoir','NC',28645,35.9183235168457,-81.5180892944336,'2014-08-25 19:32:11','Google','RANGE_INTERPOLATED','298 Lower Creek Drive Northeast, Lenoir, NC 28645, USA'),(84,'Cumberland','Fayetteville Police Department','1936 GILLESPIE ST/CROSSOVER, Cumberland County, NC','1936 Gillespie St','Fayetteville','NC',28306,35.0230636596680,-78.8947448730469,'2014-08-25 19:32:12','Google','RANGE_INTERPOLATED','1936 Gillespie Street, Fayetteville, NC 28306, USA'),(85,'Cabarrus','Kannapolis Police Department','4999 MOORESVILLE RD/CHARLIE WALKER RD, Cabarrus County, NC','4999 Mooresville Rd','Kannapolis','NC',28081,35.4884490966797,-80.6626510620117,'2014-08-25 19:32:12','Google','RANGE_INTERPOLATED','4999 Mooresville Road, Kannapolis, NC 28081, USA'),(86,'Cumberland','Fayetteville Police Department','325 OWEN DR/ALL AMERICAN EXP, Cumberland County, NC','325 Owen Dr','Fayetteville','NC',28304,35.0397148132324,-78.9337615966797,'2014-08-25 19:32:13','Google','RANGE_INTERPOLATED','325 Owen Drive, Fayetteville, NC 28304, USA'),(87,'Cabarrus','Kannapolis Police Department','1939 TRINITY CHURCH RD/DELANEY DR, Cabarrus County, NC','1939 Trinity Church Rd','Concord','NC',28027,35.4377174377441,-80.6582412719727,'2014-08-25 19:32:13','Google','RANGE_INTERPOLATED','1939 Trinity Church Road, Concord, NC 28027, USA'),(88,'Cumberland','Fayetteville Police Department','557 N MCPHERSON CHURCH RD/SKIBO RD, Cumberland County, NC','557 N McPherson Church Rd','Fayetteville','NC',28303,35.0766944885254,-78.9544525146484,'2014-08-25 19:32:14','Google','RANGE_INTERPOLATED','557 North McPherson Church Road, Fayetteville, NC 28303, USA'),(89,'Cumberland','Fayetteville Police Department','8148 ENGLISH SADDLE DR/RIM RD, Cumberland County, NC','8148 English Saddle Dr','Fayetteville','NC',28314,35.0527534484863,-79.0448226928711,'2014-08-25 19:32:14','Google','RANGE_INTERPOLATED','8148 English Saddle Drive, Fayetteville, NC 28314, USA'),(90,'Wake','Wake County Sheriff\'s Office','609 S East St, Raleigh, NC','609 S East St','Raleigh','NC',27601,35.7722663879395,-78.6321868896484,'2014-08-25 19:32:14','Google','ROOFTOP','609 South East Street, Raleigh, NC 27601, USA'),(91,'Wake','Wake County Sheriff\'s Office','899 Us 64 Hwy W/lake Pine Dr, Apex, NC','899 US-64','Apex','NC',27523,35.7443504333496,-78.8241653442383,'2014-08-25 19:32:15','Google','RANGE_INTERPOLATED','899 U.S. 64, Apex, NC 27523, USA'),(92,'Edgecombe','Rocky Mount Police Department','621 Redgate Ave/cokey Rd, Rocky Mount, NC','621 Redgate Ave','Rocky Mount','NC',27801,35.9321060180664,-77.7915573120117,'2014-08-25 19:32:15','Google','RANGE_INTERPOLATED','621 Redgate Avenue, Rocky Mount, NC 27801, USA'),(93,'Union','Union County Sheriff\'s Office','2101 Younts Rd, Indian Trail, NC','2101 State Rd 1519','Indian Trail','NC',28079,35.0786590576172,-80.6498565673828,'2014-08-25 19:32:16','Google','ROOFTOP','2101 Younts Road, Indian Trail, NC 28079, USA'),(94,'Union','Union County Sheriff\'s Office','400 N Main St, Monroe, NC','400 N Main St','Monroe','NC',28112,34.9829177856445,-80.5499191284180,'2014-08-25 19:32:16','Google','ROOFTOP','400 North Main Street, Monroe, NC 28112, USA'),(95,'Wilson','Wilson County Sheriff\'s Office','400-BLK Ward Blvd/hood St Sw, Wilson, NC','Ward Blvd','Wilson','NC',27893,35.7103996276855,-77.9299163818359,'2014-08-25 19:32:17','Google','APPROXIMATE','Ward Boulevard & Hood Street Southwest, Wilson, NC 27893, USA'),(96,'Wilson','Wilson County Sheriff\'s Office','100-BLK Nash St S/pender St S, Wilson, NC','Nash St E','Wilson','NC',27893,35.7203636169434,-77.9055557250977,'2014-08-25 19:32:17','Google','APPROXIMATE','Nash Street East & Pender Street South, Wilson, NC 27893, USA'),(97,'Union','Union County Sheriff\'s Office','504 Colony Rd, Monroe, NC','504 Colony Rd','Monroe','NC',28112,34.9851188659668,-80.5664062500000,'2014-08-25 19:32:18','Google','ROOFTOP','504 Colony Road, Monroe, NC 28112, USA'),(98,'Buncombe','Buncombe County Sheriff\'s Office','248 Patton Ave/clingman Ave, Asheville, NC','248 Patton Ave','Asheville','NC',28801,35.5928153991699,-82.5614013671875,'2014-08-25 19:32:18','Google','ROOFTOP','248 Patton Avenue, Asheville, NC 28801, USA'),(99,'Guilford','Greensboro Police Department','894 E Lee St, Greensboro, NC','894 E Lee St','Greensboro','NC',27406,36.0647926330566,-79.7783508300781,'2014-08-25 19:32:18','Google','RANGE_INTERPOLATED','894 East Lee Street, Greensboro, NC 27406, USA'),(100,'Guilford','Greensboro Police Department','1499 E Lee St/logan St, Greensboro, NC','1499 E Lee St','Greensboro','NC',27401,36.0645179748535,-79.7724456787109,'2014-08-25 19:32:19','Google','RANGE_INTERPOLATED','1499 East Lee Street, Greensboro, NC 27401, USA'),(101,'Guilford','Greensboro Police Department','1235 S Eugene St, Greensboro, NC','1235 S Eugene St','Greensboro','NC',27406,36.0598564147949,-79.7926025390625,'2014-08-25 19:32:19','Google','ROOFTOP','1235 South Eugene Street, Greensboro, NC 27406, USA'),(102,'New Hanover','New Hanover County Sheriff\'s Office','S 13th/marstellar, Wilmington','S 13th St','Wilmington','NC',28401,34.2214889526367,-77.9310302734375,'2014-08-25 19:32:20','Google','APPROXIMATE','South 13th Street & Marstellar Street, Wilmington, NC 28401, USA'),(103,'New Hanover','New Hanover County Sheriff\'s Office','Grace Street/17th St, Wilmington','Grace St','Wilmington','NC',28405,34.2403450012207,-77.9280014038086,'2014-08-25 19:32:20','Google','APPROXIMATE','Grace Street & North 17th Street, Wilmington, NC 28405, USA'),(104,'Guilford','Greensboro Police Department','3199 N Elm St/corporate Center Blvd, Greensboro, NC','3199 N Elm St','Greensboro','NC',27408,36.1231346130371,-79.7963638305664,'2014-08-25 19:32:21','Google','RANGE_INTERPOLATED','3199 North Elm Street, Greensboro, NC 27408, USA'),(105,'Wake','Wake County Sheriff\'s Office','200 Virginia Water Dr, Rolesville, NC','200 Virginia Water Dr','Rolesville','NC',27571,35.9080276489258,-78.4726715087891,'2014-08-25 19:32:21','Google','RANGE_INTERPOLATED','200 Virginia Water Drive, Rolesville, NC 27571, USA'),(106,'Wake','Wake County Sheriff\'s Office','100 N Main St, Rolesville, NC','100 N Main St','Rolesville','NC',27571,35.9234275817871,-78.4566497802734,'2014-08-25 19:32:22','Google','ROOFTOP','100 North Main Street, Rolesville, NC 27571, USA'),(107,'Union','Union County Sheriff\'s Office','914 E. Sunset Drive, Monroe','914 E Sunset Dr','Monroe','NC',28112,34.9707641601562,-80.5332489013672,'2014-08-25 19:32:22','Google','RANGE_INTERPOLATED','914 East Sunset Drive, Monroe, NC 28112, USA'),(108,'Wake','Wake County Sheriff\'s Office','Hilltop Needmore Rd/muirfield Rd, Fuquay Varina','Hilltop Needmore Rd','Fuquay Varina','NC',27526,35.6301345825195,-78.7700271606445,'2014-08-25 19:32:23','Google','APPROXIMATE','Hilltop Needmore Road & Muirfield Road Exd, Fuquay Varina, NC 27526, USA'),(109,'Wake','Wake County Sheriff\'s Office','3430 Wendell Blvd, Wendell','3430 Wendell Blvd','Wendell','NC',27591,35.7842025756836,-78.3711929321289,'2014-08-25 19:32:23','Google','ROOFTOP','3430 Wendell Boulevard, Wendell, NC 27591, USA'),(110,'Wake','Wake County Sheriff\'s Office','2800 Wendell Blvd, Wendell, NC','2800 Wendell Blvd','Wendell','NC',27591,35.7946052551270,-78.3807983398438,'2014-08-25 19:32:23','Google','RANGE_INTERPOLATED','2800 Wendell Boulevard, Wendell, NC 27591, USA'),(111,'Wake','Wake County Sheriff\'s Office','7 Rosewood Ct., Wendell, NC','7 Rosewood Ct','Wendell','NC',27591,35.7809524536133,-78.3581008911133,'2014-08-25 19:32:24','Google','RANGE_INTERPOLATED','7 Rosewood Court, Wendell, NC 27591, USA'),(112,'Wake','Wake County Sheriff\'s Office','450 E. Third St, Wendell, NC','450 E 3rd St','Wendell','NC',27591,35.7801437377930,-78.3625183105469,'2014-08-25 19:32:25','Google','ROOFTOP','450 East 3rd Street, Wendell, NC 27591, USA'),(113,'Wake','Wake County Sheriff\'s Office','900 Poole Rd, Wendell','900 Poole Rd','Wendell','NC',27591,35.7747497558594,-78.3995971679688,'2014-08-25 19:32:26','Google','RANGE_INTERPOLATED','900 Poole Road, Wendell, NC 27591, USA');
/*!40000 ALTER TABLE `geocoded_addresses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-25 15:35:53
