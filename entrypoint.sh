#!/bin/bash
set -e

# -----------------------------
# Configuration
# -----------------------------

# The Snowflake service endpoint that exposes the UI/API externally
EXTERNAL_API_URL="https://ifztue-vymkbmw-ov24823.snowflakecomputing.app:4200/api"

# Set environment variable so UI knows where the API is
export PREFECT_API_URL="$EXTERNAL_API_URL"

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

