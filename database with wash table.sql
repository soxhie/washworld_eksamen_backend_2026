-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Generation Time: May 27, 2026 at 01:10 PM
-- Server version: 10.6.20-MariaDB-ubu2004
-- PHP Version: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `washworld_eksamen`
--

-- --------------------------------------------------------

--
-- Table structure for table `wash`
--

CREATE TABLE `wash` (
  `wash_id` char(32) NOT NULL,
  `membership_wash_fk` char(32) NOT NULL,
  `user_wash_fk` char(32) NOT NULL,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `wash`
--
ALTER TABLE `wash`
  ADD PRIMARY KEY (`wash_id`),
  ADD KEY `membership_wash_fk` (`membership_wash_fk`),
  ADD KEY `user_wash_fk` (`user_wash_fk`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `wash`
--
ALTER TABLE `wash`
  ADD CONSTRAINT `membership_wash_fk` FOREIGN KEY (`membership_wash_fk`) REFERENCES `user_memberships` (`membership_user_fk`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_wash_fk` FOREIGN KEY (`user_wash_fk`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
