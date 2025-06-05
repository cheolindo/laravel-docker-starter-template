# 🚀 Laravel Starter Template con Docker

Plantilla de desarrollo para proyectos Laravel utilizando Docker, lista para usar con MySQL, Redis, Mailhog y certificados SSL locales.

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
git clone https://github.com/TU_USUARIO/juanjo-laravel-starter-template.git myapp
cd myapp
cp .env.example .env
make ssl         # Genera certificados locales
make init        # Inicializa el proyecto Laravel
