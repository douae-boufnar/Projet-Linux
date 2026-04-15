FROM mysql:8

# Dossier de travail (optionnel mais propre)
WORKDIR /var/lib/mysql

# Variables d’environnement
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=laravel_db
ENV MYSQL_USER=laravel_user
ENV MYSQL_PASSWORD=secret

# Config personnalisée MySQL
COPY my.cnf /etc/mysql/conf.d/my.cnf

# Script d'initialisation
COPY init.sql /docker-entrypoint-initdb.d/

# Port MySQL
EXPOSE 3306
