-- Restauration forcée de la base
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS laravel_db;
USE laravel_db;

-- On vide tout pour repartir sur du propre
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `livres`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `personal_access_tokens`;
DROP TABLE IF EXISTS `users`;
SET FOREIGN_KEY_CHECKS = 1;

-- Table categories
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `nom`, `created_at`) VALUES
(1, 'Informatique', '2026-04-28 15:09:46'),
(2, 'Sciences', '2026-04-28 15:09:46'),
(3, 'Litterature', '2026-04-28 15:09:46'),
(4, 'Histoire', '2026-04-28 15:09:46'),
(5, 'Economie', '2026-04-28 15:09:46');

-- Table livres
CREATE TABLE `livres` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auteur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contenu` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `livres_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `livres` (`id`, `titre`, `auteur`, `description`, `image`, `contenu`, `category_id`, `created_at`) VALUES
-- Informatique
(1, 'Mastering Laravel 11', 'Taylor Otwell', 'Le guide ultime pour maîtriser le framework PHP le plus populaire.', 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=500', 'https://raw.githubusercontent.com/Annihil/Ebooks/master/Clean%20Code.pdf', 1, '2026-04-28 15:19:20'),
(2, 'Clean Code', 'Robert C. Martin', 'La bible du développement logiciel pour écrire du code propre et maintenable.', 'https://images.unsplash.com/photo-1542831371-29b0f74f9713?w=500', 'https://raw.githubusercontent.com/Annihil/Ebooks/master/Clean%20Code.pdf', 1, '2026-04-28 15:19:20'),

-- Sciences
(3, 'Intelligence Artificielle', 'Yann LeCun', 'Plongez dans le futur avec ce manuel complet sur le Deep Learning.', 'https://images.unsplash.com/photo-1507146426996-ef05306b995a?w=500', 'https://arxiv.org/pdf/1803.01271.pdf', 2, '2026-04-28 15:19:20'),
(4, 'Cosmos', 'Carl Sagan', 'Une épopée à travers l''espace et le temps pour comprendre notre univers.', 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=500', 'https://raw.githubusercontent.com/jurgens/programming-books/master/cosmos-carl-sagan.pdf', 2, '2026-04-28 15:19:20'),

-- Litterature
(5, 'Les Miserables', 'Victor Hugo', 'Un chef-d''œuvre intemporel sur la rédemption et l''amour.', 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500', 'https://www.planetpublish.com/wp-content/uploads/2011/11/1984.pdf', 3, '2026-04-28 15:19:20'),
(6, 'Le Petit Prince', 'Antoine de Saint-Exupery', 'Un conte poétique et philosophique qui émerveille tout le monde.', 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500', 'https://www.lepetitprince.com/wp-content/uploads/2015/04/LPP_Livre.pdf', 3, '2026-04-28 15:19:20'),

-- Histoire
(7, 'Sapiens', 'Yuval Noah Harari', 'Une brève histoire de l''humanité, de l''âge de pierre à aujourd''hui.', 'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=500', 'https://raw.githubusercontent.com/Ariel-Saldana/books/master/A%20Brief%20History%20Of%20Time%20-%20Stephen%20Hawking.pdf', 4, '2026-04-28 15:19:20'),
(8, 'Une Breve Histoire du Temps', 'Stephen Hawking', 'Une exploration des mystères de l''univers et du temps.', 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500', 'https://raw.githubusercontent.com/Ariel-Saldana/books/master/A%20Brief%20History%20Of%20Time%20-%20Stephen%20Hawking.pdf', 4, '2026-04-28 15:19:20'),

-- Economie
(9, 'Le Capital au XXIe siecle', 'Thomas Piketty', 'Une analyse profonde sur la répartition des revenus et de la richesse.', 'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=500', 'https://socialsciences.mcmaster.ca/econ/ugcm/3ll3/marx/capital/capital1.pdf', 5, '2026-04-28 15:19:20'),
(10, 'Pere Riche Pere Pauvre', 'Robert Kiyosaki', 'Un livre culte sur l''éducation financière et l''indépendance.', 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=500', 'https://raw.githubusercontent.com/Annihil/Ebooks/master/Rich%20Dad%20Poor%20Dad.pdf', 5, '2026-04-28 15:19:20');

-- Table users
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','user') COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `nom`, `prenom`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Admin', 'Super', 'admin@example.com', 'admin123', 'admin', '2026-04-28 15:09:46'),
(2, 'reda', 'redaZakaru', 'zakariareda1@gmail.com', 'reda123', 'user', '2026-04-28 15:21:43'),
(3, 'redaazerty', 'azerty', 'azerty@gmail.com', 'azerty123', 'user', '2026-04-28 18:22:03'),
(4, 'aya', 'dahbi', 'aya3@gmail', 'aya123', 'user', '2026-04-30 10:53:58');

-- Table personal_access_tokens
CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

COMMIT;
