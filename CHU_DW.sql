-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 17 jan. 2020 à 11:59
-- Version du serveur :  8.0.18
-- Version de PHP : 7.3.11-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `CHU_DW`
--

-- --------------------------------------------------------

--
-- Structure de la table `Document`
--

CREATE TABLE `Document` (
  `id` int(10) UNSIGNED NOT NULL,
  `compte_rendu` text,
  `date_production` datetime DEFAULT NULL,
  `fichier` mediumblob NOT NULL,
  `type_fichier` varchar(4) NOT NULL,
  `id_patient` varchar(50) NOT NULL,
  `id_sejour` varchar(50) NOT NULL,
  `id_mouvement` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Metadonnee`
--

CREATE TABLE `Metadonnee` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `id_norme` int(10) UNSIGNED NOT NULL,
  `id_document` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Mouvement`
--

CREATE TABLE `Mouvement` (
  `id` int(10) UNSIGNED NOT NULL,
  `date_entree` datetime DEFAULT NULL,
  `date_sortie` datetime DEFAULT NULL,
  `id_service` int(10) UNSIGNED NOT NULL,
  `id_sejour` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Norme`
--

CREATE TABLE `Norme` (
  `id` int(10) UNSIGNED NOT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  `type_analyse` varchar(50) NOT NULL,
  `unite_mesure` varchar(50) NOT NULL,
  `valeur_min` int(11) NOT NULL,
  `valeur_max` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Patient`
--

CREATE TABLE `Patient` (
  `IPP` varchar(50) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `date_naissance` datetime NOT NULL,
  `sexe` enum('Homme','Femme') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Sejour`
--

CREATE TABLE `Sejour` (
  `IEP` varchar(50) NOT NULL,
  `date_entree` datetime NOT NULL,
  `date_sortie` datetime DEFAULT NULL,
  `Sejourcol` varchar(45) DEFAULT NULL,
  `id_patient` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Service`
--

CREATE TABLE `Service` (
  `id` int(10) UNSIGNED NOT NULL,
  `nom` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Document`
--
ALTER TABLE `Document`
  ADD PRIMARY KEY (`id`,`id_patient`,`id_sejour`,`id_mouvement`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_Document_Patient_idx` (`id_patient`),
  ADD KEY `fk_Document_Sejour_idx` (`id_sejour`),
  ADD KEY `fk_Document_Mouvement_idx` (`id_mouvement`);

--
-- Index pour la table `Metadonnee`
--
ALTER TABLE `Metadonnee`
  ADD PRIMARY KEY (`id`,`id_norme`,`id_document`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_Metadonnee_Norme_idx` (`id_norme`),
  ADD KEY `fk_Metadonnee_Document_idx` (`id_document`);

--
-- Index pour la table `Mouvement`
--
ALTER TABLE `Mouvement`
  ADD PRIMARY KEY (`id`,`id_service`,`id_sejour`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_Mouvement_Service_idx` (`id_service`),
  ADD KEY `fk_Mouvement_Service_idx1` (`id_sejour`);

--
-- Index pour la table `Norme`
--
ALTER TABLE `Norme`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Index pour la table `Patient`
--
ALTER TABLE `Patient`
  ADD PRIMARY KEY (`IPP`),
  ADD UNIQUE KEY `IPP_UNIQUE` (`IPP`);

--
-- Index pour la table `Sejour`
--
ALTER TABLE `Sejour`
  ADD PRIMARY KEY (`IEP`,`id_patient`),
  ADD UNIQUE KEY `IEP_UNIQUE` (`IEP`),
  ADD KEY `fk_Sejour_Patient_idx` (`id_patient`);

--
-- Index pour la table `Service`
--
ALTER TABLE `Service`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Document`
--
ALTER TABLE `Document`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Metadonnee`
--
ALTER TABLE `Metadonnee`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Mouvement`
--
ALTER TABLE `Mouvement`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Norme`
--
ALTER TABLE `Norme`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Service`
--
ALTER TABLE `Service`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Document`
--
ALTER TABLE `Document`
  ADD CONSTRAINT `fk_Document_Mouvement` FOREIGN KEY (`id_mouvement`) REFERENCES `Mouvement` (`id`),
  ADD CONSTRAINT `fk_Document_Patient` FOREIGN KEY (`id_patient`) REFERENCES `Patient` (`IPP`),
  ADD CONSTRAINT `fk_Document_Sejour` FOREIGN KEY (`id_sejour`) REFERENCES `Sejour` (`IEP`);

--
-- Contraintes pour la table `Metadonnee`
--
ALTER TABLE `Metadonnee`
  ADD CONSTRAINT `fk_Metadonnee_Document` FOREIGN KEY (`id_document`) REFERENCES `Document` (`id`),
  ADD CONSTRAINT `fk_Metadonnee_Norme` FOREIGN KEY (`id_norme`) REFERENCES `Norme` (`id`);

--
-- Contraintes pour la table `Mouvement`
--
ALTER TABLE `Mouvement`
  ADD CONSTRAINT `fk_Mouvement_Sejour` FOREIGN KEY (`id_sejour`) REFERENCES `Sejour` (`IEP`),
  ADD CONSTRAINT `fk_Mouvement_Service` FOREIGN KEY (`id_service`) REFERENCES `Service` (`id`);

--
-- Contraintes pour la table `Sejour`
--
ALTER TABLE `Sejour`
  ADD CONSTRAINT `fk_Sejour_Patient` FOREIGN KEY (`id_patient`) REFERENCES `Patient` (`IPP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
