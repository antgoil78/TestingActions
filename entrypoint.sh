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
    if curl -s $PREFECT_API_URL > /dev/null; then
        echo "Prefect API is up!"
        break
    fi
    sleep 2
done

# Create work-pool (ignore if exists)
prefect work-pool create --type process snowflake || true

# Deploy flow (ignore if already deployed)
prefect deploy flows/dbt_flow_sdl_mcc_ref.py:dbt_sdl_mcc_ref_flow --name "SDL_MCC_REF Deployment" --pool "snowflake" || true

echo "Starting Prefect Worker..."
prefect worker start --pool "snowflake" &

# Give the worker a few seconds to start
sleep 5

# Trigger the flow run automatically
echo "Triggering first flow run..."
prefect deployment run "SDL_MCC_REF Deployment"

wait $SERVER_PID
