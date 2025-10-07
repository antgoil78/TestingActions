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

# Run Prefect server locally
echo "Starting Prefect server..."
prefect server start --host 0.0.0.0 --port 4200 &

# Wait a few seconds for the server to be ready
sleep 15

# Set API URL for worker
export PREFECT_API_URL="http://127.0.0.1:4200/api"

echo "Testing.."
curl http://127.0.0.1:4200/api

echo "Starting Prefect worker..."
prefect worker start --pool "snowflake"
