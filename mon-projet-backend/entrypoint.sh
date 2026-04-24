#!/bin/sh

# Corriger les permissions Laravel au démarrage
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Lancer PHP-FPM
exec php-fpm
