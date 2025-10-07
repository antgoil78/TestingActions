#!/bin/bash
set -e

echo "Starting Prefect server..."

# Start Orion with correct host and external API URL
prefect server start \
  --host 0.0.0.0 \
  --port 4200 \
  --expose-api "https://abztue-vymkbmw-ov24823.snowflakecomputing.app:4200" &
sleep 10

echo "Starting Prefect worker..."
prefect worker start --pool "snowflake"
