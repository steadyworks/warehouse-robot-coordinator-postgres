#!/bin/bash
set -e

# Start PostgreSQL
pg_ctlcluster 16 main start

# Wait until postgres is ready
for i in {1..60}; do
  if pg_isready -U postgres > /dev/null 2>&1; then
    break
  fi
  sleep 1
done

python3 /app/backend/main.py &
node /app/frontend/server.js &
