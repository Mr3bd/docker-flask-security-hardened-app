bind = "0.0.0.0:8000"
workers = 2
threads = 2
timeout = 30
graceful_timeout = 30
worker_class = "gthread"
# Avoid writing access logs by default; enable if needed
accesslog = "-"
errorlog = "-"