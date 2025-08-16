# SECURITY.md

## Threat model (high level)

- Use bitnami/nginx for Reverse proxy (Nginx) only exposes port 8080 locally
- App runs as a non-root user
- Database is internal-only (no published port by default)
- Compose config uses `read_only`, `cap_drop: [ALL]`, and `no-new-privileges`
- Temporary directories are provided via `tmpfs`

## Hardening checklist

- [x] Non-root user in app container
- [x] Drop all Linux capabilities for app and nginx containers
- [x] Read-only root filesystem (tmpfs for `/tmp` and cache)
- [x] Minimal base images
- [x] Health endpoints for liveness checks
- [x] Environment variables for secrets (do not bake into images)

## Next steps (optional)

- Enable HTTPS with real certificates in Nginx
- Add CI pipeline with: `trivy` (image scan), `bandit` (code scan), `gitleaks` (secret scan)
- Add rate limiting in Nginx
- Add CSP nonces or hashes for production frontends