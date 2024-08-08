-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2023 at 05:50 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database`
--

-- --------------------------------------------------------

--
-- Table structure for table `registration_center`
--

CREATE TABLE `registration_center` (
  `user_id` int(11) NOT NULL,
  `user_type` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `skill`
--

CREATE TABLE `skill` (
  `skill_id` int(11) NOT NULL,
  `skill_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `worker`
--

CREATE TABLE `worker` (
  `worker_id` int(11) NOT NULL,
  `wfirst_name` varchar(250) DEFAULT NULL,
  `wlast_name` varchar(300) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `skill_id` int(11) DEFAULT NULL,
  `wgender` varchar(270) DEFAULT NULL,
  `wcity` varchar(150) DEFAULT NULL,
  `wstate` varchar(230) DEFAULT NULL,
  `wpin_code` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`worker_id`),
  KEY `user_id` (`user_id`),
  KEY `skill_id` (`skill_id`),
  CONSTRAINT `worker_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `registration_center` (`user_id`),
  CONSTRAINT `worker_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `skill` (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

-- Table structure for table `client`
CREATE TABLE `client` (
  `client_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cfirst_name` varchar(220) DEFAULT NULL,
  `clast_name` varchar(220) DEFAULT NULL,
  `ccity` varchar(220) DEFAULT NULL,
  `cstate` varchar(220) DEFAULT NULL,
  `cpin_code` varchar(220) DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `client_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `registration_center` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_phonenumber`
--

CREATE TABLE `client_phonenumber` (
  `client_id` int(11) DEFAULT NULL,
  `cphone_numnber` varchar(220) DEFAULT NULL,
  KEY `client_id` (`client_id`),
  CONSTRAINT `client_phonenumber_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `worker_phonenumber`
--

CREATE TABLE `worker_phonenumber` (
  `worker_id` int(11) DEFAULT NULL,
  `wphone_number` varchar(100) DEFAULT NULL,
  KEY `worker_id` (`worker_id`),
  CONSTRAINT `worker_phonenumber_ibfk_1` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`worker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `worker_id` int(11) DEFAULT NULL,
  `payment_method` varchar(450) DEFAULT NULL,
  `payment_amount` float DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `client_id` (`client_id`),
  KEY `worker_id` (`worker_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`worker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pay`
--

CREATE TABLE `pay` (
  `client_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  KEY `client_id` (`client_id`),
  KEY `payment_id` (`payment_id`),
  CONSTRAINT `pay_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`),
  CONSTRAINT `pay_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receive`
--

CREATE TABLE `receive` (
  `worker_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  KEY `worker_id` (`worker_id`),
  KEY `payment_id` (`payment_id`),
  CONSTRAINT `receive_ibfk_1` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`worker_id`),
  CONSTRAINT `receive_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
