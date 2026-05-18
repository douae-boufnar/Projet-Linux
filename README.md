# 🐧 Mini-Projet : Environnement DevOps Collaboratif (Docker & Terraform)

Ce projet implémente un environnement de développement et de production standardisé pour une application web (Laravel + Angular) en utilisant les outils DevOps modernes : **Docker**, **Terraform**, **GitHub Actions** et **AWS**.

---

## 📋 Présentation du Projet
L'objectif est de résoudre les problèmes d'hétérogénéité des environnements de développement au sein d'une équipe. Grâce à Docker, chaque membre travaille sur une configuration identique, et grâce à Terraform, l'infrastructure de déploiement est reproductible à l'identique.

### 🛠️ Stack Technique
- **Frontend** : Angular 17
- **Backend** : Laravel 10 (PHP 8.2)
- **Base de données** : MySQL 8.0
- **Serveur Web** : Nginx (Reverse Proxy)
- **Infrastructure** : AWS EC2 (Terraform)
- **CI/CD** : GitHub Actions
- **Conteneurisation** : Docker & Docker Compose

---

## 🚀 Fonctionnalités Clés
- **Standardisation Docker** : Images partagées sur Docker Hub pour garantir la cohérence.
- **Infrastructure as Code (IaC)** : Déploiement automatique du serveur sur AWS avec Terraform.
- **Pipeline CI/CD complet** : 
  - Tests unitaires et d'intégration à chaque push.
  - Déploiement automatique sur le serveur de production lors d'un push sur `main`.
- **Mise à jour sans interruption** : Utilisation de SSH pour mettre à jour les conteneurs sans recréer le serveur.

---

## 📂 Structure du Projet
- `/terraform` : Configuration de l'infrastructure AWS.
- `/mon-projet-backend` : Code source Laravel + Dockerfile.
- `/frontend` : Code source Angular + Dockerfile.
- `.github/workflows` : Pipelines de test et de déploiement.

---

## 📖 Documentation détaillée
1. [**Rapport de Projet**](./RAPPORT_PROJET.md) - Conception, rôles et gestion des tâches.
2. [**Guide de Configuration (Secrets)**](./SETUP_SECRETS.md) - Étape essentielle pour le déploiement.
3. [**Guide d'Installation Locale**](./GUIDE_INSTALLATION.md) - Pour les développeurs.

---

## 👤 Équipe (Exemple de répartition)
- **Chef de Projet** : [Nom] (Gestion Jira/Notion & Validation)
- **Dév Backend / Docker** : [Nom] (Images Docker & API)
- **Dév Frontend** : [Nom] (Interface Angular)
- **Responsable DevOps** : [Nom] (GitHub Actions & Terraform)
