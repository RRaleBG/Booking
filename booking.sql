-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2023 at 05:55 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `idHotel` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `roomCount` int(11) NOT NULL,
  `parking` int(1) NOT NULL,
  `stars` int(11) NOT NULL,
  `imagePath` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`idHotel`, `name`, `city`, `roomCount`, `parking`, `stars`, `imagePath`) VALUES
(1, 'Central Park', 'Belgrade', 200, 100, 4, '1.jpg'),
(7, 'Viktor', 'Belgrade', 100, 120, 4, '7.jpg'),
(8, 'Resort Hotel', 'Belgrade', 140, 200, 5, '8.jpg'),
(19, 'Lux', 'Panama', 100, 50, 5, 'lux.jpg'),
(20, 'Budim', 'Budapest', 200, 200, 5, 'budapestParlament.jpg'),
(21, 'London', 'London', 150, 110, 5, 'london.jpg'),
(22, 'Brit', 'Britanica', 140, 60, 5, 'britanica.jpg'),
(23, 'Goa', 'Pancevo', 2000, 10, 5, 'costaAdeje.jpg'),
(33, 'Ivan', 'Ivangrad', 10, 150, 5, 'Hotel-Tips.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `idRes` int(11) NOT NULL,
  `idGest` int(11) NOT NULL,
  `idHotel` int(11) NOT NULL,
  `dateCheckIn` date NOT NULL,
  `dateCheckOut` date NOT NULL,
  `price` int(11) NOT NULL,
  `canceledRes` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`idRes`, `idGest`, `idHotel`, `dateCheckIn`, `dateCheckOut`, `price`, `canceledRes`) VALUES
(1, 2, 1, '2023-05-24', '2023-05-30', 150, 0),
(3, 1, 1, '2023-05-24', '2023-05-31', 150, 1),
(4, 1, 7, '2023-05-23', '2023-05-30', 100, 0);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `idRole` int(11) NOT NULL,
  `roleName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`idRole`, `roleName`) VALUES
(1, 'admin'),
(2, 'user'),
(3, 'menager');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `idRoom` int(11) NOT NULL,
  `idHotel` int(11) DEFAULT NULL,
  `number` int(11) NOT NULL,
  `bed` int(11) NOT NULL,
  `balkon` tinyint(1) NOT NULL,
  `smoking` tinyint(1) NOT NULL,
  `pets` tinyint(1) NOT NULL,
  `tv` tinyint(1) NOT NULL,
  `imgPath` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`idRoom`, `idHotel`, `number`, `bed`, `balkon`, `smoking`, `pets`, `tv`, `imgPath`) VALUES
(1, 1, 1, 2, 1, 1, 1, 1, 'soba-Central-Park-1.jpg'),
(2, 1, 2, 2, 0, 1, 1, 1, 'soba-Central-Park-2.jpg'),
(3, 7, 1, 4, 1, 1, 1, 1, 'soba-Viktor-1.jpg'),
(4, 7, 2, 4, 0, 0, 0, 0, 'soba-Viktor-2.jpg'),
(5, 7, 3, 1, 1, 0, 0, 1, 'soba-Viktor-3.jpg'),
(6, 7, 4, 1, 1, 1, 1, 1, 'soba-Viktor-4.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `username` varchar(10) NOT NULL,
  `password` varchar(10) NOT NULL,
  `email` varchar(25) NOT NULL,
  `points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `email`, `points`) VALUES
(1, 'User_First', 'User_Last', 'user', 'user', 'user@user.rs', 15),
(2, 'Manager', 'Manager', 'manager', 'manager', 'manager@manager.rs', 10),
(3, 'admin', 'admin', 'admin', 'admin', 'admin@admin.rs', 10),
(4, 'Rados', 'Rajcic', 'Rale', '1234', 'rados6320@its.edu.rs', 0);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `after_user_insert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    	INSERT into user_role (id, idRole) VALUES (new.id,idRole);
    end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `idRole` int(11) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`id`, `idRole`) VALUES
(1, 2),
(2, 3),
(3, 1),
(4, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`idHotel`) USING BTREE,
  ADD KEY `idHotel` (`idHotel`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`idRes`) USING BTREE,
  ADD UNIQUE KEY `idGest` (`idGest`,`idHotel`) USING BTREE,
  ADD KEY `idHotel` (`idHotel`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`idRole`),
  ADD UNIQUE KEY `idRole` (`idRole`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`idRoom`),
  ADD KEY `idHotel` (`idHotel`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD UNIQUE KEY `id` (`id`,`idRole`),
  ADD KEY `idRole` (`idRole`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `idHotel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `idRes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `idRole` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `idRoom` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`idHotel`) REFERENCES `hotel` (`idHotel`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`idGest`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`idHotel`) REFERENCES `hotel` (`idHotel`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`idRole`) REFERENCES `role` (`idRole`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
