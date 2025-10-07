#!/bin/bash
set -e

export PREFECT_TELEMETRY_ENABLED=false
export PREFECT_API_URL="http://127.0.0.1:4200/api"
export PREFECT_UI_API_URL="https://ifztue-vymkbmw-ov24823.snowflakecomputing.app/api"

echo "Starting Prefect Server..."
prefect server start --host 0.0.0.0 --port 4200 &
SERVER_PID=$!

echo "Waiting for Prefect API to become available..."
for i in {1..30}; do
    if curl -s http://127.0.0.1:4200/api > /dev/null; then
        echo "Prefect API is up!"
        break
    fi
    sleep 2
done

# Register your flow deployment
# echo "Registering flows..."
# prefect register -p /app/flows/run_dbt_model.py

echo "Starting Prefect Worker..."
prefect worker start --pool "snowflake"

wait $SERVER_PID
