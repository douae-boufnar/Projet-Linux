# Étape 1 : PHP-FPM
FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev

RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY . .

RUN composer install

# Étape 2 : Nginx
FROM nginx:alpine

COPY --from=0 /var/www /var/www

# config nginx (très important)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80