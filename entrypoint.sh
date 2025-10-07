#!/bin/bash
set -e

# ---- CONFIGURATION ----
# External URL for the UI (public ingress from Snowflake)
export PREFECT_API_URL="https://ifztue-vymkbmw-ov24823.snowflakecomputing.app/api"

# Disable telemetry (optional)
export PREFECT_TELEMETRY_ENABLED=false

# ---- START PREFECT SERVER ----
echo "Starting Prefect Server..."
prefect server start --host 0.0.0.0 --port 4200 &

# Give server some time to start
sleep 15

# ---- START WORKER ----
echo "Starting Prefect Worker..."
# No --api flag needed in Prefect 3.x
prefect worker start --pool "snowflake"

