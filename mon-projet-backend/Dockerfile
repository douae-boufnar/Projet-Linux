# Image PHP avec FPM
FROM php:8.2-fpm

# Installer dépendances système
RUN apt-get update && apt-get install -y \
    git curl zip unzip \
    libpng-dev libonig-dev libxml2-dev

# Installer extensions PHP nécessaires pour Laravel
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir dossier de travail
WORKDIR /var/www

# Copier seulement composer (optimisation cache)
COPY composer.json composer.lock ./

# Installer dépendances PHP
RUN composer install --no-dev --optimize-autoloader

# Copier le reste du projet
COPY . .

# Permissions Laravel
RUN chmod -R 777 storage bootstrap/cache

# Exposer port PHP-FPM
EXPOSE 9000

# Lancer PHP-FPM
CMD ["php-fpm"]