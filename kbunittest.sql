-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Erstellungszeit: 05. Jul 2021 um 10:23
-- Server-Version: 5.7.31
-- PHP-Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `kbunittest`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur fuer Tabelle `classcoverage`
--

DROP TABLE IF EXISTS `classcoverage`;
CREATE TABLE IF NOT EXISTS `classcoverage` (
  `src_id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NOT NULL,
  `classname` varchar(255) COLLATE latin1_german1_ci NOT NULL,
  `coverage` varchar(255) COLLATE latin1_german1_ci NOT NULL,
  PRIMARY KEY (`Src_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur fuer Tabelle `linecoverage`
--

DROP TABLE IF EXISTS `linecoverage`;
CREATE TABLE IF NOT EXISTS `linecoverage` (
  `linenumber` int(11) NOT NULL,
  `color` varchar(255) COLLATE latin1_german1_ci NOT NULL,
  `method_id` int(11) DEFAULT NULL,
  `src_id` int(11) NOT NULL,
  PRIMARY KEY (`linenumber`,`src_id`),
  KEY `method_id` (`method_id`),
  KEY `linecoverage_ibfk_2` (`src_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur fuer Tabelle `methodcoverage`
--

DROP TABLE IF EXISTS `methodcoverage`;
CREATE TABLE IF NOT EXISTS `methodcoverage` (
  `method_id` int(11) NOT NULL AUTO_INCREMENT,
  `methodname` varchar(255) COLLATE latin1_german1_ci NOT NULL,
  `coverage` varchar(255) COLLATE latin1_german1_ci NOT NULL,
  `src_id` int(11) NOT NULL,
  PRIMARY KEY (`method_id`),
  KEY `Src_id` (`src_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur fuer Tabelle `testparameterinfo`
--

DROP TABLE IF EXISTS `testparameterinfo`;
CREATE TABLE IF NOT EXISTS `testparameterinfo` (
  `name` varchar(250) NOT NULL,
  `value` tinyblob,
  `testresultinfo_id` int(11) NOT NULL,
  PRIMARY KEY (`name`,`testresultinfo_id`),
  KEY `testresultinfo_id` (`testresultinfo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur fuer Tabelle `testresultinfo`
--

DROP TABLE IF EXISTS `testresultinfo`;
CREATE TABLE IF NOT EXISTS `testresultinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `path` varchar(250) NOT NULL,
  `success` tinyint(1) NOT NULL,
  `message` varchar(250) NOT NULL,
  `exceptionExpected` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `linecoverage`
--
ALTER TABLE `linecoverage`
  ADD CONSTRAINT `linecoverage_ibfk_1` FOREIGN KEY (`method_id`) REFERENCES `methodcoverage` (`method_id`),
  ADD CONSTRAINT `linecoverage_ibfk_2` FOREIGN KEY (`src_id`) REFERENCES `classcoverage` (`src_id`);

--
-- Constraints der Tabelle `methodcoverage`
--
ALTER TABLE `methodcoverage`
  ADD CONSTRAINT `methodcoverage_ibfk_1` FOREIGN KEY (`src_id`) REFERENCES `classcoverage` (`src_id`);

--
-- Constraints der Tabelle `testparameterinfo`
--
ALTER TABLE `testparameterinfo`
  ADD CONSTRAINT `testparameterinfo_ibfk_1` FOREIGN KEY (`testresultinfo_id`) REFERENCES `testresultinfo` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
