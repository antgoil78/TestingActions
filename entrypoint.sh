#!/bin/bash
set -e

# Disable telemetry to avoid DNS lookups that can fail in Snowflake
export PREFECT_TELEMETRY_ENABLED=false

# Start Prefect server in background
echo "Starting Prefect Server..."
prefect server start --host 0.0.0.0 --port 4200 &
SERVER_PID=$!

# Wait for the API to become reachable
echo "Waiting for Prefect API to become available..."
for i in {1..30}; do
    if curl -s http://127.0.0.1:4200/api > /dev/null; then
        echo "Prefect API is up!"
        break
    fi
    echo "Still waiting for Prefect API... ($i/30)"
    sleep 2
done

# Set API URL to the local Prefect server inside the container
export PREFECT_API_URL="http://127.0.0.1:4200/api"

# Start Prefect worker
echo "Starting Prefect Worker..."
prefect worker start --pool "snowflake"

# Keep the server running
wait $SERVER_PID
