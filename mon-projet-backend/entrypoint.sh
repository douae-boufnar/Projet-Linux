#!/bin/sh

# Corriger les permissions Laravel au démarrage
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Créer le lien symbolique pour les images s'il n'existe pas
php artisan storage:link --force

# Lancer la commande passée (par défaut php-fpm)
exec "$@"
