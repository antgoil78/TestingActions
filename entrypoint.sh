#!/bin/bash
set -e

# -----------------------------------------------
# IMPORTANT: Set this to your Snowflake service endpoint
# Example: ifztue-vymkbmw-ov24823.snowflakecomputing.app
# -----------------------------------------------
export PREFECT_API_URL="https://ifztue-vymkbmw-ov24823.snowflakecomputing.app/api"
export PREFECT_TELEMETRY_ENABLED=false

echo "Starting Prefect Worker..."
prefect worker start --pool "snowflake"
