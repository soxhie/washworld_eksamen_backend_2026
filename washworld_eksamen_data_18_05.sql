-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Generation Time: May 18, 2026 at 12:45 PM
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
  `car_plate` varchar(20) DEFAULT NULL,
  `car_user_fk` char(32) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) DEFAULT NULL,
  `deleted_at` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`car_id`, `car_plate`, `car_user_fk`, `created_at`, `updated_at`, `deleted_at`) VALUES
('c03231388f374b05887b85d4c6c4e546', 'AB12345', 'fd88d38fb4804b9093cdb7e3fe54ed17', 1778680487, NULL, NULL),
('dc72424ad65e494492f37ba0ebeef8fc', 'AB12345', '003dea0d714e42c8b6416af02a92a631', 1778761898, NULL, NULL);

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
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `transaction_user_fk`, `transaction_gateway_fk`, `transaction_membership_fk`, `created_at`) VALUES
('07bca31ff0d84e7aa7e93922a6f63124', '89f0c6014c7043ce8aa1e6c051dc17ab', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778662487),
('0835233bdfde4ac38aa10a7561aebd17', '34d21391141f47bc8ead25fcebdfc7b3', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778664284),
('28023acbeb414d549f5f12674a51fad2', '003dea0d714e42c8b6416af02a92a631', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778761898),
('3613d8b1b2b04b48afb21c80d3658b49', '53796bf8053a4f0a882c598c76ded87b', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778664830),
('38975e0eb8f340fb8d4bbf43e4cbab59', 'fd88d38fb4804b9093cdb7e3fe54ed17', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778680487),
('3b3f899155e14990954bd3b6c0678258', 'b7d25603529147f29dde25f83309cea0', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778664903),
('4fc5cd1f1dc04e0b82c933e36fed79c9', 'af551f1ebb9a449bb5061cf07381d3fb', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778664390),
('50c3dc65b8a5420e95b70e39e6d5ebf4', '6f4d3ba037a24683952784af4b260c6c', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778761191),
('5ebf49b124e14b4988f150634d2cceee', '7ca9095d361046e4834ef83bd51c4b53', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778668182),
('71b858b8ad134b71b3e1297c2e10ab67', '6872ad70ebbf49c3993c9215acf74eca', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778678956),
('901ab63c40d5427eb4329f7faa41be81', 'c4965eb7f8cc4043927ed8237299175d', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778665177),
('91d442ca16f448c8a7b530665fa367c4', '223c9bf7b2384f20a2bfe6e80d77c5db', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778661499),
('a2ddfa7023394b3f8df03a37eab11711', '54672277984942559848159e5c8f5d45', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778759855),
('a57b042717e247eb8552fdbee8296080', '953723140270494fbe81bff61a969c9a', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778665054),
('c1ccbbecbb4b451e990287e775f85352', 'ec7b89964d4a4492b8b8928a4c2fffbb', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778677781),
('c496953b01fd4c52a8cddcb2cc4e607b', '9dff426e89534855bbb2cc964cfb9db5', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778761804),
('d3ea5a31b8304eefa993f395023d4d0e', '3c8ba02e4c20460bbefe4d3a3478ffb1', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778592068),
('d4cc79fb0cbf4e33b3353e3e991b95c8', '05d45d8b24fc4014bfb6be05b2adaccf', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778673132),
('e8f028ff01f8447e8db09ee4b66e21ef', 'cc572ed36b064e53a7e0623efa09dfcf', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778661461),
('f1d453315d2e471e9d28640eadcac4ad', '67f1328af8dd4e83a30b8836245abd4e', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778661083),
('f700092d13db44ecbc3deda87d3cbe8b', '713145cbafe14a738a87c14521067bcb', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1778662576);

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
  `user_verified_at` bigint(20) DEFAULT NULL,
  `user_reset_password_key` char(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_last_name`, `user_adress`, `user_phone`, `user_email`, `user_password`, `created_at`, `deleted_at`, `user_verification_key`, `user_verified_at`, `user_reset_password_key`) VALUES
('003dea0d714e42c8b6416af02a92a631', 'PasswordTest', 'Test', '12 Main Street, Copenhagen, DK 2200', 12345678, 'sophiehjelm010203@gmail.com', 'scrypt:32768:8:1$xwhkTq3WNOd1zTJ1$d5752a9457d489dc1de5f2a089f3ac845e337293710b93f996916f6d8a228b4b6bb6c2db13c581798c82031a8b9629087f2f89c39147131dcc3070ebc085f07f', 1778761898, NULL, '837ffe541def4aeaa3a7da228475e7bb', 1778761906, NULL),
('fd88d38fb4804b9093cdb7e3fe54ed17', 'Test 5', 'Test 5', '12 Main Street, Copenhagen, DK 2200', 12345678, 'test@gmail.com', 'scrypt:32768:8:1$MTFzhXFmGXVefiIq$363f44543c3f26a12bd128478373eddc5122e3eeeee6b3d30cc026784426673067e8b1ec9a3895bb3905c9ebdf10e36313e70fd034c14fc1be3c9134b5288d5a', 1778680487, NULL, 'aea4fb0dfc414f23acdcf0e286a932ed', NULL, NULL);

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
('11466c03dc2147258290a262a79a73ad', 'ec7b89964d4a4492b8b8928a4c2fffbb', '46514f804c0111f18db996d21e5e70c2', 1778677781, NULL, 'active', 1778677781, NULL),
('1382783f3f94463aaa4db090233ea1fb', '6f4d3ba037a24683952784af4b260c6c', '46514f804c0111f18db996d21e5e70c2', 1778761191, NULL, 'active', 1778761191, NULL),
('247501d0aba749a09a3e45487d9f8e40', '89f0c6014c7043ce8aa1e6c051dc17ab', '46514f804c0111f18db996d21e5e70c2', 1778662487, NULL, 'active', 1778662487, NULL),
('2f139c357c924db2a40a603946630db9', '3c8ba02e4c20460bbefe4d3a3478ffb1', '46514f804c0111f18db996d21e5e70c2', 1778592068, NULL, 'active', 1778592068, NULL),
('52fc4626949740e9babc98e3f9890fc6', 'cc572ed36b064e53a7e0623efa09dfcf', '46514f804c0111f18db996d21e5e70c2', 1778661461, NULL, 'active', 1778661461, NULL),
('66d26f0794bb4a1da2dcc7085904677a', '223c9bf7b2384f20a2bfe6e80d77c5db', '46514f804c0111f18db996d21e5e70c2', 1778661499, NULL, 'active', 1778661499, NULL),
('70bfe52756f44bb5a215af6f8348b3be', '05d45d8b24fc4014bfb6be05b2adaccf', '46514f804c0111f18db996d21e5e70c2', 1778673132, NULL, 'active', 1778673132, NULL),
('75ac16ee257e4a0a9296ac0a508282a8', '34d21391141f47bc8ead25fcebdfc7b3', '46514f804c0111f18db996d21e5e70c2', 1778664284, NULL, 'active', 1778664284, NULL),
('835af247fefa4a7e9e88b0671be111e8', '6872ad70ebbf49c3993c9215acf74eca', '46514f804c0111f18db996d21e5e70c2', 1778678956, NULL, 'active', 1778678956, NULL),
('88770afea5ce49b0861abf452efcec57', '67f1328af8dd4e83a30b8836245abd4e', '46514f804c0111f18db996d21e5e70c2', 1778661083, NULL, 'active', 1778661083, NULL),
('97248d9c61ac48ec9489feabab91d2b1', 'af551f1ebb9a449bb5061cf07381d3fb', '46514f804c0111f18db996d21e5e70c2', 1778664390, NULL, 'active', 1778664390, NULL),
('9f7634b884ce4027afb79746ce1fae51', '9dff426e89534855bbb2cc964cfb9db5', '46514f804c0111f18db996d21e5e70c2', 1778761804, NULL, 'active', 1778761804, NULL),
('ab9697732c24422f85d62fd272d15783', 'fd88d38fb4804b9093cdb7e3fe54ed17', '46514f804c0111f18db996d21e5e70c2', 1778680486, NULL, 'active', 1778680487, NULL),
('bba32cc3c9984957964dd81ab0661177', 'c4965eb7f8cc4043927ed8237299175d', '46514f804c0111f18db996d21e5e70c2', 1778665177, NULL, 'active', 1778665177, NULL),
('c308e136be2840abbccdc3be835cc979', '54672277984942559848159e5c8f5d45', '46514f804c0111f18db996d21e5e70c2', 1778759855, NULL, 'active', 1778759855, NULL),
('c639f5a23e464258b4768f0aef3bd974', '003dea0d714e42c8b6416af02a92a631', '46514f804c0111f18db996d21e5e70c2', 1778761898, NULL, 'active', 1778761898, NULL),
('e55f7580be8f4917932943bee2f86768', '713145cbafe14a738a87c14521067bcb', '46514f804c0111f18db996d21e5e70c2', 1778662576, NULL, 'active', 1778662576, NULL),
('e60d48cd9bf7415cbd1927db7fbc43d9', '7ca9095d361046e4834ef83bd51c4b53', '46514f804c0111f18db996d21e5e70c2', 1778668182, NULL, 'active', 1778668182, NULL),
('fb00ac3909d4466fb5c5d8e5a7d43686', '53796bf8053a4f0a882c598c76ded87b', '46514f804c0111f18db996d21e5e70c2', 1778664830, NULL, 'active', 1778664830, NULL),
('fbb0a594f32749ae8e87df790f56ba4d', '953723140270494fbe81bff61a969c9a', '46514f804c0111f18db996d21e5e70c2', 1778665054, NULL, 'active', 1778665054, NULL),
('fe61ed8890584c20b65b9a6fb30e0063', 'b7d25603529147f29dde25f83309cea0', '46514f804c0111f18db996d21e5e70c2', 1778664903, NULL, 'active', 1778664903, NULL);

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
  ADD UNIQUE KEY `user_verification_key` (`user_verification_key`),
  ADD UNIQUE KEY `user_reset_password_key` (`user_reset_password_key`);

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
  ADD CONSTRAINT `cars_user_fk` FOREIGN KEY (`car_user_fk`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `payment_method` FOREIGN KEY (`transaction_gateway_fk`) REFERENCES `payment_gateway` (`payment_gateway_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
