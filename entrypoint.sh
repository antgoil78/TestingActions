#!/bin/bash
set -e

# -----------------------------------------------
# IMPORTANT: Set this to your Snowflake service endpoint
# Example: ifztue-vymkbmw-ov24823.snowflakecomputing.app
# -----------------------------------------------
export PREFECT_API_URL="https://ifztue-vymkbmw-ov24823.snowflakecomputing.app/api"
export PREFECT_TELEMETRY_ENABLED=false

# Start Prefect server in background
echo "Starting Prefect Server..."
prefect server start --host 0.0.0.0 --port 4200 &
SERVER_PID=$!

# Give the server some time to initialize
sleep 15

# Start Prefect worker attached to 'snowflake' pool
echo "Starting Prefect Worker..."
prefect worker start --pool "snowflake"

# Wait for server process (optional)
wait $SERVER_PID
