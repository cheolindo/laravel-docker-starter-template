![Docker](https://img.shields.io/badge/Docker-Ready-blue)
![Laravel](https://img.shields.io/badge/Laravel-11-red)
![License](https://img.shields.io/badge/license-MIT-green)

# 🚀 Laravel Local Dev Template


Esta plantilla está pensada para desarrolladores que desean iniciar proyectos Laravel de forma rápida y confiable en entornos locales. Incluye configuración completa con soporte para colas, caché, correo, HTTPS local y herramientas de monitoreo como Horizon y Supervisor.

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

- edita el archivo .env raíz
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

- edita ./docker/nginx/default.confg
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
│       └── supervisord.conf
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

## ✅ ¿Que sigue?
Ya que tienes todo el entorno montado puedes trabajar con laravel como normalmente lo haces.
Verifica que todo esté funcionando correctamente.
```bash
make open            # Abre el proyecto en el navegador
make phpmyadmin      # Abre la interfaz phpmyadmin en el navegador [usuario:root, password: secret] o los que definiste en el .env raiz
make mailhog         # (Opcional) Abre la interfaz mailhog en el navegador
```
## 🔗 Configurar tu proyecto Laravel si no lo has hecho.
```bash
APP_URL=https://nombre-de-tu-proyecto.test    #copia la url de tu proyecto, el cual optienes al ejecutar "make open"
DB_CONNECTION=mysql                           
DB_HOST=mysql                                 #debe coincidir con el nombre del servicio en docker-compose.yml por defecto "mysql"
DB_PORT=3306                                  #debe coincidir con el puerto definido en docker-compose.yml por defecto "3306"
DB_DATABASE=[APP_NAME]-db                     #APP_NAME del .env raiz, también puedes encontrar la DB al lanzar "make phpmyadmin"
DB_USERNAME=root                              
DB_PASSWORD=secret                            #debe coincidir con  MYSQL_ROOT_PASSWORD en docker-compose.yml


##Opcionales si decides utilizar redis##

SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
CACHE_DRIVER=redis
REDIS_CLIENT=phpredis
REDIS_HOST=redis
REDIS_PORT=6379                               #debe coincidir con el puerto definido en docker-compose.yml por defecto "6379"

##Opcionales si decides utilizar mailhog para tus pruebas de email##

MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025                               #En algunos casos debe coincidir con el puerto definido en docker-compose.yml
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="admin@nombre-de-tu-proyecto.test"
MAIL_FROM_NAME="${APP_NAME}"
```

```bash
make ssh-app                  # Entras al contenedor para ejecutar comandos de Artisan o trabajar todo lo que tiene que ver con laravel
php artisan config:clear      # para limpiar la cache y se apliquen los cambios realizados en el archivo .env
php artisan migrate           # Ejecutamos migraciones y así verificamos que la conexión a la DB esta funcionando
```

---

## ✅ Comprobar mailhog
```bash
make open            # Abre el proyecto en el navegador
make mailhog         # (Opcional) Abre la interfaz mailhog en el navegador
make ssh-app         # Entras al contenedor para ejecutar comandos de Artisan o trabajar todo lo que tiene que ver con laravel

##creamos un mailer de prueba

php artisan make:mail TestMail --markdown=emails.test

##creamos una ruta para enviar el email de pruebas

use Illuminate\Support\Facades\Mail;
use App\Mail\TestMail;
Route::get('/test-mailer', function () {
    Mail::to('test@example.com')->send(new TestMail('Este correo fue enviado desde la ruta /test-mailer.'));
    return 'Correo en cola. Verifica Mailhog.';
});

#Accedemos a la ruta /test-mailer
#en la interfaz de mailhog deberiamos ver el mensaje

```

<img width="1408" alt="image" src="https://github.com/user-attachments/assets/1d37c28a-b44c-416c-b321-2799984031d8" />



## ✅ Instalar y Comprobar Horizon


```bash
make open            # Abre el proyecto en el navegador
make ssh-app         # Entras al contenedor para ejecutar comandos de Artisan o trabajar todo lo que tiene que ver con laravel

##Instalamos horizon
composer require laravel/horizon
php artisan horizon:install

#Accedemos a la ruta /horizon
#Horizon funciona con redis así que nos aseguramos de tener configurada las opciones en el .env
QUEUE_CONNECTION=redis

#Lanza un Job para testear
#En tu ruta /test-mailer, asegúrate de usar ->queue() en lugar de ->send():
# Asegúrate de que el mailer implemente la cola [implements ShouldQueue]

#accedemos a la ruta /test-mailer para crear el job
#accedemos a la ruta /horizon para visualizar los jobs
#en este punto deverías ver el job completado ya que esta plantilla viene con supervisor configurado 

```
<img width="1422" alt="image" src="https://github.com/user-attachments/assets/d4424c44-b52b-4702-b9dc-3d1334d74334" />

---

## ✅ ¿Por qué usar esta plantilla?
	•	Ahorra tiempo configurando tu entorno local.
	•	Compatible con Horizon y Supervisor desde el inicio.
	•	Ideal para equipos y freelance que trabajan con Laravel profesionalmente.
	•	Perfecta como base para microservicios Laravel o proyectos modulares.

---

## 🧪 Testeado en
	•	Laravel 11
	•	Docker 24+
	•	Ubuntu / MacOS

---

## 🤝 Contribuciones

¡Las contribuciones son bienvenidas! Puedes hacer fork o abrir issues para sugerencias o mejoras.

---

### © Licencia

MIT © Magicotools LTD

