# Use the official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install build deps (optional, helps some Python wheels)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
  && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all app files
COPY . .

# Set environment variables
ENV PYTHONUNBUFFERED=1
# sensible default port (Cloud Run will override PORT at runtime)
ENV PORT=8080

# Expose the port Cloud Run expects
EXPOSE 8080

# Use Gunicorn with Uvicorn worker for FastAPI
# Note: use sh -c so ${PORT} is expanded at container runtime
CMD ["sh", "-c", "gunicorn -k uvicorn.workers.UvicornWorker decrypt_api:app --bind 0.0.0.0:${PORT}"]
