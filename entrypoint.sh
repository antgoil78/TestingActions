#!/bin/bash
set -e

# -----------------------------
# Configuration
# -----------------------------

# The Snowflake service endpoint that exposes the UI/API externally
export PREFECT_API_URL="http://127.0.0.1:4200/api"

# Disable telemetry if needed (optional)
export PREFECT_TELEMETRY_ENABLED=false

# -----------------------------
# Start Prefect server
# -----------------------------
echo "Starting Prefect server..."
prefect server start --host 0.0.0.0 --port 4200 &

# Wait a few seconds to ensure the server is up
sleep 15

# -----------------------------
# Start Prefect worker
# -----------------------------
echo "Starting Prefect worker..."
# Create a pool 'snowflake' if it doesn't exist and start worker
prefect worker start --pool "snowflake" &

# -----------------------------
# Keep container alive
# -----------------------------
wait

