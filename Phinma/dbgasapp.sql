-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 12, 2023 at 03:06 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbgasapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `gasowners`
--

CREATE TABLE `gasowners` (
  `usr_id` int(11) NOT NULL,
  `usr_username` varchar(255) NOT NULL,
  `usr_password` varchar(11) NOT NULL,
  `usr_fullname` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gasowners`
--

INSERT INTO `gasowners` (`usr_id`, `usr_username`, `usr_password`, `usr_fullname`) VALUES
(1, 'algenowner', 'Algen1@', 'algenowner');

-- --------------------------------------------------------

--
-- Table structure for table `gasstation`
--

CREATE TABLE `gasstation` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gasstation`
--

INSERT INTO `gasstation` (`id`, `name`, `latitude`, `longitude`) VALUES
(1, 'Shell', 8.47374, 124.695),
(2, 'Shell', 8.47374, 124.695),
(3, 'Shell', 8.47374, 124.695);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `gasstation_id` int(11) NOT NULL,
  `gas_name` varchar(255) NOT NULL,
  `gas_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`gasstation_id`, `gas_name`, `gas_price`) VALUES
(1, 'wee', 1),
(2, 'regular', 13),
(3, 'angel', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `tblusers`
--

CREATE TABLE `tblusers` (
  `usr_id` int(11) NOT NULL,
  `usr_username` varchar(255) NOT NULL,
  `usr_password` varchar(255) NOT NULL,
  `usr_fullname` varchar(25) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`usr_id`, `usr_username`, `usr_password`, `usr_fullname`, `date`) VALUES
(9, 'love', 'loveko', 'lovely', '2023-08-22'),
(18, 'majesty', '1234', 'majesty', '2023-08-28'),
(19, 'rae', '123', 'angel lampitao', '2023-08-30'),
(20, 'majestypretty1', '12345', 'majesty', '2023-08-31'),
(21, 'rae1', '12', 'rae', '2023-08-31'),
(22, 'mae', 'Mae1@', 'mae', '2023-08-31'),
(23, 'armeda', 'Armeda123@', 'armeda', '2023-09-04'),
(24, 'angel', '123', 'angel', '2023-09-11'),
(25, 'maj', '123', 'majestypretty', '2023-09-11'),
(26, 'algen', 'Algen1@', 'algen gwapo', '2023-09-12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gasowners`
--
ALTER TABLE `gasowners`
  ADD PRIMARY KEY (`usr_id`);

--
-- Indexes for table `gasstation`
--
ALTER TABLE `gasstation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`gasstation_id`);

--
-- Indexes for table `tblusers`
--
ALTER TABLE `tblusers`
  ADD PRIMARY KEY (`usr_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gasowners`
--
ALTER TABLE `gasowners`
  MODIFY `usr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gasstation`
--
ALTER TABLE `gasstation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `gasstation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `usr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
