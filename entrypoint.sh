#!/bin/bash
set -e

# Disable Prefect telemetry (avoids errors about unreachable Prefect Cloud)
export PREFECT_TELEMETRY_ENABLED=false

# Run Prefect server locally
echo "Starting Prefect server..."
prefect server start --host 0.0.0.0 --port 4200 &

# Wait a few seconds for the server to be ready
sleep 15

# Set API URL for worker
export PREFECT_API_URL="https://ifztue-vymkbmw-ov24823.snowflakecomputing.app:4200/api"

echo "Starting Prefect worker..."
prefect worker start --pool "snowflake"
