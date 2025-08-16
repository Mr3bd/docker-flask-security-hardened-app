# syntax=docker/dockerfile:1

############################
# Builder stage
############################
FROM python:3.12-slim AS builder

# Prevent Python from writing .pyc files and buffer stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1     PYTHONUNBUFFERED=1

# Install build deps for psycopg2 and clean up
RUN apt-get update && apt-get install -y --no-install-recommends     build-essential     gcc     libpq-dev     && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install dependencies into a virtualenv
COPY app/requirements.txt /tmp/requirements.txt
RUN python -m venv /opt/venv &&     /opt/venv/bin/pip install --upgrade pip &&     /opt/venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt

############################
# Final stage
############################
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1     PYTHONUNBUFFERED=1     PATH="/opt/venv/bin:$PATH"

# Install only runtime deps
RUN apt-get update && apt-get install -y --no-install-recommends     libpq5     && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -u 10001 -m appuser

WORKDIR /app

# Copy virtualenv and application code
COPY --from=builder /opt/venv /opt/venv
COPY app/ /app/

# Expose app port
EXPOSE 8000

# Switch to non-root user
USER 10001

# Run Gunicorn
CMD ["gunicorn", "-c", "gunicorn.conf.py", "wsgi:app"]