-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2022 at 09:45 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shops`
--

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `product_name` varchar(20) NOT NULL,
  `detail` text NOT NULL,
  `price` int(11) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `id_store` int(11) NOT NULL,
  `id_product_cate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `product_name`, `detail`, `price`, `unit`, `id_store`, `id_product_cate`) VALUES
(33, 'โค้ก', 'สูตรน้ำตาลน้อยกว่า', 25, 'ขวด', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `id` int(11) NOT NULL,
  `category_name` varchar(30) NOT NULL,
  `detail` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`id`, `category_name`, `detail`) VALUES
(1, 'ขนมขบเคี้ยว', 'ของกินเล่นยามว่าง และเวลาหิว'),
(2, 'นม', ' มีไขมันดี โปรตีนและแคลเซียมสูง'),
(3, 'เครื่องดื่มอัดลมและน้ำหวาน', 'ช่วยดับกระหาย เพิ่มความสดชื่น'),
(4, 'อื่นๆ', 'ไม่ระบุประเภทสินค้า');

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `id` int(11) NOT NULL,
  `store_name` varchar(20) NOT NULL,
  `detail` varchar(50) NOT NULL,
  `phone_number` text NOT NULL,
  `address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`id`, `store_name`, `detail`, `phone_number`, `address`) VALUES
(1, 'คึกคัก', 'ขายตลอด 24 ชม', '0888888888', '155 หมู่ 2 ต.แม่เหียะ อ.เมือง จ.เชียงใหม่ 50100'),
(2, 'ร้านสะดวกซื้อ', 'เปิดตลอด 24 ชั่วโมง', '0871234589', '47/2 ซอย11 บ้านบวกครกใหม่ หมู่ที่6 ต.สำราญราษฎร์ อำเภอดอยสะเก็ด เชียงใหม่ 50220'),
(8, 'ร้านขายของชำ', 'ร้านขายของชำทั่วๆไป', '0901234567', 'ต.ศรีภูมิ อ.เมืองเชียงใหม่ เชียงใหม่ 50300');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_store` (`id_store`),
  ADD KEY `id_product_cate` (`id_product_cate`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `id_product_cate` FOREIGN KEY (`id_product_cate`) REFERENCES `product_category` (`id`),
  ADD CONSTRAINT `id_store` FOREIGN KEY (`id_store`) REFERENCES `store` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
