-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 04, 2024 at 06:55 AM
-- Server version: 8.0.35-0ubuntu0.20.04.1
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lumishare`
--
CREATE DATABASE lumishare;
use lumishare;
-- --------------------------------------------------------

--
-- Table structure for table `auctions`
--

CREATE TABLE `auctions` (
  `auctionId` int NOT NULL,
  `tokenId` int NOT NULL,
  `owner_address` varchar(255) DEFAULT NULL,
  `transactionHash` varchar(255) DEFAULT NULL,
  `reservePrice` float NOT NULL,
  `highestBid` float NOT NULL DEFAULT '0',
  `endTimeInSeconds` double NOT NULL,
  `isSettled` int NOT NULL DEFAULT '0',
  `highestBidder` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `biddings`
--

CREATE TABLE `biddings` (
  `bidding_id` int NOT NULL,
  `auction_id` int NOT NULL,
  `bidder_id` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `transferHash` varchar(255) NOT NULL,
  `settlement` int NOT NULL DEFAULT '0',
  `result` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `biddings`
--

INSERT INTO `biddings` (`bidding_id`, `auction_id`, `bidder_id`, `price`, `transferHash`, `settlement`, `result`, `created_at`, `status`) VALUES
(93, 36, '0x825Be596Ca31cf3E85738B9a18B53DF51BefD966', 0.002, '0xd123a166731a30d2be89d6ebcde9bedea59141b5309fc066c5f7ab6d5e38b28b', 0, 'pending', '2023-08-17 21:45:20', 1);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `cat_id` int NOT NULL,
  `cat_name` varchar(255) DEFAULT NULL,
  `cat_description` varchar(255) DEFAULT NULL,
  `cat_img` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_name`, `cat_description`, `cat_img`, `createdAt`) VALUES
(1, 'test 1', 'testing', NULL, '2022-11-22 23:05:24'),
(2, 'test 2', 'test 222', NULL, '2022-11-22 23:46:26');

-- --------------------------------------------------------

--
-- Table structure for table `creators`
--

CREATE TABLE `creators` (
  `creatorID` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `walletAddress` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'creator',
  `lastName` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `govermentID` varchar(255) NOT NULL,
  `govermentIDPicture` varchar(255) NOT NULL,
  `bio` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `img` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `cover` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'cover.jpg',
  `portfolio` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `discord` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `ratings` int NOT NULL DEFAULT '0',
  `followers` double NOT NULL DEFAULT '0',
  `posts` double NOT NULL DEFAULT '0',
  `following` double NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `creators`
--

INSERT INTO `creators` (`creatorID`, `username`, `walletAddress`, `firstName`, `email`, `type`, `lastName`, `country`, `gender`, `govermentID`, `govermentIDPicture`, `bio`, `img`, `cover`, `portfolio`, `instagram`, `twitter`, `facebook`, `linkedin`, `discord`, `ratings`, `followers`, `posts`, `following`, `createdAt`, `status`) VALUES
(5, 'sherazi', '0x2d5E5dABeABbfe2E64e0E06F72d533B8fB731f43', 'sajad', 'sajad@gmail.com', 'creator', NULL, '', '', '', '', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-07-05 19:14:00', 1),
(17, 'faiz', '0xD098Af6c6fD34e3398A44E33f10B6743960d1622', 'Faiz', 'alyfayz19@gmail.com', 'investor', 'Ali', '', '', '', '', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-07-06 01:26:13', 1),
(21, 'hunzai', '0x825Be596Ca31cf3E85738B9a18B53DF51BefD966', 'Nasir', 'nasiruddin@gmail.com', 'investor', NULL, '', '', '', '', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-07-07 00:51:20', 1),
(22, 'sunny', '0xC4EC345029A29D9Fe0383906144Db3d102D4ed3D', NULL, NULL, 'creator', NULL, '', '', '', '', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-07-10 22:51:19', 1),
(23, 'saqib123', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 'Saqib', 'saqib.hyd69@gmail.com', 'creator', 'Amin', '', '', '', '', 'fghdfj hdjfhgdf hfg jhgdfg j fg jhdf dfh jdf g h fdj fj ghdfgfdj kfdfkg dfgfdh dfkgfdjkg fdjkg k jgdf ghdfjg gh kf fh fdghkdf k  hjkhdfgdfjk h dfjghdfh gk   jkdfh d', '17042837125122087957-3592249135.jpg', '1704283203781daniel-leone-v7daTKlZzaw-unsplash.jpg', NULL, '', 'https://twitter.com/', NULL, '', '', 3, 1000, 20, 5, '2023-07-12 10:51:04', 1),
(24, 'Kashif', '23456789', 'kasif', 'kashif@gmail.com', 'creator', NULL, '', '', '', '', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-11-24 13:06:47', 1),
(25, 'shaqir', '12344', NULL, NULL, 'creator', NULL, '', '', '', '', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-11-24 13:11:52', 1),
(27, 'ben', '0xe2055BEC5EccC218b5b045d3C7754A396c97244b', 'asif', NULL, 'investor', NULL, '', '', '', '', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-11-24 20:19:40', 1),
(29, 'sherazi1122', NULL, NULL, 'sherazi123@gmail.com', 'creator', NULL, 'pakistan', 'male', '56463463463', 'undefined', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-12-13 11:46:46', 1),
(30, 'admin', '987654321', 'Sheraz', 'sherazhunzai1@gmail.com', 'creator', NULL, 'PK', 'Male', '54665765756', '17028963818153127603.jpg', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-12-18 10:46:21', 1),
(31, 'saqib', '0x2d5e5dabeabbfe2e64e0e06f72d533b8fb731f43', NULL, 'saqib.hyd369@gmail.com', 'investor', NULL, 'AO', 'Male', '235234523452', '1702914211801witcher.png', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-12-18 15:43:31', 1),
(41, 'vdvd', 'undefined', NULL, 'bensharonb.i.t@gmail.com', 'undefined', NULL, 'IL', 'Male', '200151515', '1703234740520WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', NULL, '1702819746945WhatsApp Image 2023-12-11 at 18.19.55_6fcaaaa8.jpg', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 3, 0, 0, 0, '2023-12-22 08:45:40', 1),
(42, 'sajjad', '0x1d700168e11c8a867ad860df725972777eed806d', NULL, 'sajukarim76@gmail.com', 'creator', NULL, 'PK', 'Male', '23456789', '1703672439678Brown Yellow Simple Kitchen and Restaurant Logo (1).png', NULL, '1703672439680Brown Yellow Simple Kitchen and Restaurant Logo (1).png', 'cover.jpg', NULL, NULL, NULL, NULL, '', '', 0, 0, 0, 0, '2023-12-27 10:20:39', 1),
(43, 'sherazi12345', '0x86ee60642b1f69994c94759863e2896b900bbb12', NULL, 'sherazhunzai2@gmail.com', 'creator', NULL, 'PK', 'Male', '3456789', '1703704935450WhatsApp Image 2022-12-11 at 10.53.50 PM (1).jpeg', NULL, '1703704935451png logo-03.png', '1703704935452a0ru4gczunp1g6sa9auz.png', NULL, NULL, NULL, NULL, '', '', 0, 0, 0, 0, '2023-12-27 19:22:15', 1),
(44, 'test investor', '0x77a5dbf6d51e90acf656ba90876d6f80294ed0a0', NULL, 'sherazhunzai5@gmail.com', 'investor', NULL, 'PK', 'Male', '345678908', '1703705140430WhatsApp Image 2022-12-11 at 10.53.42 PM (1).jpeg', NULL, '170370514043222-03.png', '1703705140434a0ru4gczunp1g6sa9auz.png', NULL, NULL, NULL, NULL, '', '', 0, 0, 0, 0, '2023-12-27 19:25:40', 1),
(45, 'sofia', '0x1c595099456179bf9b820d49ad504c200e1c7822', NULL, 'sofia@gmail.com', 'investor', NULL, 'PK', 'Female', '235234523452', '1703882532677admin.jpeg', 'amin', '17042077711792087957-3592249135.jpg', '1704204450576Actress-Scarlett-Johansson-2020-Photoshoot-New-4K-Ultra-HD-Mobile-Wallpaper-scaled.jpg', NULL, 'https://twitter.com/', '', NULL, '', '', 0, 0, 0, 0, '2023-12-29 20:42:12', 1),
(46, 'Ben Sharon', '0xc6ac2bf8dab85beb167ff952e709bb12144307a0', NULL, 'bensharonb.i.t@gmail.com', 'investor', NULL, 'IL', 'Male', '204125151', '1703964731061IRAduWQ-_400x400.jpg', NULL, '1703964731061IRAduWQ-_400x400.jpg', '1703964731063WhatsApp Image 2023-09-05 at 18.08.25.jpeg', NULL, NULL, NULL, NULL, '', '', 0, 0, 0, 0, '2023-12-30 19:32:11', 1),
(47, 'Ben Shar', '0xb88f47475ee533ae8688feca71838db59c5b7469', NULL, 'ben@lumishare.io', 'investor', NULL, 'AE', 'Male', '20000009', '1704024258688photo_2023-09-23_22-33-21.jpg', NULL, '1704024258690WhatsApp Image 2023-12-10 at 13.38.12_29a7df31.jpg', '1704024258690Linkdin cover.png', NULL, NULL, NULL, NULL, '', '', 0, 0, 0, 0, '2023-12-31 12:04:18', 1),
(48, 'sajukarim76@gmail.com', '0x0b2520fb4f5d889f2bf4dabf78abf8ee4e9ea741', NULL, 'sajukarim76@gmail.com', 'investor', NULL, 'PK', 'Male', '23456789', '1704178423004cute-photos-of-cats-looking-at-camera-1593184780.jpg', NULL, '1704287257453cute-photos-of-cats-looking-at-camera-1593184780.jpg', '1704178423008cute-photos-of-cats-looking-at-camera-1593184780.jpg', NULL, NULL, NULL, NULL, '', '', 0, 0, 0, 0, '2024-01-02 06:53:43', 1),
(49, 'admin', '0x1c595099456179bf9b820d49ad504c200e1c7822', NULL, 'saqib.hyd369@gmail.com', 'creator', NULL, 'AW', 'Male', '235234523452', '17042402431982087957-3592249135.jpg', NULL, '17042402432032087957-3592249135.jpg', '17042402432042087957-3592249135.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, '2024-01-03 00:04:03', 1),
(50, 'faiz', '0xe4243aa2f996fcc756c92d6a8b2d7153d83cc087', NULL, 'alyfayz19@gmail.com', 'creator', NULL, 'PK', 'Male', '12346789876543', '1704240388318296069-introduction-to-javascript-basics.png', NULL, '1704240388319296069-introduction-to-javascript-basics.png', '1704240388320296069-introduction-to-javascript-basics.png', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, '2024-01-03 00:06:28', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fixedprice`
--

CREATE TABLE `fixedprice` (
  `saleId` int NOT NULL,
  `orderId` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `tokenId` int DEFAULT NULL,
  `transactionHash` varchar(255) DEFAULT NULL,
  `owner` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `price` double DEFAULT NULL,
  `onSale` int NOT NULL DEFAULT '1',
  `isSold` int NOT NULL DEFAULT '0',
  `isCanceled` int NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fixedprice`
--

INSERT INTO `fixedprice` (`saleId`, `orderId`, `tokenId`, `transactionHash`, `owner`, `price`, `onSale`, `isSold`, `isCanceled`, `createdAt`, `status`) VALUES
(44, '44', NULL, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 12, 1, 0, 0, '2023-12-26 15:51:03', 1),
(45, '45', NULL, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 12, 1, 0, 0, '2023-12-26 15:53:24', 1),
(46, '46', NULL, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 123, 1, 0, 0, '2023-12-26 15:54:36', 1),
(47, '47', NULL, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 12, 1, 0, 0, '2023-12-26 16:03:21', 1),
(48, '48', 103, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 23, 1, 0, 0, '2023-12-26 16:04:13', 1),
(49, '49', 200, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 12, 1, 0, 0, '2023-12-27 16:16:19', 1),
(50, '50', 105, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 50, 1, 0, 0, '2023-12-27 16:16:24', 1),
(51, '51', 104, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 45, 1, 0, 0, '2023-12-27 16:16:29', 1),
(52, '', 285, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-27 19:06:44', 1),
(53, '', 105, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 200, 1, 0, 0, '2023-12-27 19:06:50', 1),
(54, '', 100, '', '0xe2055BEC5EccC218b5b045d3C7754A396c97244b', 123, 1, 0, 0, '2023-12-27 19:11:33', 1),
(55, '', 238, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1222, 1, 0, 0, '2023-12-27 19:18:35', 1),
(56, '', 238, '', '0x77a5dbf6d51e90acf656ba90876d6f80294ed0a0', 333, 1, 0, 0, '2023-12-27 19:35:55', 1),
(57, '', 285, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 12, 1, 0, 0, '2023-12-29 07:34:29', 1),
(58, '', 284, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 12, 1, 0, 0, '2023-12-29 08:14:19', 1),
(59, '', 234, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-29 08:15:41', 1),
(60, '', 238, '', 'undefined', 200, 1, 0, 0, '2023-12-29 08:15:50', 1),
(61, '', 290, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-29 08:15:56', 1),
(62, '', 242, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 12, 1, 0, 0, '2023-12-29 08:45:10', 1),
(63, '', 278, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 55, 1, 0, 0, '2023-12-29 08:45:16', 1),
(64, '', 263, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-29 10:21:00', 1),
(65, '', 238, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-29 10:21:06', 1),
(66, '', 242, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-29 10:21:11', 1),
(67, '', 284, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-29 10:21:15', 1),
(68, '', 100, '', 'undefined', 100, 1, 0, 0, '2023-12-29 10:21:25', 1),
(69, '', 217, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 123, 1, 0, 0, '2023-12-29 17:07:17', 1),
(70, '', 293, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-29 17:13:18', 1),
(71, '', 278, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-29 17:14:56', 1),
(72, '', 231, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 13, 1, 0, 0, '2023-12-29 17:33:40', 1),
(73, '', 260, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 200, 1, 0, 0, '2023-12-29 18:20:40', 1),
(74, '', 217, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 123, 1, 0, 0, '2023-12-29 22:08:20', 1),
(75, '', 231, '', '0x1c595099456179bf9b820d49ad504c200e1c7822', 20, 1, 0, 0, '2023-12-30 09:10:52', 1),
(76, '', 231, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2023-12-30 09:32:53', 1),
(77, '', 260, '', '0xb88f47475ee533ae8688feca71838db59c5b7469', 12, 1, 0, 0, '2024-01-01 08:37:56', 1),
(78, '', 226, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 12, 1, 0, 0, '2024-01-01 08:38:07', 1),
(79, '', 212, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2024-01-01 08:38:25', 1),
(80, '', 217, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 100, 1, 0, 0, '2024-01-02 09:42:40', 1),
(81, '', 231, '', '0xc6ac2bf8dab85beb167ff952e709bb12144307a0', 100, 1, 0, 0, '2024-01-02 11:10:23', 1),
(82, '', 212, '', '0x1c595099456179bf9b820d49ad504c200e1c7822', 100, 1, 0, 0, '2024-01-02 11:18:11', 1),
(83, '', 231, '', '0x1c595099456179bf9b820d49ad504c200e1c7822', 100, 1, 0, 0, '2024-01-02 11:20:24', 1),
(84, '', 226, '', '0x1c595099456179bf9b820d49ad504c200e1c7822', 100, 1, 0, 0, '2024-01-02 11:22:12', 1),
(85, '', 223, '', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 50, 1, 0, 0, '2024-01-02 11:22:45', 1),
(86, '', 103, '', 'undefined', 100, 1, 0, 0, '2024-01-02 11:24:11', 1),
(87, '', 217, '', '0x1c595099456179bf9b820d49ad504c200e1c7822', 4, 1, 0, 0, '2024-01-02 15:03:34', 1),
(88, '', 260, '', '0x1c595099456179bf9b820d49ad504c200e1c7822', 4, 1, 0, 0, '2024-01-02 15:08:44', 1),
(89, '', 223, '', '0x1c595099456179bf9b820d49ad504c200e1c7822', 5, 1, 0, 0, '2024-01-02 15:09:29', 1),
(90, '', 293, '', 'undefined', 100, 1, 0, 0, '2024-01-03 12:10:19', 1);

-- --------------------------------------------------------

--
-- Table structure for table `nfts`
--

CREATE TABLE `nfts` (
  `nft_id` int NOT NULL,
  `tokenId` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `image` varchar(255) DEFAULT NULL,
  `nftType` varchar(255) DEFAULT NULL,
  `video` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `socialMediaImage` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `artistImage` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `titleImage` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `revenue` varchar(255) NOT NULL DEFAULT '0',
  `creatorWallet` varchar(255) DEFAULT NULL,
  `ownerWallet` varchar(255) DEFAULT NULL,
  `sale` int DEFAULT '0',
  `auction` int DEFAULT '0',
  `fixedprice` int DEFAULT '0',
  `metadata` varchar(255) DEFAULT NULL,
  `transactionHash` varchar(255) DEFAULT NULL,
  `categoryId` int DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nfts`
--

INSERT INTO `nfts` (`nft_id`, `tokenId`, `title`, `description`, `image`, `nftType`, `video`, `socialMediaImage`, `artistImage`, `titleImage`, `revenue`, `creatorWallet`, `ownerWallet`, `sale`, `auction`, `fixedprice`, `metadata`, `transactionHash`, `categoryId`, `status`, `created_at`) VALUES
(100, 100, 'Monkey', 'Discover the captivating world of non-fungible tokens (NFTs), where digital art comes to life on the blockchain. Each NFT is a unique, verifiable asset, representing a one-of-a-kind piece of digital creativity. Own a piece of the future as you immerse yourself in the decentralized realm of NFTs, where art is truly borderless and ownership is secured by blockchain technology. These limited-edition digital assets redefine traditional notions of art ownership, allowing collectors to engage with their favorite artists directly.', '1703603761481main-qimg-f3d20abe1b42429f922cc27b9ba7fd0c-lq.jpeg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-26 15:16:01'),
(102, 102, 'test', 'Discover the captivating world of non-fungible tokens (NFTs), where digital art comes to life on the blockchain. Each NFT is a unique, verifiable asset, representing a one-of-a-kind piece of digital creativity. Own a piece of the future as you immerse yourself in the decentralized realm of NFTs, where art is truly borderless and ownership is secured by blockchain technology. These limited-edition digital assets redefine traditional notions of art ownership, allowing collectors to engage with their favorite artists directly.', '1703604218205main-qimg-f3d20abe1b42429f922cc27b9ba7fd0c-lq.jpeg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0xe2055BEC5EccC218b5b045d3C7754A396c97244b', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-26 15:23:38'),
(103, 103, 'saqib', 'Discover the captivating world of non-fungible tokens (NFTs), where digital art comes to life on the blockchain. Each NFT is a unique, verifiable asset, representing a one-of-a-kind piece of digital creativity. Own a piece of the future as you immerse yourself in the decentralized realm of NFTs, where art is truly borderless and ownership is secured by blockchain technology. These limited-edition digital assets redefine traditional notions of art ownership, allowing collectors to engage with their favorite artists directly.', '1703604731456unnamed.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 'undefined', 1, 0, 1, NULL, NULL, NULL, 1, '2023-12-26 15:32:11'),
(105, 105, 'test', 'Discover the captivating world of non-fungible tokens (NFTs), where digital art comes to life on the blockchain. Each NFT is a unique, verifiable asset, representing a one-of-a-kind piece of digital creativity. Own a piece of the future as you immerse yourself in the decentralized realm of NFTs, where art is truly borderless and ownership is secured by blockchain technology. These limited-edition digital assets redefine traditional notions of art ownership, allowing collectors to engage with their favorite artists directly.', '1703605322206NFT-Designs-By-Kimp.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0xC6Ac2bF8Dab85bEB167fF952E709Bb12144307a0', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-26 15:42:02'),
(106, 200, 'nancy', 'Discover the captivating world of non-fungible tokens (NFTs), where digital art comes to life on the blockchain. Each NFT is a unique, verifiable asset, representing a one-of-a-kind piece of digital creativity. Own a piece of the future as you immerse yourself in the decentralized realm of NFTs, where art is truly borderless and ownership is secured by blockchain technology. These limited-edition digital assets redefine traditional notions of art ownership, allowing collectors to engage with their favorite artists directly.', '1703606746928wp2362442-momoland-nancy-wallpapers-2200114814.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-26 16:05:46'),
(107, 285, 'sajjad', 'teste', '1703703953514daniel-leone-v7daTKlZzaw-unsplash.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-27 19:05:53'),
(108, 263, 'Maqbool', 'Hello how are you', '1703704257458daniel-leone-v7daTKlZzaw-unsplash.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-27 19:10:57'),
(109, 290, 'Saqib Amin', 'saqib is boss', '1703704430597WhatsApp Image 2023-11-27 at 1.12.07 PM.jpeg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-27 19:13:50'),
(110, 238, 'Nancy', 'asdfasdfa', '1703704519684Actress-Scarlett-Johansson-2020-Photoshoot-New-4K-Ultra-HD-Mobile-Wallpaper-scaled.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-27 19:15:19'),
(111, 242, 'cat', 'saqasdfasdf', '1703705096516kitten-2354016_1280.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-27 19:24:56'),
(112, 275, 'Merry Christmas', '', '1703784859340WhatsApp Image 2023-12-24 at 20.06.05_73fc0100.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0xC6Ac2bF8Dab85bEB167fF952E709Bb12144307a0', '0xC6Ac2bF8Dab85bEB167fF952E709Bb12144307a0', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-28 17:34:19'),
(113, 284, 'shakir', 'test', '1703837470776NFT-Designs-By-Kimp.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 'undefined', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-29 08:11:10'),
(114, 234, 'teste', 'sdfs', '1703837629785NFT-Designs-By-Kimp.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-29 08:13:49'),
(115, 278, 'nancy', 'test', '17038379114202087957-3592249135.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 0, 0, NULL, NULL, NULL, 1, '2023-12-29 08:18:31'),
(116, 217, 'nancy', 'test', '17038379187772087957-3592249135.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 0, 1, NULL, NULL, NULL, 1, '2023-12-29 08:18:38'),
(117, 217, 'test', 'asdfa', '1703837938325NFT-Designs-By-Kimp.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 0, 1, NULL, NULL, NULL, 1, '2023-12-29 08:18:58'),
(118, 293, 'test', 'asdfa', '1703837942420NFT-Designs-By-Kimp.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 'undefined', 1, 0, 1, NULL, NULL, NULL, 1, '2023-12-29 08:19:02'),
(119, 212, 'withcer', 'asdfasf', '1703870283599background.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 0, 1, NULL, NULL, NULL, 1, '2023-12-29 17:18:03'),
(120, 231, 'sajjad', 'sdfsd', '1703870648253background.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 0, 1, NULL, NULL, NULL, 1, '2023-12-29 17:24:08'),
(121, 226, 'sheraz', 'sadfasfa', '1703871574172admin.jpeg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 0, 1, NULL, NULL, NULL, 1, '2023-12-29 17:39:34'),
(122, 260, 'ali jan', 'test', '1703874014953background.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 0, 1, NULL, NULL, NULL, 1, '2023-12-29 18:20:14'),
(123, 223, 'test', 'test', '1703930791535daniel-leone-v7daTKlZzaw-unsplash.jpg', NULL, NULL, NULL, NULL, NULL, '0', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 0, 1, NULL, NULL, NULL, 1, '2023-12-30 10:06:31'),
(124, 295, 'test', 'test', 'null', NULL, NULL, NULL, NULL, NULL, '0', '0x2d5E5dABeABbfe2E64e0E06F72d533B8fB731f43', '0x2d5E5dABeABbfe2E64e0E06F72d533B8fB731f43', 0, 0, 0, NULL, NULL, NULL, 1, '2024-01-02 22:19:32'),
(125, 220, 'test', 'test', 'null', NULL, NULL, NULL, NULL, NULL, '0', '0x2d5E5dABeABbfe2E64e0E06F72d533B8fB731f43', '0x2d5E5dABeABbfe2E64e0E06F72d533B8fB731f43', 0, 0, 0, NULL, NULL, NULL, 1, '2024-01-02 22:20:48'),
(126, 261, 'cat', 'cst', 'null', NULL, NULL, NULL, NULL, NULL, '0', '0x2d5E5dABeABbfe2E64e0E06F72d533B8fB731f43', '0x2d5E5dABeABbfe2E64e0E06F72d533B8fB731f43', 0, 0, 0, NULL, NULL, NULL, 1, '2024-01-02 22:25:02');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` int NOT NULL,
  `token` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stories`
--

CREATE TABLE `stories` (
  `storyId` int NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `creatorId` int NOT NULL,
  `view` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '1',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stories`
--

INSERT INTO `stories` (`storyId`, `content`, `creatorId`, `view`, `status`, `createdAt`) VALUES
(1, 'morning.jpg', 5, 0, 1, '2024-01-03 15:04:07'),
(2, 'faiz_content.png', 50, 0, 0, '2024-01-03 15:39:25'),
(3, 'a.png', 22, 0, 1, '2024-01-03 15:40:54'),
(4, 'asd.png', 22, 100, 1, '2024-01-03 15:43:10'),
(5, 'asdasda.png', 22, 500, 1, '2024-01-03 15:45:40');

-- --------------------------------------------------------

--
-- Table structure for table `storyReplies`
--

CREATE TABLE `storyReplies` (
  `replyId` int NOT NULL,
  `reply` varchar(255) DEFAULT NULL,
  `sender` int DEFAULT NULL,
  `storyId` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `storyReplies`
--

INSERT INTO `storyReplies` (`replyId`, `reply`, `sender`, `storyId`, `createdAt`) VALUES
(1, 'good morning', 24, 1, '2024-01-03 15:32:44'),
(3, 'Happy hallowean!', 31, 2, '2024-01-03 15:46:39');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int NOT NULL,
  `username` int NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `username`, `password`) VALUES
(1, 111, 'werwt534tgcbc@er$%^&*gcgdg');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transactonId` varchar(255) NOT NULL,
  `sendedFrom` varchar(255) NOT NULL,
  `recievedTo` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `tokenId` int NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transactonId`, `sendedFrom`, `recievedTo`, `amount`, `tokenId`, `createdAt`) VALUES
('', '987654321', '0xe2055BEC5EccC218b5b045d3C7754A396c97244b', 1, 2, '2023-12-20 14:30:44'),
('1', '0x2d5E5dABeABbfe2E64e0E06F72d533B8fB731f43', '0x2d5e5dabeabbfe2e64e0e06f72d533b8fb731960d1', 5, 4, '2023-09-10 00:00:00'),
('2', '0xC4EC345029A29D9Fe0383906144Db3d102D4ed3D', '0x825Be596Ca31cf3E85738B9a18B53DF51BefD966', 10, 5, '2023-04-05 00:00:00'),
('3', '987654321', '0xe2055BEC5EccC218b5b045d3C7754A396c97244b', 8, 5, '2023-05-05 00:00:00'),
('5', '3232323232323', '343534342223', 0.009, 40, '2023-12-26 13:28:39'),
('6', '3232323232323', '343534342223', 0.009, 40, '2023-12-26 13:29:08');

-- --------------------------------------------------------

--
-- Table structure for table `transfernft`
--

CREATE TABLE `transfernft` (
  `transferId` int NOT NULL,
  `transferFrom` varchar(255) NOT NULL,
  `transferTo` varchar(255) NOT NULL,
  `amount` float NOT NULL,
  `tokenId` int DEFAULT NULL,
  `transferType` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `tranferReferenceId` int DEFAULT NULL,
  `transferHash` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transfernft`
--

INSERT INTO `transfernft` (`transferId`, `transferFrom`, `transferTo`, `amount`, `tokenId`, `transferType`, `tranferReferenceId`, `transferHash`, `createdAt`) VALUES
(1, '0xD098Af6c6fD34e3398A44E33f10B6743960d1622', '0x825Be596Ca31cf3E85738B9a18B53DF51BefD966', 0.0001, 90, 'DirectTransfer', 10, 'undefined', '2023-08-23 19:48:44'),
(2, '0xD098Af6c6fD34e3398A44E33f10B6743960d1622', '0x825Be596Ca31cf3E85738B9a18B53DF51BefD966', 0.001, 91, 'DirectTransfer', 11, 'undefined', '2023-08-26 13:16:09'),
(3, '0xD098Af6c6fD34e3398A44E33f10B6743960d1622', '0x825Be596Ca31cf3E85738B9a18B53DF51BefD966', 0.001, 92, 'DirectTransfer', 12, 'undefined', '2023-08-26 13:34:41'),
(4, '0xD098Af6c6fD34e3398A44E33f10B6743960d1622', '0x825Be596Ca31cf3E85738B9a18B53DF51BefD966', 0.001, 95, 'DirectTransfer', 14, 'undefined', '2023-08-27 00:19:58'),
(5, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 200, 'DirectTransfer', 106, '', '2023-12-27 17:41:44'),
(6, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 105, 'DirectTransfer', 105, '', '2023-12-27 17:45:01'),
(7, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x77a5dbf6d51e90acf656ba90876d6f80294ed0a0', 1, 238, 'DirectTransfer', 110, '', '2023-12-27 19:26:52'),
(8, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 285, 'DirectTransfer', 107, '', '2023-12-27 19:27:52'),
(9, '0x77a5dbf6d51e90acf656ba90876d6f80294ed0a0', 'undefined', 1, 238, 'DirectTransfer', 110, '', '2023-12-27 20:25:45'),
(10, '0x77a5dbf6d51e90acf656ba90876d6f80294ed0a0', 'undefined', 1, 238, 'DirectTransfer', 110, '', '2023-12-27 20:26:01'),
(11, '0xe2055BEC5EccC218b5b045d3C7754A396c97244b', 'undefined', 1, 100, 'DirectTransfer', 100, '', '2023-12-27 20:26:49'),
(12, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 'undefined', 1, 105, 'DirectTransfer', 105, '', '2023-12-28 17:32:47'),
(13, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0xC6Ac2bF8Dab85bEB167fF952E709Bb12144307a0', 1, 105, 'DirectTransfer', 105, '', '2023-12-28 17:33:16'),
(14, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 'undefined', 1, 103, 'DirectTransfer', 103, '', '2023-12-28 17:35:49'),
(15, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 285, 'DirectTransfer', 107, '', '2023-12-29 07:35:25'),
(16, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 234, 'DirectTransfer', 114, '', '2023-12-29 08:27:34'),
(17, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 278, 'DirectTransfer', 115, '', '2023-12-29 09:18:07'),
(18, 'undefined', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 238, 'DirectTransfer', 110, '', '2023-12-29 10:14:54'),
(19, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 284, 'DirectTransfer', 113, '', '2023-12-29 10:17:21'),
(20, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 242, 'DirectTransfer', 111, '', '2023-12-29 10:18:51'),
(21, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 290, 'DirectTransfer', 109, '', '2023-12-29 10:20:21'),
(22, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 'undefined', 1, 284, 'DirectTransfer', 113, '', '2023-12-29 11:02:49'),
(23, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 238, 'DirectTransfer', 110, '', '2023-12-29 16:42:13'),
(24, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:44:32'),
(25, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:47:22'),
(26, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:47:39'),
(27, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:52:24'),
(28, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:52:42'),
(29, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:53:11'),
(30, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:53:29'),
(31, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:53:51'),
(32, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:55:16'),
(33, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:55:48'),
(34, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:56:11'),
(35, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:57:59'),
(36, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:58:13'),
(37, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:58:36'),
(38, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:58:54'),
(39, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 16:59:47'),
(40, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 17:00:13'),
(41, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 17:00:31'),
(42, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 17:00:45'),
(43, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 17:01:04'),
(44, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 17:01:16'),
(45, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 17:01:23'),
(46, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 238, 'DirectTransfer', 110, '', '2023-12-29 17:02:38'),
(47, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 242, 'DirectTransfer', 111, '', '2023-12-29 17:05:03'),
(48, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 242, 'DirectTransfer', 111, '', '2023-12-29 17:06:01'),
(49, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 242, 'DirectTransfer', 111, '', '2023-12-29 17:06:50'),
(50, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 263, 'DirectTransfer', 108, '', '2023-12-29 17:07:06'),
(51, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 217, 'DirectTransfer', 116, '', '2023-12-29 18:21:56'),
(52, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 0, 212, 'DirectTransfer', 119, '', '2023-12-29 20:22:02'),
(53, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 231, 'DirectTransfer', 120, '', '2023-12-29 20:48:06'),
(54, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 278, 'DirectTransfer', 115, '', '2023-12-29 22:07:45'),
(55, '0x1c595099456179bf9b820d49ad504c200e1c7822', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 231, 'DirectTransfer', 120, '', '2023-12-30 09:11:10'),
(56, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 217, 'DirectTransfer', 116, '', '2023-12-30 09:32:29'),
(57, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 'undefined', 1, 231, 'DirectTransfer', 120, '', '2023-12-30 19:25:09'),
(58, 'undefined', '0xc6ac2bf8dab85beb167ff952e709bb12144307a0', 0, 231, 'DirectTransfer', 120, '', '2023-12-30 19:32:47'),
(59, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0xb88f47475ee533ae8688feca71838db59c5b7469', 1, 260, 'DirectTransfer', 122, '', '2023-12-31 12:04:58'),
(60, 'undefined', '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 1, 100, 'DirectTransfer', 100, '', '2024-01-01 08:37:35'),
(61, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', 'undefined', 1, 293, 'DirectTransfer', 118, '', '2024-01-02 10:37:12'),
(62, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 217, 'DirectTransfer', 116, '', '2024-01-02 10:41:25'),
(63, '0xc6ac2bf8dab85beb167ff952e709bb12144307a0', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 231, 'DirectTransfer', 120, '', '2024-01-02 11:13:23'),
(64, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 226, 'DirectTransfer', 121, '', '2024-01-02 11:13:49'),
(65, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 1, 212, 'DirectTransfer', 119, '', '2024-01-02 11:13:59'),
(66, '0x10a521997bcC3090D8511dA685B3aB6f1255E7f3', '0x1c595099456179bf9b820d49ad504c200e1c7822', 50, 223, 'DirectTransfer', 123, '', '2024-01-02 15:07:06'),
(67, '0xb88f47475ee533ae8688feca71838db59c5b7469', '0x1c595099456179bf9b820d49ad504c200e1c7822', 12, 260, 'DirectTransfer', 122, '', '2024-01-02 15:08:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auctions`
--
ALTER TABLE `auctions`
  ADD PRIMARY KEY (`auctionId`),
  ADD KEY `tokenid from nfts` (`tokenId`);

--
-- Indexes for table `biddings`
--
ALTER TABLE `biddings`
  ADD PRIMARY KEY (`bidding_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `creators`
--
ALTER TABLE `creators`
  ADD PRIMARY KEY (`creatorID`);

--
-- Indexes for table `fixedprice`
--
ALTER TABLE `fixedprice`
  ADD PRIMARY KEY (`saleId`);

--
-- Indexes for table `nfts`
--
ALTER TABLE `nfts`
  ADD PRIMARY KEY (`nft_id`),
  ADD KEY `tokenId` (`tokenId`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indexes for table `stories`
--
ALTER TABLE `stories`
  ADD PRIMARY KEY (`storyId`),
  ADD KEY `creatorId` (`creatorId`);

--
-- Indexes for table `storyReplies`
--
ALTER TABLE `storyReplies`
  ADD PRIMARY KEY (`replyId`),
  ADD KEY `from` (`sender`),
  ADD KEY `storyId` (`storyId`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transactonId`);

--
-- Indexes for table `transfernft`
--
ALTER TABLE `transfernft`
  ADD PRIMARY KEY (`transferId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `biddings`
--
ALTER TABLE `biddings`
  MODIFY `bidding_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `cat_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `creators`
--
ALTER TABLE `creators`
  MODIFY `creatorID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `fixedprice`
--
ALTER TABLE `fixedprice`
  MODIFY `saleId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `nfts`
--
ALTER TABLE `nfts`
  MODIFY `nft_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `session_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stories`
--
ALTER TABLE `stories`
  MODIFY `storyId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `storyReplies`
--
ALTER TABLE `storyReplies`
  MODIFY `replyId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transfernft`
--
ALTER TABLE `transfernft`
  MODIFY `transferId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auctions`
--
ALTER TABLE `auctions`
  ADD CONSTRAINT `tokenid from nfts` FOREIGN KEY (`tokenId`) REFERENCES `nfts` (`tokenId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stories`
--
ALTER TABLE `stories`
  ADD CONSTRAINT `stories_ibfk_1` FOREIGN KEY (`creatorId`) REFERENCES `creators` (`creatorID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `storyReplies`
--
ALTER TABLE `storyReplies`
  ADD CONSTRAINT `storyReplies_ibfk_1` FOREIGN KEY (`storyId`) REFERENCES `stories` (`storyId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `storyReplies_ibfk_2` FOREIGN KEY (`sender`) REFERENCES `creators` (`creatorID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
