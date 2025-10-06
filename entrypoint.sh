#!/bin/bash
set -e

echo "Starting Prefect 3 Server..."
prefect server start --host 0.0.0.0 --port 4200
