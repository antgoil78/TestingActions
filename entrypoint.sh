#!/bin/bash
set -e

echo "Starting Prefect server..."
prefect server start --host 0.0.0.0 --port 4200 &
sleep 15

export PREFECT_API_URL="http://127.0.0.1:4200/api"

echo "Starting Prefect worker..."
prefect worker start --pool "snowflake"

