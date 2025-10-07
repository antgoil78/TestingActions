#!/bin/bash
set -e

echo "Starting Prefect 3 server..."

# Set proper API URL (use your Snowflake endpoint!)
export PREFECT_API_URL="http://0.0.0.0:4200/api"
export PREFECT_UI_URL="http://0.0.0.0:4200"

prefect server start --host 0.0.0.0 --port 4200 &
sleep 10

echo "Starting Prefect worker..."
prefect worker start --pool "snowflake"
