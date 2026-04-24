# Image PHP avec FPM
FROM php:8.2-fpm

# Installer dépendances système et les extensions php necessaire pour Laravel
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd pdo_sqlite

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir dossier de travail
WORKDIR /var/www

# Copier tout le projet Laravel
COPY . /var/www/

# Installer dépendances PHP
RUN composer install --no-dev --optimize-autoloader

# Copier le reste du projet
COPY . .

# Permissions Laravel (build time - peut être ecrasé par le volume)
RUN chmod -R 775 storage bootstrap/cache

# Copier et configurer le script d'entrée
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Exposer port PHP-FPM
EXPOSE 9000

# Lancer PHP-FPM via entrypoint (reapplique les permissions au démarrage)
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
