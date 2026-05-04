-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Generation Time: May 04, 2026 at 10:59 AM
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
-- Database: `washworld`
--

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `car_id` char(32) NOT NULL,
  `car_plate` varchar(20) NOT NULL,
  `user_fk` char(32) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  `deleted_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `location_id` char(32) NOT NULL,
  `location_name` varchar(100) NOT NULL,
  `location_adress` varchar(199) NOT NULL,
  `location_city` varchar(100) NOT NULL,
  `location_postal_code` varchar(20) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `location_services`
--

CREATE TABLE `location_services` (
  `location_service_id` char(32) NOT NULL,
  `location_fk` char(32) NOT NULL,
  `service_fk` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `memberships`
--

CREATE TABLE `memberships` (
  `membership_id` char(32) NOT NULL,
  `membership_name` varchar(100) NOT NULL,
  `membership_description` varchar(255) NOT NULL,
  `membership_price` decimal(10,0) NOT NULL,
  `is_active` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateway`
--

CREATE TABLE `payment_gateway` (
  `payment_id` char(32) NOT NULL,
  `payment_name` char(20) NOT NULL,
  `user_payment_fk` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` char(32) NOT NULL,
  `service_name` varchar(50) NOT NULL,
  `service_price` decimal(10,0) NOT NULL,
  `service_description` varchar(255) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` char(32) NOT NULL,
  `payment_amount` bigint(20) NOT NULL,
  `user_fk` char(32) NOT NULL,
  `service_fk` char(32) NOT NULL,
  `membership_fk` char(32) NOT NULL,
  `payment_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` char(32) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_last_name` varchar(20) NOT NULL,
  `user_adress` varchar(199) NOT NULL,
  `user_phone` bigint(20) NOT NULL,
  `user_email` varchar(20) NOT NULL,
  `user_payment_gateway_fk` char(32) NOT NULL,
  `user_password` varchar(20) NOT NULL,
  `user_created_at` bigint(20) NOT NULL,
  `user_deleted_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_memberships`
--

CREATE TABLE `user_memberships` (
  `user_memberships_id` char(32) NOT NULL,
  `user_fk` char(32) NOT NULL,
  `membership_fk` char(32) NOT NULL,
  `start_date` bigint(20) NOT NULL,
  `end_date` bigint(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`car_id`),
  ADD KEY `user_fk` (`user_fk`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `location_services`
--
ALTER TABLE `location_services`
  ADD PRIMARY KEY (`location_service_id`),
  ADD KEY `location_fk` (`location_fk`),
  ADD KEY `service_fk` (`service_fk`);

--
-- Indexes for table `memberships`
--
ALTER TABLE `memberships`
  ADD PRIMARY KEY (`membership_id`);

--
-- Indexes for table `payment_gateway`
--
ALTER TABLE `payment_gateway`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `user_payment_fk` (`user_payment_fk`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `user_fk` (`user_fk`,`service_fk`,`membership_fk`),
  ADD KEY `service_fk` (`service_fk`),
  ADD KEY `membership_fk` (`membership_fk`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`),
  ADD KEY `user_payment_gateway_fk` (`user_payment_gateway_fk`);

--
-- Indexes for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD PRIMARY KEY (`user_memberships_id`),
  ADD UNIQUE KEY `user_fk` (`user_fk`),
  ADD KEY `membership_fk` (`membership_fk`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`user_fk`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `location_services`
--
ALTER TABLE `location_services`
  ADD CONSTRAINT `location_services_ibfk_1` FOREIGN KEY (`location_fk`) REFERENCES `locations` (`location_id`),
  ADD CONSTRAINT `location_services_ibfk_2` FOREIGN KEY (`service_fk`) REFERENCES `services` (`service_id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_fk`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`service_fk`) REFERENCES `services` (`service_id`),
  ADD CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`membership_fk`) REFERENCES `memberships` (`membership_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_payment_gateway_fk`) REFERENCES `payment_gateway` (`payment_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `payment_gateway` (`user_payment_fk`);

--
-- Constraints for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD CONSTRAINT `user_memberships_ibfk_1` FOREIGN KEY (`user_fk`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_memberships_ibfk_2` FOREIGN KEY (`membership_fk`) REFERENCES `memberships` (`membership_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
