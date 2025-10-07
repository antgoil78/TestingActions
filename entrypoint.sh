#!/bin/bash
set -e

echo "Starting Prefect server..."

# Bind to all interfaces so Snowflake can proxy traffic
prefect server start --host 0.0.0.0 --port 4200 &
sleep 10

echo "Starting Prefect worker..."
prefect worker start --pool "snowflake"

