-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql:3306
-- Généré le : sam. 09 mai 2026 à 12:28
-- Version du serveur : 8.4.9
-- Version de PHP : 8.3.26
/*
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
=======
*/

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `laravel_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `nom`, `created_at`) VALUES
(1, 'Informatique', '2026-04-28 15:09:46'),
(2, 'Sciences', '2026-04-28 15:09:46'),
(3, 'Litterature', '2026-04-28 15:09:46'),
(4, 'Histoire', '2026-04-28 15:09:46'),
(5, 'Economie', '2026-04-28 15:09:46');

-- --------------------------------------------------------

--
-- Structure de la table `livres`
--

CREATE TABLE `livres` (
  `id` int NOT NULL,
  `titre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auteur` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contenu` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `livres`
--

INSERT INTO `livres` (`id`, `titre`, `auteur`, `description`, `image`, `contenu`, `category_id`, `created_at`) VALUES
(1, 'Mastering Laravel 11', 'Taylor Otwell', 'Le guide ultime pour maÃ®triser le framework PHP le plus populaire.', 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=500', 'https://raw.githubusercontent.com/Annihil/Ebooks/master/Clean%20Code.pdf', 1, '2026-04-28 15:19:20'),
(2, 'Clean Code', 'Robert C. Martin', 'La bible du dÃ©veloppement logiciel pour Ã©crire du code propre et maintenable.', 'https://images.unsplash.com/photo-1542831371-29b0f74f9713?w=500', 'https://raw.githubusercontent.com/Annihil/Ebooks/master/Clean%20Code.pdf', 1, '2026-04-28 15:19:20'),
(3, 'Intelligence Artificielle', 'Yann LeCun', 'Plongez dans le futur avec ce manuel complet sur le Deep Learning.', 'https://images.unsplash.com/photo-1507146426996-ef05306b995a?w=500', 'https://arxiv.org/pdf/1803.01271.pdf', 2, '2026-04-28 15:19:20'),
(4, 'Cosmos', 'Carl Sagan', 'Une Ã©popÃ©e Ã  travers l\'espace et le temps pour comprendre notre univers.', 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=500', 'https://raw.githubusercontent.com/jurgens/programming-books/master/cosmos-carl-sagan.pdf', 2, '2026-04-28 15:19:20'),
(5, 'Les Miserables', 'Victor Hugo', 'Un chef-d\'Å“uvre intemporel sur la rÃ©demption et l\'amour.', 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500', 'https://www.planetpublish.com/wp-content/uploads/2011/11/1984.pdf', 3, '2026-04-28 15:19:20'),
(6, 'Le Petit Prince', 'Antoine de Saint-Exupery', 'Un conte poÃ©tique et philosophique qui Ã©merveille tout le monde.', 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500', 'https://www.lepetitprince.com/wp-content/uploads/2015/04/LPP_Livre.pdf', 3, '2026-04-28 15:19:20'),
(7, 'Sapiens', 'Yuval Noah Harari', 'Une brÃ¨ve histoire de l\'humanitÃ©, de l\'Ã¢ge de pierre Ã  aujourd\'hui.', 'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=500', 'https://raw.githubusercontent.com/Ariel-Saldana/books/master/A%20Brief%20History%20Of%20Time%20-%20Stephen%20Hawking.pdf', 4, '2026-04-28 15:19:20'),
(8, 'Une Breve Histoire du Temps', 'Stephen Hawking', 'Une exploration des mystÃ¨res de l\'univers et du temps.', 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500', 'https://raw.githubusercontent.com/Ariel-Saldana/books/master/A%20Brief%20History%20Of%20Time%20-%20Stephen%20Hawking.pdf', 4, '2026-04-28 15:19:20'),
(9, 'Le Capital au XXIe siecle', 'Thomas Piketty', 'Une analyse profonde sur la rÃ©partition des revenus et de la richesse.', 'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=500', 'https://socialsciences.mcmaster.ca/econ/ugcm/3ll3/marx/capital/capital1.pdf', 5, '2026-04-28 15:19:20'),
(10, 'Pere Riche Pere Pauvre', 'Robert Kiyosaki', 'Un livre culte sur l\'Ã©ducation financiÃ¨re et l\'indÃ©pendance.', 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=500', 'https://raw.githubusercontent.com/Annihil/Ebooks/master/Rich%20Dad%20Poor%20Dad.pdf', 5, '2026-04-28 15:19:20');

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 5, 'auth_token', 'c899db56ef2fbf5d8bc66b623d81ed7a0515f01672e6b299b1887dfc9cb80150', '[\"*\"]', NULL, NULL, '2026-05-08 00:10:15', '2026-05-08 00:10:15'),
(2, 'App\\Models\\User', 5, 'auth_token', '723f7bd30f9528d2b254a4eb7e1f91588148c331c80218787fd275eae0d9ffd2', '[\"*\"]', NULL, NULL, '2026-05-08 00:10:19', '2026-05-08 00:10:19'),
(3, 'App\\Models\\User', 5, 'auth_token', '3d0ad25b2c967559fa2d9181fa6c477de5162ec126181a6e7379d3103e3c7652', '[\"*\"]', NULL, NULL, '2026-05-09 11:07:10', '2026-05-09 11:07:10'),
(4, 'App\\Models\\User', 5, 'auth_token', '0c76490ff5b024542c6117bdeadd2b6a123bde047476a9243deed1a92eff5661', '[\"*\"]', NULL, NULL, '2026-05-09 11:08:03', '2026-05-09 11:08:03'),
(5, 'App\\Models\\User', 1, 'auth_token', 'd98527702168eeebf55069aed1176612ab818b75f9490455d54be27836f61666', '[\"*\"]', NULL, NULL, '2026-05-09 11:45:12', '2026-05-09 11:45:12');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `prenom`, `email`, `email_verified_at`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'Super', 'admin@example.com', NULL, 'admin123', 'admin', '2026-04-28 15:09:46', '2026-05-09 11:49:53'),
(2, 'reda', 'redaZakaru', 'zakariareda1@gmail.com', NULL, 'reda123', 'user', '2026-04-28 15:21:43', '2026-05-09 11:49:53'),
(3, 'redaazerty', 'azerty', 'azerty@gmail.com', NULL, 'azerty123', 'user', '2026-04-28 18:22:03', '2026-05-09 11:49:53'),
(4, 'aya', 'dahbi', 'aya3@gmail', NULL, 'aya123', 'user', '2026-04-30 10:53:58', '2026-05-09 11:49:53'),
(5, 'AYA', 'Dahbi', 'ayadahbi20040@gmail.com', NULL, 'aya123', 'user', '2026-05-08 00:10:15', '2026-05-09 11:51:00');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `livres`
--
ALTER TABLE `livres`
  ADD PRIMARY KEY (`id`),
  ADD KEY `livres_ibfk_1` (`category_id`);

--
-- Index pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `livres`
--
ALTER TABLE `livres`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `livres`
--
ALTER TABLE `livres`
  ADD CONSTRAINT `livres_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;