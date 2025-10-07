#!/bin/bash
set -e

# ---- CONFIGURATION ----
# External URL for the UI (public ingress from Snowflake)
export PREFECT_API_URL="https://ifztue-vymkbmw-ov24823.snowflakecomputing.app/api"

# Internal URL inside the container (worker talks to local server)
export PREFECT_API_INTERNAL="http://127.0.0.1:4200/api"

# Disable telemetry (optional)
export PREFECT_TELEMETRY_ENABLED=false

# ---- START PREFECT SERVER ----
echo "Starting Prefect Server..."
prefect server start --host 0.0.0.0 --port 4200 &

# Give server a few seconds to initialize
sleep 15

# ---- START WORKER ----
echo "Starting Prefect Worker..."
# Worker connects to local server inside container
prefect worker start --api "$PREFECT_API_INTERNAL" -q snowflake
