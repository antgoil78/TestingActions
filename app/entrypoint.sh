#!/bin/bash
set -e

echo "Starting Prefect Orion server..."
prefect orion start --host 0.0.0.0 --port 4200 &
sleep 10

echo "Starting Prefect agent..."
prefect agent start -q snowflake
