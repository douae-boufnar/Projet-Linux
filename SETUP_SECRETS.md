# 🔐 Guide de Configuration des Secrets GitHub

> Ce guide explique comment configurer les secrets nécessaires pour que le pipeline CI/CD fonctionne avec AWS et Terraform.

---

## 📋 Secrets à ajouter dans GitHub

Aller sur GitHub → **Settings → Secrets and variables → Actions → New repository secret**

| Nom du Secret | Description | Exemple |
|---|---|---|
| `AWS_ACCESS_KEY_ID` | Clé d'accès AWS IAM | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | Clé secrète AWS IAM | `wJalrXUtnFEMI/K7MDENG/...` |

---

## 🛠️ Obtenir les credentials AWS

### Option 1 : Via AWS Console (recommandé)

1. Aller sur [AWS IAM Console](https://console.aws.amazon.com/iam/)
2. **Users** → Sélectionner votre utilisateur
3. **Security credentials** → **Create access key**
4. Choisir **"Command Line Interface (CLI)"**
5. Copier `Access key ID` et `Secret access key`

---

## 🏛️ Permissions IAM minimales requises

Votre utilisateur AWS doit avoir ces permissions (politique JSON) :

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "iam:PassRole"
      ],
      "Resource": "*"
    }
  ]
}
```

Ou plus simplement, attacher la politique gérée **`AmazonEC2FullAccess`**.

---

## 🔄 Vue d'ensemble du Pipeline

```
Push/PR
   │
   ├─► CI : Tests Laravel ──────────────────────────────────┐
   │                                                         │
   ├─► CI : Tests Angular ──────────────────────────────────┤
   │                                                         ▼
   │                                              (si push sur main)
   │                                         CD : Terraform Apply
   │                                              │
   │                                              └─► Instance EC2 AWS
```
