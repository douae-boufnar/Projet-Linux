# Étape 1 : Build Angular
FROM node:20 AS build

WORKDIR /app

# Copier uniquement les fichiers de dépendances (optimisation cache)
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du projet
COPY . .

# Build en production
RUN npm run build

# Étape 2 : Nginx (serveur web)
FROM nginx:alpine

# Copier les fichiers build Angular ( adapte le nom du projet)
COPY --from=build /app/dist/connectme-app/ /usr/share/nginx/html/

# Copier la config Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port
EXPOSE 80

# Lancer Nginx
CMD ["nginx", "-g", "daemon off;"]
