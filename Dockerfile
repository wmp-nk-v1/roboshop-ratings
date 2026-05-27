FROM docker.io/redhat/ubi9:latest
RUN dnf install -y python3.12 && dnf clean all && \
    python3.12 -m ensurepip && python3.12 -m pip install --upgrade pip
WORKDIR /app
COPY requirements.txt .
RUN python3.12 -m pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8006
CMD ["python3.12", "-m", "gunicorn", "-b", "0.0.0.0:8006", "-w", "2", "app:app"]
