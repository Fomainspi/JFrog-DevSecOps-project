# Use a maintained Python slim image; update and scan this base regularly.
FROM python:3.12-slim

WORKDIR /app

# Install only runtime dependencies.
COPY requirements.txt .
RUN pip install --no-cache-dir --no-compile -r requirements.txt

# Create an unprivileged runtime identity.
RUN groupadd --system appuser \
    && useradd --system --gid appuser --create-home appuser

COPY app/app.py ./app.py

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health', timeout=2)"

CMD ["python", "app.py"]
