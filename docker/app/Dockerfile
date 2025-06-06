FROM php:8.2-fpm

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev libssl-dev supervisor \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia archivos de configuración de Supervisor
COPY ./docker/supervisor/laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf
COPY ./docker/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

# Establece directorio de trabajo
WORKDIR /var/www/html

# Comando por defecto para arrancar supervisord
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]