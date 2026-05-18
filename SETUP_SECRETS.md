# 🔐 Guide de Configuration des Secrets GitHub

> Ce guide explique comment configurer les secrets nécessaires pour que le pipeline CI/CD fonctionne avec AWS et Terraform.

---

## 📋 Secrets à ajouter dans GitHub

Aller sur GitHub → **Settings → Secrets and variables → Actions → New repository secret**

| Nom du Secret | Description | Exemple |
|---|---|---|
| `AWS_ACCESS_KEY_ID` | Clé d'accès AWS IAM | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | Clé secrète AWS IAM | `wJalrXUtnFEMI/K7MDENG/...` |
| `SSH_PRIVATE_KEY` | Contenu du fichier `.pem` pour SSH | `-----BEGIN RSA PRIVATE KEY-----...` |
| `DOCKERHUB_USERNAME` | Votre nom d'utilisateur Docker Hub | `reda7856` |
| `DOCKERHUB_TOKEN` | Access Token Docker Hub (PAT) | `dckr_pat_...` |

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
   │
   └─► CD : SSH Deploy (Docker Update)
         │
         └─► Conteneurs mis à jour sur EC2
```

---

## 🔑 Obtenir la clé SSH (`SSH_PRIVATE_KEY`)
...
4. Collez-le dans un nouveau secret GitHub nommé `SSH_PRIVATE_KEY`.

---

## 🐳 Obtenir un Token Docker Hub (`DOCKERHUB_TOKEN`)

1. Connectez-vous sur [Docker Hub](https://hub.docker.com/).
2. Allez dans **Account Settings** -> **Security**.
3. Cliquez sur **New Access Token**.
4. Donnez un nom (ex: `github-actions`) et générez-le.
5. Copiez le token et ajoutez-le en secret GitHub sous le nom `DOCKERHUB_TOKEN`.
