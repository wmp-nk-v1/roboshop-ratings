FROM docker.io/library/python:3.12-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt -t /deps

FROM docker.io/redhat/ubi9:latest
RUN dnf install -y python3.12 python3.12-pip && dnf clean all
WORKDIR /app
COPY --from=builder /deps /app/deps
ENV PYTHONPATH=/app/deps
COPY app.py .
EXPOSE 8080
CMD ["sh", "-c", "python3.12 -m gunicorn -b 0.0.0.0:${PORT:-8080} -w 2 app:app"]
