from flask import Flask, jsonify
import os
import psycopg2
from urllib.parse import urlparse

def create_app():
    app = Flask(__name__)

    @app.get("/")
    def index():
        return jsonify(status="ok", message="Hello from a hardened Flask app")

    @app.get("/healthz")
    def healthz():
        return jsonify(status="ok")

    @app.get("/db-check")
    def db_check():
        dsn = os.getenv("DATABASE_URL")
        if not dsn:
            return jsonify(status="error", message="DATABASE_URL is not set"), 500
        try:
            conn = psycopg2.connect(dsn, connect_timeout=3)
            cur = conn.cursor()
            cur.execute("SELECT 1;")
            cur.fetchone()
            cur.close()
            conn.close()
            return jsonify(status="ok", db="reachable")
        except Exception as e:
            return jsonify(status="error", message=str(e)), 500

    return app

app = create_app()