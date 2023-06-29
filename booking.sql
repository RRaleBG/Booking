-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2023 at 03:14 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

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
(38, 'Budim', 'Budapest', 100, 50, 5, 'Budim.jpg'),
(39, 'London', 'London', 100, 100, 5, 'London.jpg'),
(40, 'Lux', 'Las Vegas', 100, 100, 5, 'lux.jpg'),
(41, 'Costa Adeje', 'Las Vegas', 140, 60, 4, 'CostaAdeje.jpg');

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
(6, 1, 38, '2023-07-01', '2023-07-08', 30, 1),
(8, 1, 38, '2023-06-25', '2023-06-29', 30, 1),
(9, 1, 38, '2023-06-07', '2023-07-04', 30, 1),
(10, 1, 38, '2023-06-28', '2023-06-30', 30, 1),
(11, 1, 38, '2023-07-05', '2023-07-14', 30, 1),
(12, 1, 38, '2023-07-05', '2023-07-14', 30, 1),
(13, 1, 38, '2023-07-05', '2023-07-14', 30, 1),
(14, 1, 38, '2023-07-05', '2023-07-14', 30, 1),
(15, 1, 38, '2023-06-15', '2023-06-29', 30, 0),
(16, 1, 38, '2023-06-15', '2023-06-29', 30, 0),
(17, 1, 38, '2023-06-15', '2023-06-29', 30, 0),
(18, 5, 38, '2023-06-14', '2023-06-22', 30, 0);

--
-- Triggers `reservations`
--
DELIMITER $$
CREATE TRIGGER `trig_Points` AFTER INSERT ON `reservations` FOR EACH ROW UPDATE users 
SET points = (points + 5)
WHERE id = NEW.idGest
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trig_Points_Bris` BEFORE UPDATE ON `reservations` FOR EACH ROW UPDATE users 
SET points = (points - 5)
WHERE id = NEW.idGest
$$
DELIMITER ;

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
(9, 38, 1, 2, 1, 0, 0, 1, 'budimRoom_1.jpg'),
(10, 39, 1, 1, 0, 1, 1, 1, 'soba-Club-Resort-2.jpg'),
(11, 38, 2, 2, 1, 0, 1, 1, 'budimRoom_2.jpg'),
(12, 38, 3, 2, 0, 1, 1, 0, 'budimRoom_3.jpg'),
(13, 38, 4, 2, 0, 1, 0, 1, 'budimRoom_4.jpg'),
(14, 41, 1, 1, 1, 1, 1, 1, 'soba-Club-Resort-5.jpg'),
(15, 41, 2, 2, 1, 1, 1, 1, 'soba-Club-Resort-3.jpg');

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
(1, 'userName', 'userLastname', 'user', 'user', 'user@user.rs', 55),
(2, 'Manager', 'Manager', 'manager', 'manager', 'manager@manager.rs', 10),
(3, 'admin', 'admin', 'admin', 'admin', 'admin@admin.rs', 10),
(4, 'Rados', 'Rajcic', 'Rale', '1234', 'rados6320@its.edu.rs', 0),
(5, 'Petar', 'Peric', 'pera', 'pera', 'petar@peric.rs', 5);

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
(4, 1),
(5, 2);

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
  ADD KEY `idHotel` (`idHotel`),
  ADD KEY `idGest` (`idGest`,`idHotel`);

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
  MODIFY `idHotel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `idRes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `idRole` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `idRoom` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
