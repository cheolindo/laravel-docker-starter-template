# 🚀 Laravel Starter Template con Docker

Plantilla de desarrollo para proyectos Laravel utilizando Docker, lista para usar con MySQL, Redis, Mailhog, certificados SSL locales y PhpmyAdmin.

---

## ✨ Características

- Laravel 11 listo para usar
- PHP 8.2
- MySQL con acceso por root
- Redis configurado para caché, colas y sesiones
- Mailhog para pruebas de correo
- HTTPS local con certificados generados automáticamente
- PhpMyAdmin incluido
- Makefile para automatizar tareas
- Configuración flexible mediante `.env`

---

## 📦 Requisitos

- [Docker](https://www.docker.com/)
- [mkcert](https://github.com/FiloSottile/mkcert) (para certificados SSL locales)
- [GNU Make](https://www.gnu.org/software/make/) (ya viene preinstalado en macOS)

---

## ⚙️ Instalación

```bash
git clone https://github.com/cheolindo/laravel-docker-starter-template.git myapp
cd myapp
``` 
- edit the file .env
    - APP_NAME=myapp-name
    - DOMAIN_NAME=myapp-name.test
    - LARAVEL_VERSION=11
    - APP_HTTP_PORT=8888             #cambiar para evitar conflicto de puertos si es necesario
    - APP_HTTPS_PORT=4433            #cambiar para evitar conflicto de puertos si es necesario
    - MYSQL_PORT=3407                #cambiar para evitar conflicto de puertos si es necesario
    - REDIS_PORT=6480                #cambiar para evitar conflicto de puertos si es necesario
    - MAILHOG_HTTP_PORT=9025         #cambiar para evitar conflicto de puertos si es necesario
    - PHPMYADMIN_PORT=8089           #cambiar para evitar conflicto de puertos si es necesario
    - DB_PASSWORD=secret              
    - MYSQL_USER=laravel
 
- edit ./docker/nginx/default.confg
    - server_name myapp-name.test;     #cambiar "myapp-name.test" con el mismo DOMAIN_NAME
    - ssl_certificate /etc/nginx/certs/myapp-name.test.pem; #cambiar "myapp-name.test" con el mismo DOMAIN_NAME
    - ssl_certificate_key /etc/nginx/certs/myapp-name.test-key.pem;  #cambiar "myapp-name.test" con el mismo DOMAIN_NAME

```bash
make ssl         # Genera certificados locales
make init        # Inicializa el proyecto Laravel
```

   server_name hostingapp.test;

    root /var/www/html/public;
    index index.php index.html;

    ssl_certificate /etc/nginx/certs/hostingapp.test.pem;
    ssl_certificate_key /etc/nginx/certs/hostingapp.test-key.pem;

## 🧪 Servicios disponibles

| Servicio | URL | Puerto |
|-----------|-----------|-----------|
| App (HTTP)  | http://myapp.test:8888  | 8888  |
| App (HTTPS)  | https://myapp.test:4433  | 4433  |
| PhpMyAdmin  | http://localhost:8889  | 8889  |
| Mailhog  | http://localhost:9025  | 9025  |

Puedes modificar los puertos desde el archivo .env.

---

## 🛠 Comandos útiles (Makefile)


```bash
make up              # Levanta los contenedores
make down            # Detiene y elimina los contenedores
make restart         # Reinicia el entorno
make composer-install # Instala dependencias PHP
make npm-install     # Instala dependencias JS
make logs            # Ver logs de todos los servicios
make ssh-app         # Accede al contenedor de la app
make ssl             # Genera certificados SSL locales
```
---

## 🔗 Variables del entorno


```env
APP_NAME=juanjo
APP_DOMAIN=myapp.test

APP_HTTP_PORT=8888
APP_HTTPS_PORT=4433
MYSQL_PORT=3407
REDIS_PORT=6480
MAILHOG_HTTP_PORT=9025
PHPMYADMIN_PORT=8889

DB_DATABASE=juanjo-laravel-starter-template-db
DB_USERNAME=root
DB_PASSWORD=root          # Genera certificados SSL locales
```
---

## 🧰 Estructura del proyecto
```bash
.
├── docker/                  # Configuración de servicios
│   ├── nginx/
│   ├── mysql/
│   ├── php/
│   └── redis/
├── docker-compose.yml
├── Makefile
├── .env
├── .env.example
├── .gitignore
└── src/                     # Proyecto Laravel (se crea automáticamente)
```
---

## ✅ ¿Cómo usar esta plantilla para otro proyecto?

-	Clona este repositorio.
-	Cambia los valores en .env (como el nombre del dominio o puertos).
-	Ejecuta.
  
```bash
make ssl         # Genera certificados locales
make init        # Inicializa el proyecto Laravel
```

---



