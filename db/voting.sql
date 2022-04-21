-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jan 25, 2022 at 10:14 PM
-- Server version: 5.7.34
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `voting`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `first_name`, `last_name`, `username`, `password`, `status`) VALUES
(1, 'kamchai', 'boonsri', 'kamchai@2022', '$2a$10$qKnWrqPS0q9bGRP5tvc.3eIhU4T9vYZAB0kaUCQU9pPB.stkL61A6', 1);

-- --------------------------------------------------------

--
-- Table structure for table `candidate`
--

CREATE TABLE `candidate` (
  `id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `id_year` int(11) NOT NULL,
  `id_std` bigint(100) NOT NULL,
  `id_class` int(11) NOT NULL,
  `prefix` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `phone` text NOT NULL,
  `email` text NOT NULL,
  `images_url` text NOT NULL,
  `id_admin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `candidate`
--

INSERT INTO `candidate` (`id`, `number`, `id_year`, `id_std`, `id_class`, `prefix`, `first_name`, `last_name`, `phone`, `email`, `images_url`, `id_admin`) VALUES
(3, 1, 1, 6349010002, 1, 'นาย', 'กำชัย', 'บุญศรี', '0904672298', 'kamchai@gmail.com', 'http://kamchai.com/images.jpg', 1),
(4, 1, 1, 6349010002, 1, 'นาย', 'กำชัย2', 'บุญศรี', '0904672298', 'kamchai@gmail.com', 'http://kamchai.com/images.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `name`) VALUES
(1, 'ปวช. 1');

-- --------------------------------------------------------

--
-- Table structure for table `commissions`
--

CREATE TABLE `commissions` (
  `id` int(11) NOT NULL,
  `id_year` int(11) NOT NULL,
  `prefix` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `images_url` text NOT NULL,
  `id_admin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commissions`
--

INSERT INTO `commissions` (`id`, `id_year`, `prefix`, `first_name`, `last_name`, `images_url`, `id_admin`) VALUES
(1, 1, 'นาย', 'กำชัย', 'บุญศรี', 'http://kamchai.com/images.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `id_class` int(11) NOT NULL,
  `id_std` bigint(100) NOT NULL,
  `prefix` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `phone` text NOT NULL,
  `email` text NOT NULL,
  `images_url` text NOT NULL,
  `id_admin` int(11) DEFAULT NULL,
  `id_year` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `id_class`, `id_std`, `prefix`, `first_name`, `last_name`, `phone`, `email`, `images_url`, `id_admin`, `id_year`) VALUES
(1, 1, 6349010003, 'นาย', 'กำชัย', 'บุญศรี', '0904672298', 'kamchai@gmail.com', 'http://kamchai.com/images.png', 1, 1),
(2, 1, 999999999, 'นาง', 'สวยไป', 'ไปไหน', '0909999999', 'kamchai.n@cmtc.ac.th', '', 1, 1),
(6, 1, 8885888888, 'นาร', 'ยยน', 'บบบล', '9093883773', 'kamchai@gmail.com', '', NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `voting`
--

CREATE TABLE `voting` (
  `id` int(11) NOT NULL,
  `id_std` int(11) NOT NULL,
  `id_year` int(11) NOT NULL,
  `id_candidate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `voting`
--

INSERT INTO `voting` (`id`, `id_std`, `id_year`, `id_candidate`) VALUES
(3, 1, 1, 3),
(4, 6, 3, 3),
(5, 2, 1, 3),
(6, 2, 1, 4),
(9, 6, 3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `year`
--

CREATE TABLE `year` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `isStop` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `year`
--

INSERT INTO `year` (`id`, `name`, `isStop`) VALUES
(1, '2564', 0),
(2, '2677', 1),
(3, '2566', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `candidate`
--
ALTER TABLE `candidate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voting_id_admin_to_admin_id` (`id_admin`),
  ADD KEY `voting_id_class_to_class_id` (`id_class`),
  ADD KEY `voting_id_year_to_year_id` (`id_year`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commissions`
--
ALTER TABLE `commissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voting_id_admin_to_admin_id_commissions` (`id_admin`),
  ADD KEY `voting_id_year_to_year_id_commissions` (`id_year`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voting_id_admin_to_admin_id_students` (`id_admin`),
  ADD KEY `voting_id_class_to_class_id_ students` (`id_class`),
  ADD KEY `voting_id_year_to_year_id_students` (`id_year`);

--
-- Indexes for table `voting`
--
ALTER TABLE `voting`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voting_id_std_to_std_id_ voting` (`id_std`),
  ADD KEY `voting_id_year_to_year_id_voting` (`id_year`),
  ADD KEY `voting_id_commissions_to_commissions_id_voting` (`id_candidate`);

--
-- Indexes for table `year`
--
ALTER TABLE `year`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `candidate`
--
ALTER TABLE `candidate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `commissions`
--
ALTER TABLE `commissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `voting`
--
ALTER TABLE `voting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `year`
--
ALTER TABLE `year`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `candidate`
--
ALTER TABLE `candidate`
  ADD CONSTRAINT `voting_id_admin_to_admin_id` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id`),
  ADD CONSTRAINT `voting_id_class_to_class_id` FOREIGN KEY (`id_class`) REFERENCES `class` (`id`),
  ADD CONSTRAINT `voting_id_year_to_year_id` FOREIGN KEY (`id_year`) REFERENCES `year` (`id`);

--
-- Constraints for table `commissions`
--
ALTER TABLE `commissions`
  ADD CONSTRAINT `voting_id_admin_to_admin_id_commissions` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id`),
  ADD CONSTRAINT `voting_id_year_to_year_id_commissions` FOREIGN KEY (`id_year`) REFERENCES `year` (`id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `voting_id_admin_to_admin_id_students` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id`),
  ADD CONSTRAINT `voting_id_class_to_class_id_ students` FOREIGN KEY (`id_class`) REFERENCES `class` (`id`),
  ADD CONSTRAINT `voting_id_year_to_year_id_students` FOREIGN KEY (`id_year`) REFERENCES `year` (`id`);

--
-- Constraints for table `voting`
--
ALTER TABLE `voting`
  ADD CONSTRAINT `voting_id_commissions_to_commissions_id_voting` FOREIGN KEY (`id_candidate`) REFERENCES `candidate` (`id`),
  ADD CONSTRAINT `voting_id_std_to_std_id_ voting` FOREIGN KEY (`id_std`) REFERENCES `students` (`id`),
  ADD CONSTRAINT `voting_id_year_to_year_id_voting` FOREIGN KEY (`id_year`) REFERENCES `year` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
