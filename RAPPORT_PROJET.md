# 📝 Rapport de Projet : Environnement DevOps Collaboratif

## 1. Introduction
Ce rapport documente la création d'un environnement de développement et de déploiement collaboratif intégrant Docker, Terraform et GitHub Actions pour une application web Laravel/Angular.

## 2. Conception & Répartition des Tâches
L'équipe a été organisée selon les rôles définis dans l'énoncé :
- **Chef de Projet** : Supervision et gestion de Notion/Jira.
- **Responsable Développement** : Implémentation des fonctionnalités métier.
- **Responsable DevOps (GitHub/Déploiement)** : Configuration des pipelines CI/CD.
- **Responsable Environnement (Docker/BDD)** : Création et gestion des images Docker.

### Gestion des tâches (Notion/Jira)
Nous avons utilisé **Notion** pour :
- Définir le backlog du projet.
- Répartir les sprints et suivre l'avancement des tâches (To Do, In Progress, Done).

## 3. Configuration Docker
Nous avons créé des images personnalisées pour garantir l'uniformité :
- **Backend** : Image basée sur `php:8.2-fpm` avec toutes les extensions nécessaires (pdo_mysql, etc.).
- **Frontend** : Image basée sur `node:20` pour le build et `nginx:alpine` pour le service.
- **Base de données** : Image MySQL 8.0 configurée avec un script d'initialisation.

Toutes les images ont été publiées sur **Docker Hub** sous le compte `reda7856`.

## 4. Automatisation avec Terraform (IaC)
L'infrastructure AWS a été automatisée pour inclure :
- Une instance **EC2 t2.micro** (éligible Free Tier).
- Un **Security Group** autorisant les ports 80 (HTTP) et 22 (SSH).
- Une installation automatique de Docker via `user_data`.

## 5. Pipeline CI/CD (GitHub Actions)
Le déploiement est entièrement automatisé :
1. **Push sur `main`** : Déclenche les tests unitaires.
2. **Terraform Apply** : Vérifie et met à jour l'infrastructure.
3. **SSH Deploy** : Se connecte au serveur, récupère le dernier code et redémarre les conteneurs.

## 6. Problèmes Rencontrés & Solutions
- **Problème** : Erreur de connexion SSH dans GitHub Actions.
  - **Solution** : Ajout de la clé privée dans les `GitHub Secrets` et configuration de l'action `appleboy/ssh-action`.
- **Problème** : Mémoire insuffisante (OOM) lors du build Angular.
  - **Solution** : Ajout d'un fichier SWAP de 2Go via Terraform.

## 7. Conclusion
Le projet répond à toutes les exigences de l'énoncé : l'infrastructure est reproductible, l'environnement est standardisé et le déploiement est automatique.
