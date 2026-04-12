FROM node:22-alpine AS frontend-builder

WORKDIR /app

# Next.js app lives in saas/
COPY saas/package.json saas/package-lock.json ./
RUN npm ci

COPY saas/ ./

ARG NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY
ENV NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_Y2FyZWZ1bC1sZWVjaC0yMC5jbGVyay5hY2NvdW50cy5kZXYk

RUN npm run build

FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Full api package (server.py, index.py, main.py, pyproject.toml, etc.)
COPY api/ ./api/

# Static export must live next to server.py — it uses Path("static") relative to cwd
COPY --from=frontend-builder /app/out ./api/static

WORKDIR /app/api

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"

EXPOSE 8000

CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8000"]
