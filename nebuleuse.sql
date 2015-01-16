-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Ven 16 Janvier 2015 à 23:56
-- Version du serveur :  5.6.21
-- Version de PHP :  5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `nebuleuse`
--

-- --------------------------------------------------------

--
-- Structure de la table `neb_config`
--

CREATE TABLE IF NOT EXISTS `neb_config` (
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `neb_config`
--

INSERT INTO `neb_config` (`name`, `value`) VALUES
('maintenance', '0'),
('maintenanceMessage', 'Main server is undergoing maintenance.'),
('gameVersion', '1'),
('subMessage', ''),
('sessionTimeout', '1800'),
('gameKey', ''),
('gameName', ''),
('updaterVersion', '1'),
('autoRegister', 'true');

-- --------------------------------------------------------

--
-- Structure de la table `neb_mirrors`
--

CREATE TABLE IF NOT EXISTS `neb_mirrors` (
`id` smallint(5) unsigned NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `neb_sessions`
--

CREATE TABLE IF NOT EXISTS `neb_sessions` (
  `userid` int(10) unsigned NOT NULL,
  `lastAlive` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sessionId` varchar(36) NOT NULL,
  `sessionStart` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `neb_updates`
--

CREATE TABLE IF NOT EXISTS `neb_updates` (
  `version` int(11) NOT NULL,
  `log` text NOT NULL,
  `size` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `neb_users`
--

CREATE TABLE IF NOT EXISTS `neb_users` (
`id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rank` tinyint(3) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `neb_users`
--

INSERT INTO `neb_users` (`id`, `username`, `password`, `rank`) VALUES
(1, 'test', 'test', 1),
(4, 'bite', 'test', 1),
(5, '', '', 1);

-- --------------------------------------------------------

--
-- Structure de la table `neb_users_achievements`
--

CREATE TABLE IF NOT EXISTS `neb_users_achievements` (
  `userid` int(10) unsigned NOT NULL,
  `achievementid` int(10) unsigned NOT NULL,
  `progress` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `neb_users_stats`
--

CREATE TABLE IF NOT EXISTS `neb_users_stats` (
  `userid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `neb_users_stats`
--

INSERT INTO `neb_users_stats` (`userid`, `name`, `value`) VALUES
(1, 'kills', 1),
(1, 'timePlayed', 10);

-- --------------------------------------------------------

--
-- Structure de la table `neb_users_stats_kills`
--

CREATE TABLE IF NOT EXISTS `neb_users_stats_kills` (
  `userid` bigint(20) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `z` int(11) NOT NULL,
  `weapon` varchar(255) NOT NULL,
  `map` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `neb_users_stats_kills`
--

INSERT INTO `neb_users_stats_kills` (`userid`, `x`, `y`, `z`, `weapon`, `map`) VALUES
(1, 0, 0, 0, 'a', 'saucisse');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `neb_mirrors`
--
ALTER TABLE `neb_mirrors`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `neb_sessions`
--
ALTER TABLE `neb_sessions`
 ADD PRIMARY KEY (`userid`);

--
-- Index pour la table `neb_updates`
--
ALTER TABLE `neb_updates`
 ADD PRIMARY KEY (`version`);

--
-- Index pour la table `neb_users`
--
ALTER TABLE `neb_users`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `neb_users_stats_kills`
--
ALTER TABLE `neb_users_stats_kills`
 ADD KEY `userid` (`userid`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `neb_mirrors`
--
ALTER TABLE `neb_mirrors`
MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `neb_users`
--
ALTER TABLE `neb_users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
