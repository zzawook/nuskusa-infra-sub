-- Adminer 4.8.1 MySQL 8.0.29 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `nuskusa`;
CREATE DATABASE `nuskusa` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nuskusa`;

DROP TABLE IF EXISTS `boards`;
CREATE TABLE `boards` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `boardId` text NOT NULL,
  `boardColor` tinytext NOT NULL,
  `boardTextColor` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `commentUpvote`;
CREATE TABLE `commentUpvote` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `author` bigint NOT NULL,
  `comment` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author` (`author`),
  KEY `comment` (`comment`),
  CONSTRAINT `commentUpvote_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`id`),
  CONSTRAINT `commentUpvote_ibfk_2` FOREIGN KEY (`comment`) REFERENCES `comments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `author` bigint NOT NULL,
  `post` bigint NOT NULL,
  `content` longtext NOT NULL,
  `replyTo` bigint DEFAULT NULL,
  `lastModified` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author` (`author`),
  KEY `post` (`post`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`post`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `email` tinytext NOT NULL,
  `lastModified` timestamp NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `eventParticipations`;
CREATE TABLE `eventParticipations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` bigint NOT NULL,
  `event` tinyint NOT NULL,
  `responseData` json NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `event` (`event`),
  CONSTRAINT `eventParticipations_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `eventParticipations_ibfk_2` FOREIGN KEY (`event`) REFERENCES `events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` tinyint NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `role` int NOT NULL,
  `board` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role` (`role`),
  KEY `board` (`board`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`board`) REFERENCES `boards` (`id`),
  CONSTRAINT `permissions_ibfk_2` FOREIGN KEY (`board`) REFERENCES `boards` (`id`),
  CONSTRAINT `permissions_ibfk_3` FOREIGN KEY (`role`) REFERENCES `roles` (`id`),
  CONSTRAINT `permissions_ibfk_4` FOREIGN KEY (`board`) REFERENCES `boards` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `postUpvote`;
CREATE TABLE `postUpvote` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `author` bigint NOT NULL,
  `post` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author` (`author`),
  KEY `post` (`post`),
  CONSTRAINT `postUpvote_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`id`),
  CONSTRAINT `postUpvote_ibfk_2` FOREIGN KEY (`post`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `author` bigint NOT NULL,
  `board` bigint NOT NULL,
  `content` longtext NOT NULL,
  `isAnnouncement` tinyint NOT NULL,
  `isAnonymous` tinyint NOT NULL,
  `isHidden` tinyint NOT NULL,
  `isPinned` tinyint NOT NULL,
  `isEvent` tinyint NOT NULL,
  `lastModified` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author` (`author`),
  KEY `board` (`board`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`id`),
  CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`board`) REFERENCES `boards` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `yearOfBirth` smallint DEFAULT NULL,
  `gender` tinyint DEFAULT NULL,
  `enrolledYear` smallint DEFAULT NULL,
  `email` text CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `major` text CHARACTER SET utf32 COLLATE utf32_unicode_ci,
  `password` text CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `kakaoTalkId` tinytext CHARACTER SET utf32 COLLATE utf32_unicode_ci,
  `verified` tinyint(1) NOT NULL,
  `emailVerified` tinyint(1) NOT NULL,
  `role` tinytext CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `profileImageUrl` text CHARACTER SET utf32 COLLATE utf32_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

GRANT ALL PRIVILEGES ON `nuskusa`.* TO 'nuskusa-admin'@'localhost';
-- 2022-07-10 08:04:56