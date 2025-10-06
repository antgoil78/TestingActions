#!/bin/bash
set -e

echo "Starting Prefect Orion server..."
# Run Orion in foreground, bind to 0.0.0.0 so Snowflake can route traffic
prefect server start --host 0.0.0.0 --port 4200 &

sleep 5

echo "Starting Prefect agent..."
# Run agent in foreground so container stays alive
prefect agent start -q snowflake

