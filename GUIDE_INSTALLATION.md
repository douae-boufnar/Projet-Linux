# Guide d'Installation et de Résolution des Problèmes

Si vous rencontrez des problèmes avec Docker (containers qui redémarrent en boucle ou images qui ne s'affichent pas), suivez ce guide.

## 1. Configuration du fichier .env
Assurez-vous d'avoir un fichier nommé exactement `.env` dans le dossier `mon-projet-backend/` avec le contenu suivant :

```env
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=root
DB_PASSWORD=root
APP_URL=http://localhost:8000
FILESYSTEM_DRIVER=public
```

## 2. Réinitialisation de Docker (Procédure recommandée)
Pour éviter les conflits de ports ou de données corrompues, lancez ces commandes dans votre terminal à la racine du projet :

1. **Arrêter et supprimer les volumes existants** :
   ```bash
   docker-compose down -v
   ```

2. **Reconstruire et lancer les containers** :
   ```bash
   docker-compose up --build
   ```

## 3. Accès aux Services
Une fois que tous les containers sont au vert dans Docker Desktop :

*   **Application (Frontend)** : [http://localhost:4200](http://localhost:4200)
*   **API / Images (Backend)** : [http://localhost:8000](http://localhost:8000)
*   **Base de données (PHPMyAdmin)** : [http://localhost:8081](http://localhost:8081)
    *   *Serveur* : `mysql`
    *   *Utilisateur* : `root`
    *   *Mot de passe* : `root`

---
**Note sur MySQL** : Le port externe a été changé en `3307` pour éviter les conflits avec un MySQL local sur Windows. Dans votre `.env`, laissez `DB_PORT=3306` car c'est le port interne au réseau Docker.
