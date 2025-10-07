#!/bin/bash
set -e

echo "Starting Prefect Worker..."
prefect worker start --pool "snowflake"
