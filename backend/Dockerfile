# Image PHP avec FPM
FROM php:8.2-fpm

# Installer dépendances système
RUN apt-get update && apt-get install -y \
    git curl zip unzip 
    libpng-dev libonig-dev \ libsqlite3-dev\&&docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd pdo_sqlite



# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir dossier de travail
WORKDIR /var/www

COPY laravel-backend/ /var/www/


# Installer dépendances PHP
RUN composer install




RUN php artisan key:generate

# Exposer port PHP-FPM
EXPOSE 9000

# Lancer PHP-FPM
CMD ["php-fpm"]
