-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Generation Time: May 25, 2026 at 11:37 AM
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
('4cefbd6fa72247f8b6c847d6bc9de212', 'AB12345', '463c73471b6640b19b9eb851b66f2f5c', 1779306365, NULL, NULL),
('823ebf5236434c67a872689f921df7a9', 'AB12345', 'd2548979df7645d9a17862a9ec99a7f0', 1779434963, NULL, NULL),
('8c2aef1bc861478fb0fc49ad6a1055fa', 'A123456', '590f564104b54da089d1f3895db2ca9d', 1779624137, NULL, NULL),
('8dcacc22443c4340a05a879edcaccde9', '84848484', '416dab33ad6b4b099e694c668ea0a13a', 1779436369, NULL, NULL),
('a6e92f7c624d4afd800113e6befac4d2', 'AB12345', '4d2a63391e40402facfec0af4ddb753a', 1779309780, NULL, NULL),
('c03231388f374b05887b85d4c6c4e546', 'AB12345', 'fd88d38fb4804b9093cdb7e3fe54ed17', 1778680487, NULL, NULL),
('dc72424ad65e494492f37ba0ebeef8fc', 'AB12345', '003dea0d714e42c8b6416af02a92a631', 1778761898, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `location_id` char(32) NOT NULL,
  `location_name` varchar(100) NOT NULL,
  `location_address` varchar(199) NOT NULL,
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
('0d5073d1426242c99f9ba711d99f2b34', 'Premium', 'Ekstra grundig', 169, 1),
('104eb10034fd4a07888fd6937ad6aea8', 'Brilliant', 'Bedste vaske året rundt', 199, 1),
('46514f804c0111f18db996d21e5e70c2', 'Guld', 'God og effektik', 139, 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateway`
--

CREATE TABLE `payment_gateway` (
  `payment_gateway_id` char(32) NOT NULL,
  `payment_gateway_name` varchar(50) DEFAULT NULL,
  `payment_gateway_icon_path` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_gateway`
--

INSERT INTO `payment_gateway` (`payment_gateway_id`, `payment_gateway_name`, `payment_gateway_icon_path`) VALUES
('ed1aeb774ca211f18db996d21e5e70c2', 'Mobilepay', 'mobilepay.png'),
('f6baa1f7550411f19eb9c6366b8011fe', 'Betalingskort', 'visaicon.webp');

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
('0842ef0693de4264a52793db4030cabf', 'd2548979df7645d9a17862a9ec99a7f0', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1779434963),
('3acc3db21589460c980ab5b2c7484cfa', '590f564104b54da089d1f3895db2ca9d', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1779624137),
('735a1f52cbcb4a94965b1a59b4bf4820', '1db659d14e96417eaada51963bb2c413', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1779446533),
('9019448822c7470499dffece7d77f9f8', '416dab33ad6b4b099e694c668ea0a13a', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1779436369),
('ee188bc070ae4245bd429a5b93d4f569', '0958c122cad64b87a3019b160bb5bfc1', 'ed1aeb774ca211f18db996d21e5e70c2', '46514f804c0111f18db996d21e5e70c2', 1779445374);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` char(32) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_last_name` varchar(20) NOT NULL,
  `user_address` varchar(199) DEFAULT NULL,
  `user_phone` varchar(20) NOT NULL,
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

INSERT INTO `users` (`user_id`, `user_name`, `user_last_name`, `user_address`, `user_phone`, `user_email`, `user_password`, `created_at`, `deleted_at`, `user_verification_key`, `user_verified_at`, `user_reset_password_key`) VALUES
('003dea0d714e42c8b6416af02a92a631', 'PasswordTest', 'Test', '12 Main Street, Copenhagen, DK 2200', '99999999', 'sophiehjelm010203@gmail.com', 'scrypt:32768:8:1$xwhkTq3WNOd1zTJ1$d5752a9457d489dc1de5f2a089f3ac845e337293710b93f996916f6d8a228b4b6bb6c2db13c581798c82031a8b9629087f2f89c39147131dcc3070ebc085f07f', 1778761898, NULL, '837ffe541def4aeaa3a7da228475e7bb', 1778761906, 'e290917b89d149f8b94d5a77c87aa0f5275ca3e6bdb946ec900d7cb5406b1466'),
('416dab33ad6b4b099e694c668ea0a13a', 'svp', 'work', NULL, '22334455', 'sophie@hjelm.name', 'scrypt:32768:8:1$SHRyHwSLwFAZCJ7D$2911a89888109f917fd24dc353ae1fac3d982e463c04a5b5321804d4ae31ff0a96c270938304022444ec4d36ff094c6f9b73ad16c1596f58293fe0043d2ffbf9', 1779436369, NULL, '79092bd38dec4ead9eecab5875184628', 1779436451, NULL),
('463c73471b6640b19b9eb851b66f2f5c', 'PasswordTest', 'Test', '12 Main Street, Copenhagen, DK 2200', '12345678', 'testtoday@gmail.com', 'scrypt:32768:8:1$PdBAuEpAptj1i21B$c424c265b234f9399b0324e7113867a1130f88b9b57b097f9b2320c60fbeb82e597e4a3ae2fc2ee93e0c506f354912f51ce993deb070c58c02ac4b63f274a923', 1779306365, NULL, '09981dde73894d4c8dc2ee67445a4aa7', NULL, NULL),
('4d2a63391e40402facfec0af4ddb753a', 'PasswordTest', 'Test', '12 Main Street, Copenhagen, DK 2200', '12345678', 'porfavor@gmail.com', 'scrypt:32768:8:1$VdZlGQDJGyyHlrR5$8e162cc9985f971213f4cf5077326fd007acd5dfd9e0e2fd3ab96a1e5daa66b8c2522c31c48affd754d36ee7862edff2be5221a2fc388560a1a20be8b9b0c0dc', 1779309780, NULL, '0368e3deaea34b4b8c12d1df37c180eb', NULL, NULL),
('590f564104b54da089d1f3895db2ca9d', 'Sophia', 'Kingston', NULL, '50591108', 'sophia.anina@gmail.com', 'scrypt:32768:8:1$65XpKpmYn9JyAabo$506ddb55227ee822d1875a8758437892461446f87b535d655ae1e297d55f8f356a5db457a17e884ea41c4a403a3de6232b316cefa617f731960c68585f19eaf7', 1779624137, NULL, '6a9c42a7322348328be18639af7c7d12', 1779625827, NULL),
('d2548979df7645d9a17862a9ec99a7f0', 'PasswordTest', 'Test', NULL, '12345678', 'testing@gmail.com', 'scrypt:32768:8:1$blJKJ1kqv08vdig0$3c83873cad4d1cc984708d603eaa32d6673bf05500c6c47d42e098b341679ce69f6bcb5601d6e70029cedeb0a2405c39845d91bd6c8516191d9e4bde3201c7c2', 1779434963, NULL, '09a7128dbbd740f28ebc553bbf337383', NULL, NULL),
('fd88d38fb4804b9093cdb7e3fe54ed17', 'Test 5', 'Test 5', '12 Main Street, Copenhagen, DK 2200', '12345678', 'test@gmail.com', 'scrypt:32768:8:1$MTFzhXFmGXVefiIq$363f44543c3f26a12bd128478373eddc5122e3eeeee6b3d30cc026784426673067e8b1ec9a3895bb3905c9ebdf10e36313e70fd034c14fc1be3c9134b5288d5a', 1778680487, NULL, 'aea4fb0dfc414f23acdcf0e286a932ed', NULL, NULL);

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
('196ccea80ac448cd893fd6fa1593c8ab', '416dab33ad6b4b099e694c668ea0a13a', '46514f804c0111f18db996d21e5e70c2', 1779436369, NULL, 'active', 1779436369, NULL),
('247501d0aba749a09a3e45487d9f8e40', '89f0c6014c7043ce8aa1e6c051dc17ab', '46514f804c0111f18db996d21e5e70c2', 1778662487, NULL, 'active', 1778662487, NULL),
('2f139c357c924db2a40a603946630db9', '3c8ba02e4c20460bbefe4d3a3478ffb1', '46514f804c0111f18db996d21e5e70c2', 1778592068, NULL, 'active', 1778592068, NULL),
('3a2cc4de89f94fdda255be7a33f5c54e', 'd2548979df7645d9a17862a9ec99a7f0', '46514f804c0111f18db996d21e5e70c2', 1779434962, NULL, 'active', 1779434963, NULL),
('3b40700012b146a79725dc1db767c268', '590f564104b54da089d1f3895db2ca9d', '46514f804c0111f18db996d21e5e70c2', 1779624137, NULL, 'active', 1779624137, NULL),
('52fc4626949740e9babc98e3f9890fc6', 'cc572ed36b064e53a7e0623efa09dfcf', '46514f804c0111f18db996d21e5e70c2', 1778661461, NULL, 'active', 1778661461, NULL),
('66d26f0794bb4a1da2dcc7085904677a', '223c9bf7b2384f20a2bfe6e80d77c5db', '46514f804c0111f18db996d21e5e70c2', 1778661499, NULL, 'active', 1778661499, NULL),
('70bfe52756f44bb5a215af6f8348b3be', '05d45d8b24fc4014bfb6be05b2adaccf', '46514f804c0111f18db996d21e5e70c2', 1778673132, NULL, 'active', 1778673132, NULL),
('75ac16ee257e4a0a9296ac0a508282a8', '34d21391141f47bc8ead25fcebdfc7b3', '46514f804c0111f18db996d21e5e70c2', 1778664284, NULL, 'active', 1778664284, NULL),
('7d0fd4c20c7342c8a13ae3fe8fbe3c59', '463c73471b6640b19b9eb851b66f2f5c', '46514f804c0111f18db996d21e5e70c2', 1779306364, NULL, 'active', 1779306365, NULL),
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
('edbc97e4aa9441ba90ce9f1b6d5100ab', '1db659d14e96417eaada51963bb2c413', '46514f804c0111f18db996d21e5e70c2', 1779446533, NULL, 'active', 1779446533, NULL),
('eecb8c7707f34351a1d9b5b00a254658', '0958c122cad64b87a3019b160bb5bfc1', '46514f804c0111f18db996d21e5e70c2', 1779445374, NULL, 'active', 1779445374, NULL),
('f313442834814ba0a1cf4d80a90f06a3', '4d2a63391e40402facfec0af4ddb753a', '46514f804c0111f18db996d21e5e70c2', 1779309780, NULL, 'active', 1779309780, NULL),
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
