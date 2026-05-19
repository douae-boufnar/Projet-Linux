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
(5, 'Economie', '2026-04-28 15:09:46'),
(6, 'Romance', '2026-04-28 15:09:46');

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
-- Déchargement de
INSERT INTO `livres` (`id`, `titre`, `auteur`, `description`, `image`, `contenu`, `category_id`, `created_at`) VALUES
(1, 'Developpement en Informatique', 'Michel Gines', 'Le guide ultime pour maitriser le framework PHP le plus populaire.', 'https://images.epagine.fr/134/9782409029134_1_75.jpg', 'file:///C:/Users/pc/Downloads/sys.pdf', 1, '2026-04-28 15:19:20'),
(13, 'Woman Down', 'colleen hoover', 'Her words used to set the page on fire. But a viral backlash over her latest film adaptation forced Petra Rose to take a hiatus, resulting in missed deadlines and an overdue mortgage. Branded a fraud and fame-hungry opportunist, she learned the hard way what happens when the internet turns on you. And she’s been uninspired to write ever since.', 'https://www.colleenhoover.com/cdn/shop/files/WD_image_1399x2173.jpg?v=1768239181', 'https://www.google.com/url?sa=t&source=web&rct=j&url=https%3A%2F%2Fwww.colleenhoover.com%2Fproducts%2Fwoman-down&ved=0CBYQjRxqFwoTCKiar6PHtpQDFQAAAAAdAAAAABAG&opi=89978449', 3, '2026-05-13 15:18:07'),
(14, 'introduction a l\'informatique', 'G. Santini, J.-C. Dubacq', 'Les cours et exercices de ce module sont directement inspirés des documents de M. Bosc, J.-C.\r\nDubacq et G. Santini.\r\n… D’autres intervenants ont participé à l’élaboration des supports', 'https://servimg.eyrolles.com/static/media/2172/9782340012172_internet_h1400.jpg', 'https://lipn.univ-paris13.fr/~dubacq/pdf/m1101/sys.pdf', 1, '2026-05-13 15:46:26'),
(15, 'La Boite a Merveille', 'Ahmed SEFRIOUI', '« La Boîte à Merveilles » (1954) est un roman autobiographique d\'Ahmed Sefrioui dépeignant la vie traditionnelle à Fès au début du XXe siècle à travers les yeux de Sidi Mohammed, un enfant solitaire de 6 ans. Véritable refuge imaginaire, cette boîte contient des objets hétéroclites (boules de verre, boutons, clous) qui aident le narrateur à échapper à la solitude et au monde réel.', 'https://m.media-amazon.com/images/I/51wfbHG7f1L._AC_UF1000,1000_QL80_.jpg', 'https://conjuguer.e-monsite.com/medias/files/boite.pdf', 3, '2026-05-13 16:39:58'),
(16, 'La ficelle', 'GUY DE MAUPASSANT', '« La Ficelle » est une nouvelle réaliste de Guy de Maupassant publiée en 1883, décrivant la puissance destructrice de la rumeur dans une communauté rurale normande. L\'histoire suit Maître Hauchecorne, un paysan économe accusé à tort de vol après avoir ramassé un bout de ficelle, qui meurt obsédé par cette injustice.', 'https://m.media-amazon.com/images/I/618N7OIkCnL._AC_UF1000,1000_QL80_.jpg', 'https://promeneur-libre.raindrop.jp/litterature/pdf_fr/MAUPASSANT__La_Ficelle.pdf', 3, '2026-05-13 16:42:45'),
(17, 'TOUT sur L\'ECONOMIE', 'Nicolas Olivier', 'Ceux qui me connaissent déjà savent que j’ai une prédilection pour\r\nles schémas, graphiques et autres infographies pour faire comprendre\r\nles processus parfois complexes à l’œuvre en économie. Je vais donc\r\ncommencer par vous présenter les « personnages récurrents » de ces\r\nschémas, ceux qui reviendront tout le temps dans les représentations\r\ngraphiques et ne seront pas nécessairement légendés. Voici donc ces\r\n« incontournables » de l’économie et leurs « avatars »', 'https://products-images.di-static.com/image/gilles-mitteau-tout-sur-l-economie-ou-presque/9782228934978-475x500-1.jpg', 'https://excerpts.numilog.com/books/9782228926133.pdf', 5, '2026-05-13 16:48:01'),
(18, 'Le Monde Des Mers', 'Braun Dieter', 'Le livre Le monde des mers (illustré par Dieter Braun) est un ouvrage illustré offrant une plongée immersive dans l\'univers marin. Il explore la biodiversité, les créatures, les épaves, les sports et les paysages côtiers, offrant un voyage visuel complet sur les écosystèmes océaniques, idéal pour les curieux.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ33zzSwFVyXitHuK4wnmVl9ROzERcAdBGP7w&s', 'https://geohistoire.e-monsite.com/medias/files/cours-mers-et-oceans.pdf', 2, '2026-05-13 16:55:07'),
(19, 'La guerre et la paix', 'Comte Léon Tolstoï', 'La Guerre et la Paix (1865-1869) de Léon Tolstoï est une fresque épique monumentale entremêlant les destins fictifs de familles de la noblesse russe (Bézoukhov, Bolkonski, Rostov) aux événements réels des guerres napoléoniennes (1805-1812). Il dépeint la société russe en mutation entre batailles sanglantes et vie mondaine à Moscou', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK-lIT5IFTMOOksqZt43PUgEaThxvzAOzUFg&s', 'https://www.ebooksgratuits.com/pdf/tolstoi_guerre_et_paix_1.pdf', 4, '2026-05-13 16:57:39'),
(20, 'LA SCIENCE ET LE VIVANT', 'Bernard Feltz', 'La science du vivant, principalement incarnée par la biologie, étudie les organismes vivants (animaux, végétaux, micro-organismes) dans leur structure, leur évolution et leurs interactions, englobant la biochimie, la génétique et l\'écologie. Elle définit le vivant par sa capacité de croissance, de reproduction et de métabolisme, cherchant à comprendre le fonctionnement cellulaire et la complexité des êtres.', 'https://www.deboecksuperieur.com/sites/default/files/couvertures/9782804171445-g.jpg', 'https://www.furet.com/media/pdf/feuilletage/9/7/8/2/8/0/4/1/9782804171445.pdf?srsltid=AfmBOorwhIB0hsXN5c85a3A4PjczTiZ9vk4JmJHEsjH9XqhSjABE3O0N', 2, '2026-05-13 17:03:57'),
(21, 'Du Soleil a la Terre', 'Jean Bornarel', '« Du Soleil à la Terre » (J. Lilensten, EDP Sciences) est un ouvrage de référence, principalement axé sur la physique, qui analyse les interactions entre l\'astre solaire et notre planète. Il explore l\'érosion atmosphérique, le champ magnétique, les aurores boréales et la météorologie de l\'espace, s\'adressant à un public de niveau universitaire (DEUG/Maîtrise).', 'https://servimg.eyrolles.com/static/media/0767/9782705950767_internet_w290.jpg', 'https://www.edp-open.org/images/stories/books/fulldl/du-soleil-a-la-terre.pdf', 2, '2026-05-13 17:07:52'),
(23, 'La Science et l\'Hypothèse', 'Henri Poincaré', 'La Science et l\'Hypothèse (1902) est un ouvrage majeur du mathématicien Henri Poincaré analysant les fondements des sciences. Il y soutient que la science n\'atteint pas de vérité absolue, mais repose sur des conventions et des hypothèses utiles, notamment en mathématiques, géométrie, mécanique et physique, remettant en cause l\'idée d\'une logique infaillible.', 'https://m.media-amazon.com/images/I/61VgEqeNWoL._AC_UF1000,1000_QL80_.jpg', 'https://www.ebooksgratuits.com/pdf/poincare_science_hypothese.pdf', 2, '2026-05-13 17:41:24'),
(24, 'Une brave histoire de l\'avenir', 'Jacques Attali', 'Une brave histoire de l\'avenir\" est un ouvrage de prospective majeur écrit par Jacques Attali, paru initialement en 2006 (et mis à jour ultérieurement), qui dresse une analyse de l\'évolution du monde sur les 50 prochaines années. L\'auteur s\'appuie sur l\'histoire de l\'humanité pour en tirer des lois permettant de prévoir les bouleversements futurs.', 'https://guenolasix.com/wp-content/uploads/2016/02/Breve_01.jpg', 'https://files.lebrief.ma/uploads/2022/08/22113144/Une-bre%CC%80ve-histoire-de-lavenir-French-Edition-Attali-Jacques-z-lib.org_.pdf', 4, '2026-05-13 17:44:27'),
(25, 'Histoire universelle, des origines à nos jours', 'CH.De l\'ANDELYN', 'Histoire universelle, des origines à nos jours (Ch. de L\'Andelyn, Payot) est un ouvrage historique majeur, souvent réédité, visant à synthétiser l\'évolution de l\'humanité dans un récit global. Il couvre la préhistoire, l\'Antiquité, et le développement des civilisations, incluant l\'Égypte, la Grèce, Rome, l\'Asie, jusqu\'à l\'époque contemporaine.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD-h0axHpZsPoedmMnbjcsLomK61Qocc9RzA&s', 'https://excerpts.numilog.com/books/9782307367130.pdf', 4, '2026-05-13 17:47:12'),
(26, 'L\'informatique de gestion', 'Gerard Bauvin', 'L\'informatique de gestion (IDG) est une branche de l\'informatique qui applique les technologies de l\'information pour optimiser les processus administratifs et commerciaux des entreprises. Elle permet de collecter, stocker, traiter et automatiser d\'importants volumes de données (comptabilité, RH, stocks, CRM), facilitant ainsi la prise de décision et la productivité.', 'https://pictures.abebooks.com/inventory/30987615091.jpg', 'https://excerpts.numilog.com/books/9782307374862.pdf', 1, '2026-05-13 17:52:43'),
(27, 'Informatique et sciences du numérique', 'Gilles Dowek', 'Le livre Informatique et sciences du numérique (souvent associé à la spécialité NSI ou ISN) est un manuel complet conçu pour les lycéens, axé sur les quatre piliers : algorithmes, langages (principalement Python), données et machines. Il allie théorie et pratique avec des activités, TP, et exercices, souvent basés sur la version 3 de Python.', 'https://servimg.eyrolles.com/static/media/5435/9782212135435_internet_h1400.jpg', 'https://wiki.inria.fr/wikis/sciencinfolycee/images/a/a7/Informatique_et_Sciences_du_Num%C3%A9rique_-_Sp%C3%A9cialit%C3%A9_ISN_en_Terminale_S._version_Python.pdf', 1, '2026-05-13 17:58:11');

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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