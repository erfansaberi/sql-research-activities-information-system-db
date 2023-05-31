SET FOREIGN_KEY_CHECKS=0;

--
-- Table structure for table `persons`
--

DROP TABLE IF EXISTS `persons`;
CREATE TABLE `persons` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ssn` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `institute_types`
--

DROP TABLE IF EXISTS `institute_types`;
CREATE TABLE `institute_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `institutes`
--

DROP TABLE IF EXISTS `institutes`;
CREATE TABLE `institutes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type_id` int unsigned NOT NULL,
  `current_budget` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `institutes_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `institute_types` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `buildings`
--

DROP TABLE IF EXISTS `buildings`;
CREATE TABLE `buildings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `institute_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `institute_id` (`institute_id`),
  CONSTRAINT `buildings_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `conferences`
--

DROP TABLE IF EXISTS `conferences`;
CREATE TABLE `conferences` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `conference_committees`
--

DROP TABLE IF EXISTS `conference_committees`;
CREATE TABLE `conference_committees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `conference_cooperations`
--

DROP TABLE IF EXISTS `conference_cooperations`;
CREATE TABLE `conference_cooperations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` int unsigned NOT NULL,
  `person_id` int unsigned NOT NULL,
  `committee_id` int unsigned NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_id` (`conference_id`),
  KEY `person_id` (`person_id`),
  KEY `committee_id` (`committee_id`),
  CONSTRAINT `conference_cooperations_ibfk_1` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `conference_cooperations_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `conference_cooperations_ibfk_3` FOREIGN KEY (`committee_id`) REFERENCES `conference_committees` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `conference_papers`
--

DROP TABLE IF EXISTS `conference_papers`;
CREATE TABLE `conference_papers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `pages_number` int unsigned DEFAULT NULL,
  `admition_date` date DEFAULT NULL,
  `submision_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_id` (`conference_id`),
  CONSTRAINT `conference_papers_ibfk_1` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
CREATE TABLE `contracts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `research_activity_id` int unsigned NOT NULL,
  `person_id` int unsigned NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `duties` text,
  `salary` double DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `research_activity_id` (`research_activity_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`research_activity_id`) REFERENCES `research_activities` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `educations`
--

DROP TABLE IF EXISTS `educations`;
CREATE TABLE `educations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int unsigned NOT NULL,
  `university_id` int unsigned NOT NULL,
  `field_of_study_id` int unsigned NOT NULL,
  `degree_id` int unsigned NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `grade` decimal(2,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `university_id` (`university_id`),
  KEY `field_of_study_id` (`field_of_study_id`),
  KEY `degree_id` (`degree_id`),
  CONSTRAINT `educations_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `educations_ibfk_2` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `educations_ibfk_3` FOREIGN KEY (`field_of_study_id`) REFERENCES `fields_of_study` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `educations_ibfk_4` FOREIGN KEY (`degree_id`) REFERENCES `study_degrees` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `equipment_assignments`
--

DROP TABLE IF EXISTS `equipment_assignments`;
CREATE TABLE `equipment_assignments` (
  `research_activity_id` int unsigned NOT NULL,
  `person_id` int unsigned NOT NULL,
  `equipment_id` int unsigned NOT NULL,
  `assigned_at` datetime DEFAULT NULL,
  PRIMARY KEY (`research_activity_id`,`person_id`,`equipment_id`),
  KEY `person_id` (`person_id`),
  KEY `equipment_id` (`equipment_id`),
  CONSTRAINT `equipment_assignments_ibfk_1` FOREIGN KEY (`research_activity_id`) REFERENCES `research_activities` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `equipment_assignments_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `equipment_assignments_ibfk_3` FOREIGN KEY (`equipment_id`) REFERENCES `equipments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `equipments`
--

DROP TABLE IF EXISTS `equipments`;
CREATE TABLE `equipments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `favorite_research_areas`
--

DROP TABLE IF EXISTS `favorite_research_areas`;
CREATE TABLE `favorite_research_areas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `person_id` int unsigned NOT NULL,
  `area_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `favorite_research_areas_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favorite_research_areas_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `research_areas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `fields_of_study`
--

DROP TABLE IF EXISTS `fields_of_study`;
CREATE TABLE `fields_of_study` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `financial_support_types`
--

DROP TABLE IF EXISTS `financial_support_types`;
CREATE TABLE `financial_support_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `institute_employments`
--

DROP TABLE IF EXISTS `institute_employments`;
CREATE TABLE `institute_employments` (
  `person_id` int unsigned NOT NULL,
  `institute_id` int unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_administration` tinyint(1) NOT NULL DEFAULT (false),
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_id`,`institute_id`),
  KEY `institute_id` (`institute_id`),
  CONSTRAINT `institute_employments_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `institute_employments_ibfk_2` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `institute_registrations`
--

DROP TABLE IF EXISTS `institute_registrations`;
CREATE TABLE `institute_registrations` (
  `person_id` int unsigned NOT NULL,
  `institute_id` int unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`person_id`,`institute_id`),
  KEY `institute_id` (`institute_id`),
  CONSTRAINT `institute_registrations_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `institute_registrations_ibfk_2` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `institute_work_areas`
--

DROP TABLE IF EXISTS `institute_work_areas`;
CREATE TABLE `institute_work_areas` (
  `institute_id` int unsigned NOT NULL,
  `area_id` int unsigned NOT NULL,
  PRIMARY KEY (`institute_id`,`area_id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `institute_work_areas_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `institute_work_areas_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `research_areas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `journal_committees`
--

DROP TABLE IF EXISTS `journal_committees`;
CREATE TABLE `journal_committees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `journal_employment`
--

DROP TABLE IF EXISTS `journal_employment`;
CREATE TABLE `journal_employment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` int unsigned NOT NULL,
  `person_id` int unsigned NOT NULL,
  `committee_id` int unsigned NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journal_id` (`journal_id`),
  KEY `person_id` (`person_id`),
  KEY `committee_id` (`committee_id`),
  CONSTRAINT `journal_employment_ibfk_1` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `journal_employment_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `journal_employment_ibfk_3` FOREIGN KEY (`committee_id`) REFERENCES `journal_committees` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `journal_papers`
--

DROP TABLE IF EXISTS `journal_papers`;
CREATE TABLE `journal_papers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `pages_number` int unsigned DEFAULT NULL,
  `admition_date` date DEFAULT NULL,
  `submision_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journal_id` (`journal_id`),
  CONSTRAINT `journal_papers_ibfk_1` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `journals`
--

DROP TABLE IF EXISTS `journals`;
CREATE TABLE `journals` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `poblisher_name` varchar(255) DEFAULT NULL,
  `is_international` tinyint(1) NOT NULL DEFAULT (false),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `research_activities`
--

DROP TABLE IF EXISTS `research_activities`;
CREATE TABLE `research_activities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` int unsigned NOT NULL,
  `type_id` int unsigned NOT NULL,
  `content_id` int unsigned NOT NULL,
  `officer_researcher_id` int unsigned NOT NULL,
  `office_building_id` int unsigned DEFAULT NULL,
  `is_international` tinyint(1) NOT NULL DEFAULT (false),
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `institute_id` (`institute_id`),
  KEY `type_id` (`type_id`),
  KEY `officer_researcher_id` (`officer_researcher_id`),
  KEY `office_building_id` (`office_building_id`),
  CONSTRAINT `research_activities_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `research_activities_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `research_activity_types` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `research_activities_ibfk_3` FOREIGN KEY (`officer_researcher_id`) REFERENCES `persons` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `research_activities_ibfk_4` FOREIGN KEY (`office_building_id`) REFERENCES `buildings` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `research_activity_areas`
--

DROP TABLE IF EXISTS `research_activity_areas`;
CREATE TABLE `research_activity_areas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `research_activity_id` int unsigned NOT NULL,
  `research_area_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `research_activity_id` (`research_activity_id`),
  KEY `research_area_id` (`research_area_id`),
  CONSTRAINT `research_activity_areas_ibfk_1` FOREIGN KEY (`research_activity_id`) REFERENCES `research_activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `research_activity_areas_ibfk_2` FOREIGN KEY (`research_area_id`) REFERENCES `research_areas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `research_activity_financial_supports`
--

DROP TABLE IF EXISTS `research_activity_financial_supports`;
CREATE TABLE `research_activity_financial_supports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` int unsigned NOT NULL,
  `research_activity_id` int unsigned NOT NULL,
  `type_id` int unsigned NOT NULL,
  `amount` double DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `institute_id` (`institute_id`),
  KEY `research_activity_id` (`research_activity_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `research_activity_financial_supports_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `research_activity_financial_supports_ibfk_2` FOREIGN KEY (`research_activity_id`) REFERENCES `research_activities` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `research_activity_financial_supports_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `financial_support_types` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `research_activity_salary_payments`
--

DROP TABLE IF EXISTS `research_activity_salary_payments`;
CREATE TABLE `research_activity_salary_payments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `research_activity_id` int unsigned NOT NULL,
  `researcher_id` int unsigned NOT NULL,
  `amount` double DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `research_activity_id` (`research_activity_id`),
  KEY `researcher_id` (`researcher_id`),
  CONSTRAINT `research_activity_salary_payments_ibfk_1` FOREIGN KEY (`research_activity_id`) REFERENCES `research_activities` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `research_activity_salary_payments_ibfk_2` FOREIGN KEY (`researcher_id`) REFERENCES `persons` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `research_activity_types`
--

DROP TABLE IF EXISTS `research_activity_types`;
CREATE TABLE `research_activity_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `research_areas`
--

DROP TABLE IF EXISTS `research_areas`;
CREATE TABLE `research_areas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `study_degrees`
--

DROP TABLE IF EXISTS `study_degrees`;
CREATE TABLE `study_degrees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `universities`
--

DROP TABLE IF EXISTS `universities`;
CREATE TABLE `universities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `workshops`
--

DROP TABLE IF EXISTS `workshops`;
CREATE TABLE `workshops` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `conference_id` int unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `start_date_time` datetime DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_id` (`conference_id`),
  CONSTRAINT `workshops_ibfk_1` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SET FOREIGN_KEY_CHECKS=1;