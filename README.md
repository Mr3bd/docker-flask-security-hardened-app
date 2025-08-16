# Dockerized Flask App with Security Hardening

A production-ready template that demonstrates security-conscious containerization of a simple Flask app behind Nginx with PostgreSQL.
This project focuses on secure defaults: non-root user, minimal base image, dropped Linux capabilities, read-only filesystem, and clear separation of concerns.

## 🔐 Features

- Flask app served by Gunicorn
- Use bitnami/nginx for Nginx reverse proxy with security headers
- PostgreSQL database with example connectivity check
- Multi-stage Docker build with a non-root user
- Dropped capabilities, no-new-privileges, read-only root FS (via Docker Compose)
- Minimal attack surface and reproducible local dev experience

## 🧰 Environment variables

Create `.env` file in the root of project, change values as needed:

```
# App
APP_PORT=8000

# Database
POSTGRES_DB=appdb
POSTGRES_USER=appuser
POSTGRES_PASSWORD=apppassword
POSTGRES_HOST=db
POSTGRES_PORT=5432
DATABASE_URL=postgresql://appuser:apppassword@db:5432/appdb
```

## 🚀 Quick start

1) Start the stack:
```bash
docker compose up --build -d
```

2) Visit the app:
- App via Nginx: http://localhost:8080
- Health check: http://localhost:8080/healthz
- DB check: http://localhost:8080/db-check

3) Tear down (If you need stop the containers):
```bash
docker compose down -v
```

## 📁 Project structure

```
docker-flask-hardened-app/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env
├── README.md
├── SECURITY.md
├── LICENSE
├── app/
│   ├── app.py
│   ├── wsgi.py
│   └── requirements.txt
└── nginx/
    └── nginx.conf
```

## 🔐 Security hardening highlights

- Runs as an unprivileged user
- Read-only filesystem with tmpfs mounts for runtime dirs
- Drops all Linux capabilities, adds `no-new-privileges`
- Minimal Python base image and multi-stage build
- Nginx ships strict security headers (HSTS disabled by default for localhost)
- Secrets and DB credentials are loaded from environment variables (no secrets in the image)

## ✅ Production notes

- For HTTPS, terminate TLS at Nginx using real certificates (e.g., via a proper reverse proxy or cert manager)
- Configure backups, monitoring, and secrets management in your environment
- Consider enabling HSTS in `nginx.conf` once you serve HTTPS
- Set resource limits based on your workload and environment

## 🌟 Star this repo if you find it useful!

Made with 💻 by a Cloud Security Engineer, for Cloud Security and DevSecOps Engineers.


## 👨‍💻 Author

[Abdullrahman Wasfi](https://www.linkedin.com/in/abdullrahmanwasfi)

Made with ❤️ using Dokcer, Nginx and Python