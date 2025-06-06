# Cargar variables del .env
ifneq (,$(wildcard .env))
	include .env
	export
endif


## Iniciar todo
init: up  init-laravel  composer-install npm-install migrate breeze open


# Crear proyecto Laravel si no existe
init-laravel:
	docker-compose run --rm app test -f artisan || docker-compose run --rm app composer create-project laravel/laravel . $(LARAVEL_VERSION)

# Instalar dependencias PHP
composer-install:
	docker-compose run --rm app composer install

# Instalar dependencias Node
npm-install:
	docker-compose run --rm node npm install
	docker-compose run --rm node npm run build


# Instalar Breeze (Blade)
breeze:
	docker-compose run --rm app composer require laravel/breeze --dev
	docker-compose run --rm app php artisan breeze:install blade
	docker-compose run --rm app php artisan migrate --force
	docker-compose run --rm node npm install
	docker-compose run --rm node npm run build

# Ejecutar migraciones
migrate:
	docker-compose run --rm app php artisan migrate --force

up:
	docker-compose up -d --build

down:
	docker-compose down

restart:
	docker-compose down && docker-compose up -d --build


composer-install:
	docker-compose run --rm app composer install

logs:
	docker-compose logs -f

ssh-app:
	docker exec -it $(APP_NAME)-app bash

ssl:
	mkcert -install && \
	mkcert -key-file ./docker/nginx/certs/$(DOMAIN_NAME)-key.pem -cert-file ./docker/nginx/certs/$(DOMAIN_NAME).pem $(DOMAIN_NAME)

open:
	open https://$(DOMAIN_NAME):$(APP_HTTPS_PORT)

phpmyadmin:
	open http://localhost:$(PHPMYADMIN_PORT)

mailhog:
	open http://localhost:$(MAILHOG_HTTP_PORT)