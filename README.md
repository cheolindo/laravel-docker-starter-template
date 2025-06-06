# 🚀 Laravel Docker Starter Template 

Todos los que necesitas para trabajar con laravel en docker.

Listo para usar, Incluye MySQL, Redis, Mailhog, certificados SSL locales, Horizon, Supervisor y PhpmyAdmin.

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
- Horizon y supervisor para monitorear y ejecutar las colas y jobs

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
Cambiar estos valores para evitar conflicto de puertos si es necesario*

- edit the file .env
    - APP_NAME=myapp-name
    - DOMAIN_NAME=myapp-name.test
    - LARAVEL_VERSION=11
    - APP_HTTP_PORT=8888             
    - APP_HTTPS_PORT=4433            
    - MYSQL_PORT=3407                
    - REDIS_PORT=6480                
    - MAILHOG_HTTP_PORT=1025         
    - PHPMYADMIN_PORT=8089           
    - DB_PASSWORD=secret              
    - MYSQL_USER=laravel


cambiar "myapp-name.test" con el mismo valor de DOMAIN_NAME

- edit ./docker/nginx/default.confg
    - server_name myapp-name.test;     
    - ssl_certificate /etc/nginx/certs/myapp-name.test.pem; 
    - ssl_certificate_key /etc/nginx/certs/myapp-name.test-key.pem; 

```bash
make ssl         # Genera certificados locales
make init        # Inicializa el proyecto Laravel
```
---

## 🧰 Estructura del proyecto
```bash
.
├── docker/                  # Configuración de servicios
│   ├── app/
│   │   └── dockerfile
│   ├── nginx/
│   │   ├── certs/
│   │   └── default.conf
│   └── supervisor/
│       ├── certs/
│       └── default.conf
├── docker-compose.yml
├── Makefile
├── .env
├── .gitignore
└── src/                     # Proyecto Laravel (se crea automáticamente)
```
---


## 🛠 Comandos útiles (Makefile)

```bash
make init            # Levanta los contenedores y ejecuta todos los comandos en una llamada
make up              # Levanta los contenedores
make down            # Detiene y elimina los contenedores
make restart         # Reinicia el entorno
make composer-install # Instala dependencias PHP
make npm-install     # Instala dependencias JS
make logs            # Ver logs de todos los servicios
make ssh-app         # Accede al contenedor de la app
make ssl             # Genera certificados SSL locales
make mailhog         # Abre la interfaz mailhog en el navegador
make phpmyadmin      # Abre la interfaz phpmyadmin en el navegador
make open            # Abre el proyecto en el navegador
```
---

## 🔗 Variables del entorno en laravel que deben coincidir con los valores en el archivo docker-compose.yml
```env
APP_URL=https://hostingapp.test
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=myapp-name-db
DB_USERNAME=root
DB_PASSWORD=secret

SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
CACHE_DRIVER=redis
REDIS_CLIENT=phpredis
REDIS_HOST=redis
REDIS_PORT=6379
MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="admin@hostingapp.test"
MAIL_FROM_NAME="${APP_NAME}"
```
---

## ✅ ¿Que sigue?
Ya que tines todo el entorno montado puedes trabajar con laravel como normalmente lo haces.
```bash
make ssh-app        # Entras al contenedor para ejecutar compandos de Artisan o trabajar todo lo que tiene que ver con laravel
```






