-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 08, 2022 at 03:56 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `books`
--

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `author_id` int(11) NOT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`author_id`, `fname`, `lname`) VALUES
(1, 'Leo', 'Tolstoy'),
(2, 'George', 'Orwell');

-- --------------------------------------------------------

--
-- Table structure for table `book_owner`
--

CREATE TABLE `book_owner` (
  `bo_id` int(11) NOT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `phone_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `book_owner`
--

INSERT INTO `book_owner` (`bo_id`, `fname`, `lname`, `phone_number`) VALUES
(1, 'Mark', 'Sugarberg', 123456789),
(2, 'Selina', 'Pommes', 135456789);

-- --------------------------------------------------------

--
-- Table structure for table `book_title`
--

CREATE TABLE `book_title` (
  `book_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(120) DEFAULT NULL,
  `fk_author_id` int(11) DEFAULT NULL,
  `fk_room_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `book_title`
--

INSERT INTO `book_title` (`book_id`, `name`, `description`, `fk_author_id`, `fk_room_id`) VALUES
(1, 'War and Peace', 'Epic masterpiece intertwines the lives of private and public individuals during the time of the Napoleonic wars.', 1, 1),
(2, '1984', 'A dystopian social science fiction novel and cautionary tale written by English writer George Orwell.', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `borrow_period`
--

CREATE TABLE `borrow_period` (
  `borrow_id` int(11) NOT NULL,
  `borrow_startdate` datetime DEFAULT NULL,
  `borrow_endtime` datetime DEFAULT NULL,
  `fk_bo_id` int(11) DEFAULT NULL,
  `fk_book_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `borrow_period`
--

INSERT INTO `borrow_period` (`borrow_id`, `borrow_startdate`, `borrow_endtime`, `fk_bo_id`, `fk_book_id`) VALUES
(1, '2022-02-01 13:00:00', '2022-02-10 13:00:00', 2, 2),
(2, '2022-02-10 13:00:00', '2022-02-20 13:00:00', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `family_members`
--

CREATE TABLE `family_members` (
  `fm_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `family_members`
--

INSERT INTO `family_members` (`fm_id`, `name`) VALUES
(1, 'Mom'),
(2, 'Dad');

-- --------------------------------------------------------

--
-- Table structure for table `reading_status`
--

CREATE TABLE `reading_status` (
  `read_status` tinyint(1) DEFAULT NULL,
  `fk_fm_id` int(11) DEFAULT NULL,
  `fk_book_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reading_status`
--

INSERT INTO `reading_status` (`read_status`, `fk_fm_id`, `fk_book_id`) VALUES
(0, 2, 2),
(0, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL,
  `floor` int(11) DEFAULT NULL,
  `room_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`room_id`, `floor`, `room_name`) VALUES
(1, 1, 'Living room'),
(2, 2, 'Kids room');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `book_owner`
--
ALTER TABLE `book_owner`
  ADD PRIMARY KEY (`bo_id`);

--
-- Indexes for table `book_title`
--
ALTER TABLE `book_title`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `fk_author_id` (`fk_author_id`),
  ADD KEY `fk_room_id` (`fk_room_id`);

--
-- Indexes for table `borrow_period`
--
ALTER TABLE `borrow_period`
  ADD PRIMARY KEY (`borrow_id`),
  ADD KEY `fk_bo_id` (`fk_bo_id`),
  ADD KEY `fk_book_id` (`fk_book_id`);

--
-- Indexes for table `family_members`
--
ALTER TABLE `family_members`
  ADD PRIMARY KEY (`fm_id`);

--
-- Indexes for table `reading_status`
--
ALTER TABLE `reading_status`
  ADD KEY `fk_fm_id` (`fk_fm_id`),
  ADD KEY `fk_book_id` (`fk_book_id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book_title`
--
ALTER TABLE `book_title`
  ADD CONSTRAINT `book_title_ibfk_1` FOREIGN KEY (`fk_author_id`) REFERENCES `author` (`author_id`),
  ADD CONSTRAINT `book_title_ibfk_2` FOREIGN KEY (`fk_room_id`) REFERENCES `room` (`room_id`);

--
-- Constraints for table `borrow_period`
--
ALTER TABLE `borrow_period`
  ADD CONSTRAINT `borrow_period_ibfk_1` FOREIGN KEY (`fk_bo_id`) REFERENCES `book_owner` (`bo_id`),
  ADD CONSTRAINT `borrow_period_ibfk_2` FOREIGN KEY (`fk_book_id`) REFERENCES `book_title` (`book_id`);

--
-- Constraints for table `reading_status`
--
ALTER TABLE `reading_status`
  ADD CONSTRAINT `reading_status_ibfk_1` FOREIGN KEY (`fk_fm_id`) REFERENCES `family_members` (`fm_id`),
  ADD CONSTRAINT `reading_status_ibfk_2` FOREIGN KEY (`fk_book_id`) REFERENCES `book_title` (`book_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
