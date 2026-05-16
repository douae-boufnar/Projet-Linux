# 🐧 Projet Linux — Plateforme Web DevOps

Application web full-stack déployée automatiquement sur AWS EC2 via un pipeline CI/CD complet (GitHub Actions + Terraform).

---

## 🏗️ Architecture
- **Backend** : Laravel 10 (PHP 8.2)
- **Frontend** : Angular 17
- **Base de données** : MySQL 8.0
- **Infrastructure** : AWS EC2 (Terraform)
- **CI/CD** : GitHub Actions

---

## 🔄 Pipeline CI/CD
1. **Tests** : Tests automatiques Laravel & Angular à chaque push.
2. **Infrastructure** : Terraform valide et déploie l'infrastructure sur AWS.
3. **Déploiement** : Docker Compose lance les conteneurs sur l'instance EC2.

---

## 📂 Documentation
- [Guide de configuration des Secrets](./SETUP_SECRETS.md)
- [Configuration Terraform](./terraform/README.md)
