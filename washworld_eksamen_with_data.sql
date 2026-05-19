-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Generation Time: May 12, 2026 at 11:42 AM
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
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `car_id` char(32) NOT NULL,
  `car_plate` varchar(20) NOT NULL,
  `car_user_fk` char(32) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) DEFAULT NULL,
  `deleted_at` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`car_id`, `car_plate`, `car_user_fk`, `created_at`, `updated_at`, `deleted_at`) VALUES
('94e59d4671dc466fb5f5e9815f0efc63', 'AB12345', '75b6b906024e4f49a214fbade6439f68', 1778584500, NULL, NULL);

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

--
-- Dumping data for table `memberships`
--

INSERT INTO `memberships` (`membership_id`, `membership_name`, `membership_description`, `membership_price`, `is_active`) VALUES
('46514f804c0111f18db996d21e5e70c2', 'Guld', 'Skumforvask\r\nAktiv shampoo\r\nHjulvask\r\nHøjtryksvask\r\nAktiv Børstevask\r\nVoks\r\nTørring', 139, 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateway`
--

CREATE TABLE `payment_gateway` (
  `payment_gateway_id` char(32) NOT NULL,
  `payment_gateway_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_gateway`
--

INSERT INTO `payment_gateway` (`payment_gateway_id`, `payment_gateway_name`) VALUES
('ed1aeb774ca211f18db996d21e5e70c2', 'MobilePay'),
('ed1afe714ca211f18db996d21e5e70c2', 'ApplePay'),
('ed1affe14ca211f18db996d21e5e70c2', 'PayPal');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` char(32) NOT NULL,
  `transaction_user_fk` char(32) NOT NULL,
  `transaction_gateway_fk` char(32) NOT NULL,
  `transaction_membership_fk` char(32) NOT NULL,
  `payment_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `transaction_user_fk`, `transaction_gateway_fk`, `transaction_membership_fk`, `payment_at`) VALUES
('68f1e7cdfe564ba39f4aca0a8277de6f', '75b6b906024e4f49a214fbade6439f68', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778584500);

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
  `user_email` varchar(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `deleted_at` bigint(20) DEFAULT NULL,
  `user_verification_key` char(32) DEFAULT NULL,
  `user_verified_at` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_last_name`, `user_adress`, `user_phone`, `user_email`, `user_password`, `created_at`, `deleted_at`, `user_verification_key`, `user_verified_at`) VALUES
('75b6b906024e4f49a214fbade6439f68', 'Sophie', 'Hjelm', '12 Main Street, Copenhagen, DK 2200', 12345678, 'sophie@hjelm.name', 'scrypt:32768:8:1$msbiixlzY23ZlDYR$67bf6340ee0877e165ee0750b68676a96a16a881ed75b451789082b90d8df7e940410b96f6afde4b41dde845119c7ef4e24340315370edbf11ca749178e4585b', 1778584500, NULL, 'ede41751a6474e56a27c096f49c80464', NULL),
('e5384bce264e4ed58f13694621aaef50', 'Sophie', 'Hjelm', '12 Main Street, Copenhagen, DK 2400', 12345678, 'sophiehjelm0@gmail.com', 'scrypt:32768:8:1$OnSN0mkVPPJXRTmK$fa96a226f87ee17cf5dded5b82803240fc6ab6548575da563c31f9312096b147b8b5556d24ec5fe90a66bcbfefd911d73a82d3f8dd3a3a6a831a97b077dbf6e7', 1778513887, NULL, '7b454abb4da946abad610ee084102840', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_memberships`
--

CREATE TABLE `user_memberships` (
  `user_memberships_id` char(32) NOT NULL,
  `membership_user_fk` char(32) NOT NULL,
  `membership_fk` char(32) NOT NULL,
  `start_date` bigint(20) NOT NULL,
  `end_date` bigint(20) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_memberships`
--

INSERT INTO `user_memberships` (`user_memberships_id`, `membership_user_fk`, `membership_fk`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
('b3ba1aefa4744b6f83ba304859c27b2c', '75b6b906024e4f49a214fbade6439f68', '46514f804c0111f18db996d21e5e70c2', 1778584500, NULL, 'active', 1778584500, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`car_id`),
  ADD KEY `user_fk` (`car_user_fk`);

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
  ADD PRIMARY KEY (`payment_gateway_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`),
  ADD UNIQUE KEY `user_verification_key` (`user_verification_key`);

--
-- Indexes for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD PRIMARY KEY (`user_memberships_id`),
  ADD UNIQUE KEY `user_fk` (`membership_user_fk`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`car_user_fk`) REFERENCES `users` (`user_id`);

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
  ADD CONSTRAINT `membership_id_price` FOREIGN KEY (`transaction_membership_fk`) REFERENCES `memberships` (`membership_id`),
  ADD CONSTRAINT `payment_method` FOREIGN KEY (`transaction_gateway_fk`) REFERENCES `payment_gateway` (`payment_gateway_id`),
  ADD CONSTRAINT `user_transaction` FOREIGN KEY (`transaction_user_fk`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD CONSTRAINT `user_memberships_ibfk_1` FOREIGN KEY (`membership_user_fk`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_memberships_ibfk_2` FOREIGN KEY (`membership_fk`) REFERENCES `memberships` (`membership_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
